//! FIXME: write short doc here
use std::{iter, sync::Arc};

use arrayvec::ArrayVec;
use base_db::{CrateDisplayName, CrateId, Edition, FileId};
use either::Either;
use hir_def::{
    adt::{ReprKind, StructKind, VariantData},
    expr::{BindingAnnotation, LabelId, Pat, PatId},
    import_map,
    item_tree::ItemTreeNode,
    lang_item::LangItemTarget,
    path::ModPath,
    per_ns::PerNs,
    resolver::{HasResolver, Resolver},
    src::HasSource as _,
    type_ref::{Mutability, TypeRef},
    AdtId, AssocContainerId, AssocItemId, AssocItemLoc, AttrDefId, ConstId, ConstParamId,
    DefWithBodyId, EnumId, FunctionId, GenericDefId, HasModule, ImplId, LifetimeParamId,
    LocalEnumVariantId, LocalFieldId, Lookup, ModuleId, StaticId, StructId, TraitId, TypeAliasId,
    TypeParamId, UnionId,
};
use hir_def::{find_path::PrefixKind, item_scope::ItemInNs, visibility::Visibility};
use hir_expand::{
    diagnostics::DiagnosticSink,
    name::{name, AsName},
    MacroDefId, MacroDefKind,
};
use hir_ty::{
    autoderef,
    display::{write_bounds_like_dyn_trait, HirDisplayError, HirFormatter},
    method_resolution,
    traits::{FnTrait, Solution, SolutionVariables},
    ApplicationTy, BoundVar, CallableDefId, Canonical, DebruijnIndex, FnSig, GenericPredicate,
    InEnvironment, Obligation, ProjectionPredicate, ProjectionTy, Substs, TraitEnvironment, Ty,
    TyDefId, TyKind, TypeCtor,
};
use rustc_hash::FxHashSet;
use stdx::{format_to, impl_from};
use syntax::{
    ast::{self, AttrsOwner, NameOwner},
    AstNode, SmolStr,
};
use tt::{Ident, Leaf, Literal, TokenTree};

use crate::{
    db::{DefDatabase, HirDatabase},
    has_source::HasSource,
    HirDisplay, InFile, Name,
};

/// hir::Crate describes a single crate. It's the main interface with which
/// a crate's dependencies interact. Mostly, it should be just a proxy for the
/// root module.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Crate {
    pub(crate) id: CrateId,
}

#[derive(Debug)]
pub struct CrateDependency {
    pub krate: Crate,
    pub name: Name,
}

impl Crate {
    pub fn dependencies(self, db: &dyn HirDatabase) -> Vec<CrateDependency> {
        db.crate_graph()[self.id]
            .dependencies
            .iter()
            .map(|dep| {
                let krate = Crate { id: dep.crate_id };
                let name = dep.as_name();
                CrateDependency { krate, name }
            })
            .collect()
    }

    // FIXME: add `transitive_reverse_dependencies`.
    pub fn reverse_dependencies(self, db: &dyn HirDatabase) -> Vec<Crate> {
        let crate_graph = db.crate_graph();
        crate_graph
            .iter()
            .filter(|&krate| {
                crate_graph[krate].dependencies.iter().any(|it| it.crate_id == self.id)
            })
            .map(|id| Crate { id })
            .collect()
    }

    pub fn root_module(self, db: &dyn HirDatabase) -> Module {
        let def_map = db.crate_def_map(self.id);
        Module { id: def_map.module_id(def_map.root()) }
    }

    pub fn root_file(self, db: &dyn HirDatabase) -> FileId {
        db.crate_graph()[self.id].root_file_id
    }

    pub fn edition(self, db: &dyn HirDatabase) -> Edition {
        db.crate_graph()[self.id].edition
    }

    pub fn display_name(self, db: &dyn HirDatabase) -> Option<CrateDisplayName> {
        db.crate_graph()[self.id].display_name.clone()
    }

    pub fn query_external_importables(
        self,
        db: &dyn DefDatabase,
        query: import_map::Query,
    ) -> impl Iterator<Item = Either<ModuleDef, MacroDef>> {
        import_map::search_dependencies(db, self.into(), query).into_iter().map(|item| match item {
            ItemInNs::Types(mod_id) | ItemInNs::Values(mod_id) => Either::Left(mod_id.into()),
            ItemInNs::Macros(mac_id) => Either::Right(mac_id.into()),
        })
    }

    pub fn all(db: &dyn HirDatabase) -> Vec<Crate> {
        db.crate_graph().iter().map(|id| Crate { id }).collect()
    }

    /// Try to get the root URL of the documentation of a crate.
    pub fn get_html_root_url(self: &Crate, db: &dyn HirDatabase) -> Option<String> {
        // Look for #![doc(html_root_url = "...")]
        let attrs = db.attrs(AttrDefId::ModuleId(self.root_module(db).into()));
        let doc_attr_q = attrs.by_key("doc");

        if !doc_attr_q.exists() {
            return None;
        }

        let doc_url = doc_attr_q.tt_values().map(|tt| {
            let name = tt.token_trees.iter()
                .skip_while(|tt| !matches!(tt, TokenTree::Leaf(Leaf::Ident(Ident{text: ref ident, ..})) if ident == "html_root_url"))
                .skip(2)
                .next();

            match name {
                Some(TokenTree::Leaf(Leaf::Literal(Literal{ref text, ..}))) => Some(text),
                _ => None
            }
        }).flat_map(|t| t).next();

        doc_url.map(|s| s.trim_matches('"').trim_end_matches('/').to_owned() + "/")
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Module {
    pub(crate) id: ModuleId,
}

/// The defs which can be visible in the module.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum ModuleDef {
    Module(Module),
    Function(Function),
    Adt(Adt),
    // Can't be directly declared, but can be imported.
    Variant(Variant),
    Const(Const),
    Static(Static),
    Trait(Trait),
    TypeAlias(TypeAlias),
    BuiltinType(BuiltinType),
}
impl_from!(
    Module,
    Function,
    Adt(Struct, Enum, Union),
    Variant,
    Const,
    Static,
    Trait,
    TypeAlias,
    BuiltinType
    for ModuleDef
);

impl From<VariantDef> for ModuleDef {
    fn from(var: VariantDef) -> Self {
        match var {
            VariantDef::Struct(t) => Adt::from(t).into(),
            VariantDef::Union(t) => Adt::from(t).into(),
            VariantDef::Variant(t) => t.into(),
        }
    }
}

impl ModuleDef {
    pub fn module(self, db: &dyn HirDatabase) -> Option<Module> {
        match self {
            ModuleDef::Module(it) => it.parent(db),
            ModuleDef::Function(it) => Some(it.module(db)),
            ModuleDef::Adt(it) => Some(it.module(db)),
            ModuleDef::Variant(it) => Some(it.module(db)),
            ModuleDef::Const(it) => Some(it.module(db)),
            ModuleDef::Static(it) => Some(it.module(db)),
            ModuleDef::Trait(it) => Some(it.module(db)),
            ModuleDef::TypeAlias(it) => Some(it.module(db)),
            ModuleDef::BuiltinType(_) => None,
        }
    }

    pub fn canonical_path(&self, db: &dyn HirDatabase) -> Option<String> {
        let mut segments = Vec::new();
        segments.push(self.name(db)?.to_string());
        for m in self.module(db)?.path_to_root(db) {
            segments.extend(m.name(db).map(|it| it.to_string()))
        }
        segments.reverse();
        Some(segments.join("::"))
    }

    pub fn definition_visibility(&self, db: &dyn HirDatabase) -> Option<Visibility> {
        let module = match self {
            ModuleDef::Module(it) => it.parent(db)?,
            ModuleDef::Function(it) => return Some(it.visibility(db)),
            ModuleDef::Adt(it) => it.module(db),
            ModuleDef::Variant(it) => {
                let parent = it.parent_enum(db);
                let module = it.module(db);
                return module.visibility_of(db, &ModuleDef::Adt(Adt::Enum(parent)));
            }
            ModuleDef::Const(it) => return Some(it.visibility(db)),
            ModuleDef::Static(it) => it.module(db),
            ModuleDef::Trait(it) => it.module(db),
            ModuleDef::TypeAlias(it) => return Some(it.visibility(db)),
            ModuleDef::BuiltinType(_) => return None,
        };

        module.visibility_of(db, self)
    }

    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        match self {
            ModuleDef::Adt(it) => Some(it.name(db)),
            ModuleDef::Trait(it) => Some(it.name(db)),
            ModuleDef::Function(it) => Some(it.name(db)),
            ModuleDef::Variant(it) => Some(it.name(db)),
            ModuleDef::TypeAlias(it) => Some(it.name(db)),
            ModuleDef::Module(it) => it.name(db),
            ModuleDef::Const(it) => it.name(db),
            ModuleDef::Static(it) => it.name(db),

            ModuleDef::BuiltinType(it) => Some(it.name()),
        }
    }

    pub fn diagnostics(self, db: &dyn HirDatabase, sink: &mut DiagnosticSink) {
        let id = match self {
            ModuleDef::Adt(it) => match it {
                Adt::Struct(it) => it.id.into(),
                Adt::Enum(it) => it.id.into(),
                Adt::Union(it) => it.id.into(),
            },
            ModuleDef::Trait(it) => it.id.into(),
            ModuleDef::Function(it) => it.id.into(),
            ModuleDef::TypeAlias(it) => it.id.into(),
            ModuleDef::Module(it) => it.id.into(),
            ModuleDef::Const(it) => it.id.into(),
            ModuleDef::Static(it) => it.id.into(),
            _ => return,
        };

        let module = match self.module(db) {
            Some(it) => it,
            None => return,
        };

        hir_ty::diagnostics::validate_module_item(db, module.id.krate(), id, sink)
    }
}

impl Module {
    /// Name of this module.
    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        let def_map = self.id.def_map(db.upcast());
        let parent = def_map[self.id.local_id].parent?;
        def_map[parent].children.iter().find_map(|(name, module_id)| {
            if *module_id == self.id.local_id {
                Some(name.clone())
            } else {
                None
            }
        })
    }

    /// Returns the crate this module is part of.
    pub fn krate(self) -> Crate {
        Crate { id: self.id.krate() }
    }

    /// Topmost parent of this module. Every module has a `crate_root`, but some
    /// might be missing `krate`. This can happen if a module's file is not included
    /// in the module tree of any target in `Cargo.toml`.
    pub fn crate_root(self, db: &dyn HirDatabase) -> Module {
        let def_map = db.crate_def_map(self.id.krate());
        Module { id: def_map.module_id(def_map.root()) }
    }

    /// Iterates over all child modules.
    pub fn children(self, db: &dyn HirDatabase) -> impl Iterator<Item = Module> {
        let def_map = self.id.def_map(db.upcast());
        let children = def_map[self.id.local_id]
            .children
            .iter()
            .map(|(_, module_id)| Module { id: def_map.module_id(*module_id) })
            .collect::<Vec<_>>();
        children.into_iter()
    }

    /// Finds a parent module.
    pub fn parent(self, db: &dyn HirDatabase) -> Option<Module> {
        // FIXME: handle block expressions as modules (their parent is in a different DefMap)
        let def_map = self.id.def_map(db.upcast());
        let parent_id = def_map[self.id.local_id].parent?;
        Some(Module { id: def_map.module_id(parent_id) })
    }

    pub fn path_to_root(self, db: &dyn HirDatabase) -> Vec<Module> {
        let mut res = vec![self];
        let mut curr = self;
        while let Some(next) = curr.parent(db) {
            res.push(next);
            curr = next
        }
        res
    }

    /// Returns a `ModuleScope`: a set of items, visible in this module.
    pub fn scope(
        self,
        db: &dyn HirDatabase,
        visible_from: Option<Module>,
    ) -> Vec<(Name, ScopeDef)> {
        self.id.def_map(db.upcast())[self.id.local_id]
            .scope
            .entries()
            .filter_map(|(name, def)| {
                if let Some(m) = visible_from {
                    let filtered =
                        def.filter_visibility(|vis| vis.is_visible_from(db.upcast(), m.id));
                    if filtered.is_none() && !def.is_none() {
                        None
                    } else {
                        Some((name, filtered))
                    }
                } else {
                    Some((name, def))
                }
            })
            .flat_map(|(name, def)| {
                ScopeDef::all_items(def).into_iter().map(move |item| (name.clone(), item))
            })
            .collect()
    }

    pub fn visibility_of(self, db: &dyn HirDatabase, def: &ModuleDef) -> Option<Visibility> {
        self.id.def_map(db.upcast())[self.id.local_id].scope.visibility_of(def.clone().into())
    }

    pub fn diagnostics(self, db: &dyn HirDatabase, sink: &mut DiagnosticSink) {
        let _p = profile::span("Module::diagnostics").detail(|| {
            format!("{:?}", self.name(db).map_or("<unknown>".into(), |name| name.to_string()))
        });
        let crate_def_map = self.id.def_map(db.upcast());
        crate_def_map.add_diagnostics(db.upcast(), self.id.local_id, sink);
        for decl in self.declarations(db) {
            match decl {
                crate::ModuleDef::Function(f) => f.diagnostics(db, sink),
                crate::ModuleDef::Module(m) => {
                    // Only add diagnostics from inline modules
                    if crate_def_map[m.id.local_id].origin.is_inline() {
                        m.diagnostics(db, sink)
                    }
                }
                _ => {
                    decl.diagnostics(db, sink);
                }
            }
        }

        for impl_def in self.impl_defs(db) {
            for item in impl_def.items(db) {
                if let AssocItem::Function(f) = item {
                    f.diagnostics(db, sink);
                }
            }
        }
    }

    pub fn declarations(self, db: &dyn HirDatabase) -> Vec<ModuleDef> {
        let def_map = self.id.def_map(db.upcast());
        def_map[self.id.local_id].scope.declarations().map(ModuleDef::from).collect()
    }

    pub fn impl_defs(self, db: &dyn HirDatabase) -> Vec<Impl> {
        let def_map = self.id.def_map(db.upcast());
        def_map[self.id.local_id].scope.impls().map(Impl::from).collect()
    }

    /// Finds a path that can be used to refer to the given item from within
    /// this module, if possible.
    pub fn find_use_path(self, db: &dyn DefDatabase, item: impl Into<ItemInNs>) -> Option<ModPath> {
        hir_def::find_path::find_path(db, item.into(), self.into())
    }

    /// Finds a path that can be used to refer to the given item from within
    /// this module, if possible. This is used for returning import paths for use-statements.
    pub fn find_use_path_prefixed(
        self,
        db: &dyn DefDatabase,
        item: impl Into<ItemInNs>,
        prefix_kind: PrefixKind,
    ) -> Option<ModPath> {
        hir_def::find_path::find_path_prefixed(db, item.into(), self.into(), prefix_kind)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Field {
    pub(crate) parent: VariantDef,
    pub(crate) id: LocalFieldId,
}

#[derive(Debug, PartialEq, Eq)]
pub enum FieldSource {
    Named(ast::RecordField),
    Pos(ast::TupleField),
}

impl Field {
    pub fn name(&self, db: &dyn HirDatabase) -> Name {
        self.parent.variant_data(db).fields()[self.id].name.clone()
    }

    /// Returns the type as in the signature of the struct (i.e., with
    /// placeholder types for type parameters). This is good for showing
    /// signature help, but not so good to actually get the type of the field
    /// when you actually have a variable of the struct.
    pub fn signature_ty(&self, db: &dyn HirDatabase) -> Type {
        let var_id = self.parent.into();
        let generic_def_id: GenericDefId = match self.parent {
            VariantDef::Struct(it) => it.id.into(),
            VariantDef::Union(it) => it.id.into(),
            VariantDef::Variant(it) => it.parent.id.into(),
        };
        let substs = Substs::type_params(db, generic_def_id);
        let ty = db.field_types(var_id)[self.id].clone().subst(&substs);
        Type::new(db, self.parent.module(db).id.krate(), var_id, ty)
    }

    pub fn parent_def(&self, _db: &dyn HirDatabase) -> VariantDef {
        self.parent
    }
}

impl HasVisibility for Field {
    fn visibility(&self, db: &dyn HirDatabase) -> Visibility {
        let variant_data = self.parent.variant_data(db);
        let visibility = &variant_data.fields()[self.id].visibility;
        let parent_id: hir_def::VariantId = self.parent.into();
        visibility.resolve(db.upcast(), &parent_id.resolver(db.upcast()))
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Struct {
    pub(crate) id: StructId,
}

impl Struct {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        Module { id: self.id.lookup(db.upcast()).container.module(db.upcast()) }
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Option<Crate> {
        Some(self.module(db).krate())
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        db.struct_data(self.id).name.clone()
    }

    pub fn fields(self, db: &dyn HirDatabase) -> Vec<Field> {
        db.struct_data(self.id)
            .variant_data
            .fields()
            .iter()
            .map(|(id, _)| Field { parent: self.into(), id })
            .collect()
    }

    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        Type::from_def(
            db,
            self.id.lookup(db.upcast()).container.module(db.upcast()).krate(),
            self.id,
        )
    }

    pub fn repr(self, db: &dyn HirDatabase) -> Option<ReprKind> {
        db.struct_data(self.id).repr.clone()
    }

    pub fn kind(self, db: &dyn HirDatabase) -> StructKind {
        self.variant_data(db).kind()
    }

    fn variant_data(self, db: &dyn HirDatabase) -> Arc<VariantData> {
        db.struct_data(self.id).variant_data.clone()
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Union {
    pub(crate) id: UnionId,
}

impl Union {
    pub fn name(self, db: &dyn HirDatabase) -> Name {
        db.union_data(self.id).name.clone()
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        Module { id: self.id.lookup(db.upcast()).container.module(db.upcast()) }
    }

    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        Type::from_def(
            db,
            self.id.lookup(db.upcast()).container.module(db.upcast()).krate(),
            self.id,
        )
    }

    pub fn fields(self, db: &dyn HirDatabase) -> Vec<Field> {
        db.union_data(self.id)
            .variant_data
            .fields()
            .iter()
            .map(|(id, _)| Field { parent: self.into(), id })
            .collect()
    }

    fn variant_data(self, db: &dyn HirDatabase) -> Arc<VariantData> {
        db.union_data(self.id).variant_data.clone()
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Enum {
    pub(crate) id: EnumId,
}

impl Enum {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        Module { id: self.id.lookup(db.upcast()).container.module(db.upcast()) }
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Option<Crate> {
        Some(self.module(db).krate())
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        db.enum_data(self.id).name.clone()
    }

    pub fn variants(self, db: &dyn HirDatabase) -> Vec<Variant> {
        db.enum_data(self.id).variants.iter().map(|(id, _)| Variant { parent: self, id }).collect()
    }

    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        Type::from_def(
            db,
            self.id.lookup(db.upcast()).container.module(db.upcast()).krate(),
            self.id,
        )
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Variant {
    pub(crate) parent: Enum,
    pub(crate) id: LocalEnumVariantId,
}

impl Variant {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.parent.module(db)
    }
    pub fn parent_enum(self, _db: &dyn HirDatabase) -> Enum {
        self.parent
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        db.enum_data(self.parent.id).variants[self.id].name.clone()
    }

    pub fn fields(self, db: &dyn HirDatabase) -> Vec<Field> {
        self.variant_data(db)
            .fields()
            .iter()
            .map(|(id, _)| Field { parent: self.into(), id })
            .collect()
    }

    pub fn kind(self, db: &dyn HirDatabase) -> StructKind {
        self.variant_data(db).kind()
    }

    pub(crate) fn variant_data(self, db: &dyn HirDatabase) -> Arc<VariantData> {
        db.enum_data(self.parent.id).variants[self.id].variant_data.clone()
    }
}

/// A Data Type
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum Adt {
    Struct(Struct),
    Union(Union),
    Enum(Enum),
}
impl_from!(Struct, Union, Enum for Adt);

impl Adt {
    pub fn has_non_default_type_params(self, db: &dyn HirDatabase) -> bool {
        let subst = db.generic_defaults(self.into());
        subst.iter().any(|ty| &ty.value == &Ty::Unknown)
    }

    /// Turns this ADT into a type. Any type parameters of the ADT will be
    /// turned into unknown types, which is good for e.g. finding the most
    /// general set of completions, but will not look very nice when printed.
    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        let id = AdtId::from(self);
        Type::from_def(db, id.module(db.upcast()).krate(), id)
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        match self {
            Adt::Struct(s) => s.module(db),
            Adt::Union(s) => s.module(db),
            Adt::Enum(e) => e.module(db),
        }
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Option<Crate> {
        Some(self.module(db).krate())
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        match self {
            Adt::Struct(s) => s.name(db),
            Adt::Union(u) => u.name(db),
            Adt::Enum(e) => e.name(db),
        }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum VariantDef {
    Struct(Struct),
    Union(Union),
    Variant(Variant),
}
impl_from!(Struct, Union, Variant for VariantDef);

impl VariantDef {
    pub fn fields(self, db: &dyn HirDatabase) -> Vec<Field> {
        match self {
            VariantDef::Struct(it) => it.fields(db),
            VariantDef::Union(it) => it.fields(db),
            VariantDef::Variant(it) => it.fields(db),
        }
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        match self {
            VariantDef::Struct(it) => it.module(db),
            VariantDef::Union(it) => it.module(db),
            VariantDef::Variant(it) => it.module(db),
        }
    }

    pub fn name(&self, db: &dyn HirDatabase) -> Name {
        match self {
            VariantDef::Struct(s) => s.name(db),
            VariantDef::Union(u) => u.name(db),
            VariantDef::Variant(e) => e.name(db),
        }
    }

    pub(crate) fn variant_data(self, db: &dyn HirDatabase) -> Arc<VariantData> {
        match self {
            VariantDef::Struct(it) => it.variant_data(db),
            VariantDef::Union(it) => it.variant_data(db),
            VariantDef::Variant(it) => it.variant_data(db),
        }
    }
}

/// The defs which have a body.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum DefWithBody {
    Function(Function),
    Static(Static),
    Const(Const),
}
impl_from!(Function, Const, Static for DefWithBody);

impl DefWithBody {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        match self {
            DefWithBody::Const(c) => c.module(db),
            DefWithBody::Function(f) => f.module(db),
            DefWithBody::Static(s) => s.module(db),
        }
    }

    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        match self {
            DefWithBody::Function(f) => Some(f.name(db)),
            DefWithBody::Static(s) => s.name(db),
            DefWithBody::Const(c) => c.name(db),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Function {
    pub(crate) id: FunctionId,
}

impl Function {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.id.lookup(db.upcast()).module(db.upcast()).into()
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Option<Crate> {
        Some(self.module(db).krate())
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        db.function_data(self.id).name.clone()
    }

    /// Get this function's return type
    pub fn ret_type(self, db: &dyn HirDatabase) -> Type {
        let resolver = self.id.resolver(db.upcast());
        let ret_type = &db.function_data(self.id).ret_type;
        let ctx = hir_ty::TyLoweringContext::new(db, &resolver);
        let environment = TraitEnvironment::lower(db, &resolver);
        Type {
            krate: self.id.lookup(db.upcast()).container.module(db.upcast()).krate(),
            ty: InEnvironment { value: Ty::from_hir_ext(&ctx, ret_type).0, environment },
        }
    }

    pub fn self_param(self, db: &dyn HirDatabase) -> Option<SelfParam> {
        if !db.function_data(self.id).has_self_param {
            return None;
        }
        Some(SelfParam { func: self.id })
    }

    pub fn assoc_fn_params(self, db: &dyn HirDatabase) -> Vec<Param> {
        let resolver = self.id.resolver(db.upcast());
        let ctx = hir_ty::TyLoweringContext::new(db, &resolver);
        let environment = TraitEnvironment::lower(db, &resolver);
        db.function_data(self.id)
            .params
            .iter()
            .map(|type_ref| {
                let ty = Type {
                    krate: self.id.lookup(db.upcast()).container.module(db.upcast()).krate(),
                    ty: InEnvironment {
                        value: Ty::from_hir_ext(&ctx, type_ref).0,
                        environment: environment.clone(),
                    },
                };
                Param { ty }
            })
            .collect()
    }
    pub fn method_params(self, db: &dyn HirDatabase) -> Option<Vec<Param>> {
        if self.self_param(db).is_none() {
            return None;
        }
        let mut res = self.assoc_fn_params(db);
        res.remove(0);
        Some(res)
    }

    pub fn is_unsafe(self, db: &dyn HirDatabase) -> bool {
        db.function_data(self.id).is_unsafe
    }

    pub fn diagnostics(self, db: &dyn HirDatabase, sink: &mut DiagnosticSink) {
        let krate = self.module(db).id.krate();
        hir_def::diagnostics::validate_body(db.upcast(), self.id.into(), sink);
        hir_ty::diagnostics::validate_module_item(db, krate, self.id.into(), sink);
        hir_ty::diagnostics::validate_body(db, self.id.into(), sink);
    }

    /// Whether this function declaration has a definition.
    ///
    /// This is false in the case of required (not provided) trait methods.
    pub fn has_body(self, db: &dyn HirDatabase) -> bool {
        db.function_data(self.id).has_body
    }

    /// A textual representation of the HIR of this function for debugging purposes.
    pub fn debug_hir(self, db: &dyn HirDatabase) -> String {
        let body = db.body(self.id.into());

        let mut result = String::new();
        format_to!(result, "HIR expressions in the body of `{}`:\n", self.name(db));
        for (id, expr) in body.exprs.iter() {
            format_to!(result, "{:?}: {:?}\n", id, expr);
        }

        result
    }
}

// Note: logically, this belongs to `hir_ty`, but we are not using it there yet.
pub enum Access {
    Shared,
    Exclusive,
    Owned,
}

impl From<Mutability> for Access {
    fn from(mutability: Mutability) -> Access {
        match mutability {
            Mutability::Shared => Access::Shared,
            Mutability::Mut => Access::Exclusive,
        }
    }
}

#[derive(Debug)]
pub struct Param {
    ty: Type,
}

impl Param {
    pub fn ty(&self) -> &Type {
        &self.ty
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct SelfParam {
    func: FunctionId,
}

impl SelfParam {
    pub fn access(self, db: &dyn HirDatabase) -> Access {
        let func_data = db.function_data(self.func);
        func_data
            .params
            .first()
            .map(|param| match *param {
                TypeRef::Reference(.., mutability) => mutability.into(),
                _ => Access::Owned,
            })
            .unwrap_or(Access::Owned)
    }
}

impl HasVisibility for Function {
    fn visibility(&self, db: &dyn HirDatabase) -> Visibility {
        let function_data = db.function_data(self.id);
        let visibility = &function_data.visibility;
        visibility.resolve(db.upcast(), &self.id.resolver(db.upcast()))
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Const {
    pub(crate) id: ConstId,
}

impl Const {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        Module { id: self.id.lookup(db.upcast()).module(db.upcast()) }
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Option<Crate> {
        Some(self.module(db).krate())
    }

    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        db.const_data(self.id).name.clone()
    }
}

impl HasVisibility for Const {
    fn visibility(&self, db: &dyn HirDatabase) -> Visibility {
        let function_data = db.const_data(self.id);
        let visibility = &function_data.visibility;
        visibility.resolve(db.upcast(), &self.id.resolver(db.upcast()))
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Static {
    pub(crate) id: StaticId,
}

impl Static {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        Module { id: self.id.lookup(db.upcast()).module(db.upcast()) }
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Option<Crate> {
        Some(self.module(db).krate())
    }

    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        db.static_data(self.id).name.clone()
    }

    pub fn is_mut(self, db: &dyn HirDatabase) -> bool {
        db.static_data(self.id).mutable
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Trait {
    pub(crate) id: TraitId,
}

impl Trait {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        Module { id: self.id.lookup(db.upcast()).container.module(db.upcast()) }
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        db.trait_data(self.id).name.clone()
    }

    pub fn items(self, db: &dyn HirDatabase) -> Vec<AssocItem> {
        db.trait_data(self.id).items.iter().map(|(_name, it)| (*it).into()).collect()
    }

    pub fn is_auto(self, db: &dyn HirDatabase) -> bool {
        db.trait_data(self.id).auto
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct TypeAlias {
    pub(crate) id: TypeAliasId,
}

impl TypeAlias {
    pub fn has_non_default_type_params(self, db: &dyn HirDatabase) -> bool {
        let subst = db.generic_defaults(self.id.into());
        subst.iter().any(|ty| &ty.value == &Ty::Unknown)
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        Module { id: self.id.lookup(db.upcast()).module(db.upcast()) }
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Option<Crate> {
        Some(self.module(db).krate())
    }

    pub fn type_ref(self, db: &dyn HirDatabase) -> Option<TypeRef> {
        db.type_alias_data(self.id).type_ref.clone()
    }

    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        Type::from_def(db, self.id.lookup(db.upcast()).module(db.upcast()).krate(), self.id)
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        db.type_alias_data(self.id).name.clone()
    }
}

impl HasVisibility for TypeAlias {
    fn visibility(&self, db: &dyn HirDatabase) -> Visibility {
        let function_data = db.type_alias_data(self.id);
        let visibility = &function_data.visibility;
        visibility.resolve(db.upcast(), &self.id.resolver(db.upcast()))
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct BuiltinType {
    pub(crate) inner: hir_def::builtin_type::BuiltinType,
}

impl BuiltinType {
    pub fn ty(self, db: &dyn HirDatabase, module: Module) -> Type {
        let resolver = module.id.resolver(db.upcast());
        Type::new_with_resolver(db, &resolver, Ty::builtin(self.inner))
            .expect("crate not present in resolver")
    }

    pub fn name(self) -> Name {
        self.inner.as_name()
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct MacroDef {
    pub(crate) id: MacroDefId,
}

impl MacroDef {
    /// FIXME: right now, this just returns the root module of the crate that
    /// defines this macro. The reasons for this is that macros are expanded
    /// early, in `hir_expand`, where modules simply do not exist yet.
    pub fn module(self, db: &dyn HirDatabase) -> Option<Module> {
        let krate = self.id.krate;
        let def_map = db.crate_def_map(krate);
        let module_id = def_map.root();
        Some(Module { id: def_map.module_id(module_id) })
    }

    /// XXX: this parses the file
    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        self.source(db)?.value.name().map(|it| it.as_name())
    }

    /// Indicate it is a proc-macro
    pub fn is_proc_macro(&self) -> bool {
        matches!(self.id.kind, MacroDefKind::ProcMacro(_))
    }

    /// Indicate it is a derive macro
    pub fn is_derive_macro(&self) -> bool {
        matches!(self.id.kind, MacroDefKind::ProcMacro(_) | MacroDefKind::BuiltInDerive(_))
    }
}

/// Invariant: `inner.as_assoc_item(db).is_some()`
/// We do not actively enforce this invariant.
#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub enum AssocItem {
    Function(Function),
    Const(Const),
    TypeAlias(TypeAlias),
}
pub enum AssocItemContainer {
    Trait(Trait),
    Impl(Impl),
}
pub trait AsAssocItem {
    fn as_assoc_item(self, db: &dyn HirDatabase) -> Option<AssocItem>;
}

impl AsAssocItem for Function {
    fn as_assoc_item(self, db: &dyn HirDatabase) -> Option<AssocItem> {
        as_assoc_item(db, AssocItem::Function, self.id)
    }
}
impl AsAssocItem for Const {
    fn as_assoc_item(self, db: &dyn HirDatabase) -> Option<AssocItem> {
        as_assoc_item(db, AssocItem::Const, self.id)
    }
}
impl AsAssocItem for TypeAlias {
    fn as_assoc_item(self, db: &dyn HirDatabase) -> Option<AssocItem> {
        as_assoc_item(db, AssocItem::TypeAlias, self.id)
    }
}
impl AsAssocItem for ModuleDef {
    fn as_assoc_item(self, db: &dyn HirDatabase) -> Option<AssocItem> {
        match self {
            ModuleDef::Function(it) => it.as_assoc_item(db),
            ModuleDef::Const(it) => it.as_assoc_item(db),
            ModuleDef::TypeAlias(it) => it.as_assoc_item(db),
            _ => None,
        }
    }
}
fn as_assoc_item<ID, DEF, CTOR, AST>(db: &dyn HirDatabase, ctor: CTOR, id: ID) -> Option<AssocItem>
where
    ID: Lookup<Data = AssocItemLoc<AST>>,
    DEF: From<ID>,
    CTOR: FnOnce(DEF) -> AssocItem,
    AST: ItemTreeNode,
{
    match id.lookup(db.upcast()).container {
        AssocContainerId::TraitId(_) | AssocContainerId::ImplId(_) => Some(ctor(DEF::from(id))),
        AssocContainerId::ContainerId(_) => None,
    }
}

impl AssocItem {
    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        match self {
            AssocItem::Function(it) => Some(it.name(db)),
            AssocItem::Const(it) => it.name(db),
            AssocItem::TypeAlias(it) => Some(it.name(db)),
        }
    }
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        match self {
            AssocItem::Function(f) => f.module(db),
            AssocItem::Const(c) => c.module(db),
            AssocItem::TypeAlias(t) => t.module(db),
        }
    }
    pub fn container(self, db: &dyn HirDatabase) -> AssocItemContainer {
        let container = match self {
            AssocItem::Function(it) => it.id.lookup(db.upcast()).container,
            AssocItem::Const(it) => it.id.lookup(db.upcast()).container,
            AssocItem::TypeAlias(it) => it.id.lookup(db.upcast()).container,
        };
        match container {
            AssocContainerId::TraitId(id) => AssocItemContainer::Trait(id.into()),
            AssocContainerId::ImplId(id) => AssocItemContainer::Impl(id.into()),
            AssocContainerId::ContainerId(_) => panic!("invalid AssocItem"),
        }
    }

    pub fn containing_trait(self, db: &dyn HirDatabase) -> Option<Trait> {
        match self.container(db) {
            AssocItemContainer::Trait(t) => Some(t),
            _ => None,
        }
    }
}

impl HasVisibility for AssocItem {
    fn visibility(&self, db: &dyn HirDatabase) -> Visibility {
        match self {
            AssocItem::Function(f) => f.visibility(db),
            AssocItem::Const(c) => c.visibility(db),
            AssocItem::TypeAlias(t) => t.visibility(db),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug, Hash)]
pub enum GenericDef {
    Function(Function),
    Adt(Adt),
    Trait(Trait),
    TypeAlias(TypeAlias),
    Impl(Impl),
    // enum variants cannot have generics themselves, but their parent enums
    // can, and this makes some code easier to write
    Variant(Variant),
    // consts can have type parameters from their parents (i.e. associated consts of traits)
    Const(Const),
}
impl_from!(
    Function,
    Adt(Struct, Enum, Union),
    Trait,
    TypeAlias,
    Impl,
    Variant,
    Const
    for GenericDef
);

impl GenericDef {
    pub fn params(self, db: &dyn HirDatabase) -> Vec<GenericParam> {
        let generics = db.generic_params(self.into());
        let ty_params = generics
            .types
            .iter()
            .map(|(local_id, _)| TypeParam { id: TypeParamId { parent: self.into(), local_id } })
            .map(GenericParam::TypeParam);
        let lt_params = generics
            .lifetimes
            .iter()
            .map(|(local_id, _)| LifetimeParam {
                id: LifetimeParamId { parent: self.into(), local_id },
            })
            .map(GenericParam::LifetimeParam);
        let const_params = generics
            .consts
            .iter()
            .map(|(local_id, _)| ConstParam { id: ConstParamId { parent: self.into(), local_id } })
            .map(GenericParam::ConstParam);
        ty_params.chain(lt_params).chain(const_params).collect()
    }

    pub fn type_params(self, db: &dyn HirDatabase) -> Vec<TypeParam> {
        let generics = db.generic_params(self.into());
        generics
            .types
            .iter()
            .map(|(local_id, _)| TypeParam { id: TypeParamId { parent: self.into(), local_id } })
            .collect()
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct Local {
    pub(crate) parent: DefWithBodyId,
    pub(crate) pat_id: PatId,
}

impl Local {
    pub fn is_param(self, db: &dyn HirDatabase) -> bool {
        let src = self.source(db);
        match src.value {
            Either::Left(bind_pat) => {
                bind_pat.syntax().ancestors().any(|it| ast::Param::can_cast(it.kind()))
            }
            Either::Right(_self_param) => true,
        }
    }

    // FIXME: why is this an option? It shouldn't be?
    pub fn name(self, db: &dyn HirDatabase) -> Option<Name> {
        let body = db.body(self.parent.into());
        match &body[self.pat_id] {
            Pat::Bind { name, .. } => Some(name.clone()),
            _ => None,
        }
    }

    pub fn is_self(self, db: &dyn HirDatabase) -> bool {
        self.name(db) == Some(name![self])
    }

    pub fn is_mut(self, db: &dyn HirDatabase) -> bool {
        let body = db.body(self.parent.into());
        match &body[self.pat_id] {
            Pat::Bind { mode, .. } => match mode {
                BindingAnnotation::Mutable | BindingAnnotation::RefMut => true,
                _ => false,
            },
            _ => false,
        }
    }

    pub fn parent(self, _db: &dyn HirDatabase) -> DefWithBody {
        self.parent.into()
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.parent(db).module(db)
    }

    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        let def = DefWithBodyId::from(self.parent);
        let infer = db.infer(def);
        let ty = infer[self.pat_id].clone();
        let krate = def.module(db.upcast()).krate();
        Type::new(db, krate, def, ty)
    }

    pub fn source(self, db: &dyn HirDatabase) -> InFile<Either<ast::IdentPat, ast::SelfParam>> {
        let (_body, source_map) = db.body_with_source_map(self.parent.into());
        let src = source_map.pat_syntax(self.pat_id).unwrap(); // Hmm...
        let root = src.file_syntax(db.upcast());
        src.map(|ast| {
            ast.map_left(|it| it.cast().unwrap().to_node(&root)).map_right(|it| it.to_node(&root))
        })
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct Label {
    pub(crate) parent: DefWithBodyId,
    pub(crate) label_id: LabelId,
}

impl Label {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.parent(db).module(db)
    }

    pub fn parent(self, _db: &dyn HirDatabase) -> DefWithBody {
        self.parent.into()
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        let body = db.body(self.parent.into());
        body[self.label_id].name.clone()
    }

    pub fn source(self, db: &dyn HirDatabase) -> InFile<ast::Label> {
        let (_body, source_map) = db.body_with_source_map(self.parent.into());
        let src = source_map.label_syntax(self.label_id);
        let root = src.file_syntax(db.upcast());
        src.map(|ast| ast.to_node(&root))
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum GenericParam {
    TypeParam(TypeParam),
    LifetimeParam(LifetimeParam),
    ConstParam(ConstParam),
}
impl_from!(TypeParam, LifetimeParam, ConstParam for GenericParam);

impl GenericParam {
    pub fn module(self, db: &dyn HirDatabase) -> Module {
        match self {
            GenericParam::TypeParam(it) => it.module(db),
            GenericParam::LifetimeParam(it) => it.module(db),
            GenericParam::ConstParam(it) => it.module(db),
        }
    }

    pub fn name(self, db: &dyn HirDatabase) -> Name {
        match self {
            GenericParam::TypeParam(it) => it.name(db),
            GenericParam::LifetimeParam(it) => it.name(db),
            GenericParam::ConstParam(it) => it.name(db),
        }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct TypeParam {
    pub(crate) id: TypeParamId,
}

impl TypeParam {
    pub fn name(self, db: &dyn HirDatabase) -> Name {
        let params = db.generic_params(self.id.parent);
        params.types[self.id.local_id].name.clone().unwrap_or_else(Name::missing)
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.id.parent.module(db.upcast()).into()
    }

    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        let resolver = self.id.parent.resolver(db.upcast());
        let environment = TraitEnvironment::lower(db, &resolver);
        let ty = Ty::Placeholder(self.id);
        Type {
            krate: self.id.parent.module(db.upcast()).krate(),
            ty: InEnvironment { value: ty, environment },
        }
    }

    pub fn trait_bounds(self, db: &dyn HirDatabase) -> Vec<Trait> {
        db.generic_predicates_for_param(self.id)
            .into_iter()
            .filter_map(|pred| match &pred.value {
                hir_ty::GenericPredicate::Implemented(trait_ref) => {
                    Some(Trait::from(trait_ref.trait_))
                }
                _ => None,
            })
            .collect()
    }

    pub fn default(self, db: &dyn HirDatabase) -> Option<Type> {
        let params = db.generic_defaults(self.id.parent);
        let local_idx = hir_ty::param_idx(db, self.id)?;
        let resolver = self.id.parent.resolver(db.upcast());
        let environment = TraitEnvironment::lower(db, &resolver);
        let ty = params.get(local_idx)?.clone();
        let subst = Substs::type_params(db, self.id.parent);
        let ty = ty.subst(&subst.prefix(local_idx));
        Some(Type {
            krate: self.id.parent.module(db.upcast()).krate(),
            ty: InEnvironment { value: ty, environment },
        })
    }
}

impl HirDisplay for TypeParam {
    fn hir_fmt(&self, f: &mut HirFormatter) -> Result<(), HirDisplayError> {
        write!(f, "{}", self.name(f.db))?;
        let bounds = f.db.generic_predicates_for_param(self.id);
        let substs = Substs::type_params(f.db, self.id.parent);
        let predicates = bounds.iter().cloned().map(|b| b.subst(&substs)).collect::<Vec<_>>();
        if !(predicates.is_empty() || f.omit_verbose_types()) {
            write!(f, ": ")?;
            write_bounds_like_dyn_trait(&predicates, f)?;
        }
        Ok(())
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct LifetimeParam {
    pub(crate) id: LifetimeParamId,
}

impl LifetimeParam {
    pub fn name(self, db: &dyn HirDatabase) -> Name {
        let params = db.generic_params(self.id.parent);
        params.lifetimes[self.id.local_id].name.clone()
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.id.parent.module(db.upcast()).into()
    }

    pub fn parent(self, _db: &dyn HirDatabase) -> GenericDef {
        self.id.parent.into()
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct ConstParam {
    pub(crate) id: ConstParamId,
}

impl ConstParam {
    pub fn name(self, db: &dyn HirDatabase) -> Name {
        let params = db.generic_params(self.id.parent);
        params.consts[self.id.local_id].name.clone()
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.id.parent.module(db.upcast()).into()
    }

    pub fn parent(self, _db: &dyn HirDatabase) -> GenericDef {
        self.id.parent.into()
    }

    pub fn ty(self, db: &dyn HirDatabase) -> Type {
        let def = self.id.parent;
        let krate = def.module(db.upcast()).krate();
        Type::new(db, krate, def, db.const_param_ty(self.id))
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Impl {
    pub(crate) id: ImplId,
}

impl Impl {
    pub fn all_in_crate(db: &dyn HirDatabase, krate: Crate) -> Vec<Impl> {
        let inherent = db.inherent_impls_in_crate(krate.id);
        let trait_ = db.trait_impls_in_crate(krate.id);

        inherent.all_impls().chain(trait_.all_impls()).map(Self::from).collect()
    }
    pub fn for_trait(db: &dyn HirDatabase, krate: Crate, trait_: Trait) -> Vec<Impl> {
        let impls = db.trait_impls_in_crate(krate.id);
        impls.for_trait(trait_.id).map(Self::from).collect()
    }

    // FIXME: the return type is wrong. This should be a hir version of
    // `TraitRef` (ie, resolved `TypeRef`).
    pub fn target_trait(self, db: &dyn HirDatabase) -> Option<TypeRef> {
        db.impl_data(self.id).target_trait.clone()
    }

    pub fn target_ty(self, db: &dyn HirDatabase) -> Type {
        let impl_data = db.impl_data(self.id);
        let resolver = self.id.resolver(db.upcast());
        let ctx = hir_ty::TyLoweringContext::new(db, &resolver);
        let environment = TraitEnvironment::lower(db, &resolver);
        let ty = Ty::from_hir(&ctx, &impl_data.target_type);
        Type {
            krate: self.id.lookup(db.upcast()).container.module(db.upcast()).krate(),
            ty: InEnvironment { value: ty, environment },
        }
    }

    pub fn items(self, db: &dyn HirDatabase) -> Vec<AssocItem> {
        db.impl_data(self.id).items.iter().map(|it| (*it).into()).collect()
    }

    pub fn is_negative(self, db: &dyn HirDatabase) -> bool {
        db.impl_data(self.id).is_negative
    }

    pub fn module(self, db: &dyn HirDatabase) -> Module {
        self.id.lookup(db.upcast()).container.module(db.upcast()).into()
    }

    pub fn krate(self, db: &dyn HirDatabase) -> Crate {
        Crate { id: self.module(db).id.krate() }
    }

    pub fn is_builtin_derive(self, db: &dyn HirDatabase) -> Option<InFile<ast::Attr>> {
        let src = self.source(db)?;
        let item = src.file_id.is_builtin_derive(db.upcast())?;
        let hygenic = hir_expand::hygiene::Hygiene::new(db.upcast(), item.file_id);

        // FIXME: handle `cfg_attr`
        let attr = item
            .value
            .attrs()
            .filter_map(|it| {
                let path = ModPath::from_src(it.path()?, &hygenic)?;
                if path.as_ident()?.to_string() == "derive" {
                    Some(it)
                } else {
                    None
                }
            })
            .last()?;

        Some(item.with_value(attr))
    }
}

#[derive(Clone, PartialEq, Eq, Debug)]
pub struct Type {
    krate: CrateId,
    ty: InEnvironment<Ty>,
}

impl Type {
    pub(crate) fn new_with_resolver(
        db: &dyn HirDatabase,
        resolver: &Resolver,
        ty: Ty,
    ) -> Option<Type> {
        let krate = resolver.krate()?;
        Some(Type::new_with_resolver_inner(db, krate, resolver, ty))
    }
    pub(crate) fn new_with_resolver_inner(
        db: &dyn HirDatabase,
        krate: CrateId,
        resolver: &Resolver,
        ty: Ty,
    ) -> Type {
        let environment = TraitEnvironment::lower(db, &resolver);
        Type { krate, ty: InEnvironment { value: ty, environment } }
    }

    fn new(db: &dyn HirDatabase, krate: CrateId, lexical_env: impl HasResolver, ty: Ty) -> Type {
        let resolver = lexical_env.resolver(db.upcast());
        let environment = TraitEnvironment::lower(db, &resolver);
        Type { krate, ty: InEnvironment { value: ty, environment } }
    }

    fn from_def(
        db: &dyn HirDatabase,
        krate: CrateId,
        def: impl HasResolver + Into<TyDefId> + Into<GenericDefId>,
    ) -> Type {
        let substs = Substs::build_for_def(db, def).fill_with_unknown().build();
        let ty = db.ty(def.into()).subst(&substs);
        Type::new(db, krate, def, ty)
    }

    pub fn is_unit(&self) -> bool {
        matches!(
            self.ty.value,
            Ty::Apply(ApplicationTy { ctor: TypeCtor::Tuple { cardinality: 0 }, .. })
        )
    }
    pub fn is_bool(&self) -> bool {
        matches!(self.ty.value, Ty::Apply(ApplicationTy { ctor: TypeCtor::Bool, .. }))
    }

    pub fn is_mutable_reference(&self) -> bool {
        matches!(
            self.ty.value,
            Ty::Apply(ApplicationTy { ctor: TypeCtor::Ref(Mutability::Mut), .. })
        )
    }

    pub fn remove_ref(&self) -> Option<Type> {
        if let Ty::Apply(ApplicationTy { ctor: TypeCtor::Ref(_), .. }) = self.ty.value {
            self.ty.value.substs().map(|substs| self.derived(substs[0].clone()))
        } else {
            None
        }
    }

    pub fn is_unknown(&self) -> bool {
        matches!(self.ty.value, Ty::Unknown)
    }

    /// Checks that particular type `ty` implements `std::future::Future`.
    /// This function is used in `.await` syntax completion.
    pub fn impls_future(&self, db: &dyn HirDatabase) -> bool {
        // No special case for the type of async block, since Chalk can figure it out.

        let krate = self.krate;

        let std_future_trait =
            db.lang_item(krate, "future_trait".into()).and_then(|it| it.as_trait());
        let std_future_trait = match std_future_trait {
            Some(it) => it,
            None => return false,
        };

        let canonical_ty = Canonical { value: self.ty.value.clone(), kinds: Arc::new([]) };
        method_resolution::implements_trait(
            &canonical_ty,
            db,
            self.ty.environment.clone(),
            krate,
            std_future_trait,
        )
    }

    /// Checks that particular type `ty` implements `std::ops::FnOnce`.
    ///
    /// This function can be used to check if a particular type is callable, since FnOnce is a
    /// supertrait of Fn and FnMut, so all callable types implements at least FnOnce.
    pub fn impls_fnonce(&self, db: &dyn HirDatabase) -> bool {
        let krate = self.krate;

        let fnonce_trait = match FnTrait::FnOnce.get_id(db, krate) {
            Some(it) => it,
            None => return false,
        };

        let canonical_ty = Canonical { value: self.ty.value.clone(), kinds: Arc::new([]) };
        method_resolution::implements_trait_unique(
            &canonical_ty,
            db,
            self.ty.environment.clone(),
            krate,
            fnonce_trait,
        )
    }

    pub fn impls_trait(&self, db: &dyn HirDatabase, trait_: Trait, args: &[Type]) -> bool {
        let trait_ref = hir_ty::TraitRef {
            trait_: trait_.id,
            substs: Substs::build_for_def(db, trait_.id)
                .push(self.ty.value.clone())
                .fill(args.iter().map(|t| t.ty.value.clone()))
                .build(),
        };

        let goal = Canonical {
            value: hir_ty::InEnvironment::new(
                self.ty.environment.clone(),
                hir_ty::Obligation::Trait(trait_ref),
            ),
            kinds: Arc::new([]),
        };

        db.trait_solve(self.krate, goal).is_some()
    }

    pub fn normalize_trait_assoc_type(
        &self,
        db: &dyn HirDatabase,
        trait_: Trait,
        args: &[Type],
        alias: TypeAlias,
    ) -> Option<Type> {
        let subst = Substs::build_for_def(db, trait_.id)
            .push(self.ty.value.clone())
            .fill(args.iter().map(|t| t.ty.value.clone()))
            .build();
        let predicate = ProjectionPredicate {
            projection_ty: ProjectionTy { associated_ty: alias.id, parameters: subst },
            ty: Ty::Bound(BoundVar::new(DebruijnIndex::INNERMOST, 0)),
        };
        let goal = Canonical {
            value: InEnvironment::new(
                self.ty.environment.clone(),
                Obligation::Projection(predicate),
            ),
            kinds: Arc::new([TyKind::General]),
        };

        match db.trait_solve(self.krate, goal)? {
            Solution::Unique(SolutionVariables(subst)) => subst.value.first().cloned(),
            Solution::Ambig(_) => None,
        }
        .map(|ty| Type {
            krate: self.krate,
            ty: InEnvironment { value: ty, environment: Arc::clone(&self.ty.environment) },
        })
    }

    pub fn is_copy(&self, db: &dyn HirDatabase) -> bool {
        let lang_item = db.lang_item(self.krate, SmolStr::new("copy"));
        let copy_trait = match lang_item {
            Some(LangItemTarget::TraitId(it)) => it,
            _ => return false,
        };
        self.impls_trait(db, copy_trait.into(), &[])
    }

    pub fn as_callable(&self, db: &dyn HirDatabase) -> Option<Callable> {
        let def = match self.ty.value {
            Ty::Apply(ApplicationTy { ctor: TypeCtor::FnDef(def), parameters: _ }) => Some(def),
            _ => None,
        };

        let sig = self.ty.value.callable_sig(db)?;
        Some(Callable { ty: self.clone(), sig, def, is_bound_method: false })
    }

    pub fn is_closure(&self) -> bool {
        matches!(&self.ty.value, Ty::Apply(ApplicationTy { ctor: TypeCtor::Closure { .. }, .. }))
    }

    pub fn is_fn(&self) -> bool {
        matches!(
            &self.ty.value,
            Ty::Apply(ApplicationTy { ctor: TypeCtor::FnDef(..), .. })
                | Ty::Apply(ApplicationTy { ctor: TypeCtor::FnPtr { .. }, .. })
        )
    }

    pub fn is_packed(&self, db: &dyn HirDatabase) -> bool {
        let adt_id = match self.ty.value {
            Ty::Apply(ApplicationTy { ctor: TypeCtor::Adt(adt_id), .. }) => adt_id,
            _ => return false,
        };

        let adt = adt_id.into();
        match adt {
            Adt::Struct(s) => matches!(s.repr(db), Some(ReprKind::Packed)),
            _ => false,
        }
    }

    pub fn is_raw_ptr(&self) -> bool {
        matches!(&self.ty.value, Ty::Apply(ApplicationTy { ctor: TypeCtor::RawPtr(..), .. }))
    }

    pub fn contains_unknown(&self) -> bool {
        return go(&self.ty.value);

        fn go(ty: &Ty) -> bool {
            match ty {
                Ty::Unknown => true,
                Ty::Apply(a_ty) => a_ty.parameters.iter().any(go),
                _ => false,
            }
        }
    }

    pub fn fields(&self, db: &dyn HirDatabase) -> Vec<(Field, Type)> {
        if let Ty::Apply(a_ty) = &self.ty.value {
            let variant_id = match a_ty.ctor {
                TypeCtor::Adt(AdtId::StructId(s)) => s.into(),
                TypeCtor::Adt(AdtId::UnionId(u)) => u.into(),
                _ => return Vec::new(),
            };

            return db
                .field_types(variant_id)
                .iter()
                .map(|(local_id, ty)| {
                    let def = Field { parent: variant_id.into(), id: local_id };
                    let ty = ty.clone().subst(&a_ty.parameters);
                    (def, self.derived(ty))
                })
                .collect();
        };
        Vec::new()
    }

    pub fn tuple_fields(&self, _db: &dyn HirDatabase) -> Vec<Type> {
        let mut res = Vec::new();
        if let Ty::Apply(a_ty) = &self.ty.value {
            if let TypeCtor::Tuple { .. } = a_ty.ctor {
                for ty in a_ty.parameters.iter() {
                    let ty = ty.clone();
                    res.push(self.derived(ty));
                }
            }
        };
        res
    }

    pub fn autoderef<'a>(&'a self, db: &'a dyn HirDatabase) -> impl Iterator<Item = Type> + 'a {
        // There should be no inference vars in types passed here
        // FIXME check that?
        let canonical = Canonical { value: self.ty.value.clone(), kinds: Arc::new([]) };
        let environment = self.ty.environment.clone();
        let ty = InEnvironment { value: canonical, environment };
        autoderef(db, Some(self.krate), ty)
            .map(|canonical| canonical.value)
            .map(move |ty| self.derived(ty))
    }

    // This would be nicer if it just returned an iterator, but that runs into
    // lifetime problems, because we need to borrow temp `CrateImplDefs`.
    pub fn iterate_assoc_items<T>(
        self,
        db: &dyn HirDatabase,
        krate: Crate,
        mut callback: impl FnMut(AssocItem) -> Option<T>,
    ) -> Option<T> {
        for krate in self.ty.value.def_crates(db, krate.id)? {
            let impls = db.inherent_impls_in_crate(krate);

            for impl_def in impls.for_self_ty(&self.ty.value) {
                for &item in db.impl_data(*impl_def).items.iter() {
                    if let Some(result) = callback(item.into()) {
                        return Some(result);
                    }
                }
            }
        }
        None
    }

    pub fn iterate_method_candidates<T>(
        &self,
        db: &dyn HirDatabase,
        krate: Crate,
        traits_in_scope: &FxHashSet<TraitId>,
        name: Option<&Name>,
        mut callback: impl FnMut(&Ty, Function) -> Option<T>,
    ) -> Option<T> {
        // There should be no inference vars in types passed here
        // FIXME check that?
        // FIXME replace Unknown by bound vars here
        let canonical = Canonical { value: self.ty.value.clone(), kinds: Arc::new([]) };

        let env = self.ty.environment.clone();
        let krate = krate.id;

        method_resolution::iterate_method_candidates(
            &canonical,
            db,
            env,
            krate,
            traits_in_scope,
            name,
            method_resolution::LookupMode::MethodCall,
            |ty, it| match it {
                AssocItemId::FunctionId(f) => callback(ty, f.into()),
                _ => None,
            },
        )
    }

    pub fn iterate_path_candidates<T>(
        &self,
        db: &dyn HirDatabase,
        krate: Crate,
        traits_in_scope: &FxHashSet<TraitId>,
        name: Option<&Name>,
        mut callback: impl FnMut(&Ty, AssocItem) -> Option<T>,
    ) -> Option<T> {
        // There should be no inference vars in types passed here
        // FIXME check that?
        // FIXME replace Unknown by bound vars here
        let canonical = Canonical { value: self.ty.value.clone(), kinds: Arc::new([]) };

        let env = self.ty.environment.clone();
        let krate = krate.id;

        method_resolution::iterate_method_candidates(
            &canonical,
            db,
            env,
            krate,
            traits_in_scope,
            name,
            method_resolution::LookupMode::Path,
            |ty, it| callback(ty, it.into()),
        )
    }

    pub fn as_adt(&self) -> Option<Adt> {
        let (adt, _subst) = self.ty.value.as_adt()?;
        Some(adt.into())
    }

    pub fn as_dyn_trait(&self) -> Option<Trait> {
        self.ty.value.dyn_trait().map(Into::into)
    }

    pub fn as_impl_traits(&self, db: &dyn HirDatabase) -> Option<Vec<Trait>> {
        self.ty.value.impl_trait_bounds(db).map(|it| {
            it.into_iter()
                .filter_map(|pred| match pred {
                    hir_ty::GenericPredicate::Implemented(trait_ref) => {
                        Some(Trait::from(trait_ref.trait_))
                    }
                    _ => None,
                })
                .collect()
        })
    }

    pub fn as_associated_type_parent_trait(&self, db: &dyn HirDatabase) -> Option<Trait> {
        self.ty.value.associated_type_parent_trait(db).map(Into::into)
    }

    // FIXME: provide required accessors such that it becomes implementable from outside.
    pub fn is_equal_for_find_impls(&self, other: &Type) -> bool {
        match (&self.ty.value, &other.ty.value) {
            (Ty::Apply(a_original_ty), Ty::Apply(ApplicationTy { ctor, parameters })) => match ctor
            {
                TypeCtor::Ref(..) => match parameters.as_single() {
                    Ty::Apply(a_ty) => a_original_ty.ctor == a_ty.ctor,
                    _ => false,
                },
                _ => a_original_ty.ctor == *ctor,
            },
            _ => false,
        }
    }

    fn derived(&self, ty: Ty) -> Type {
        Type {
            krate: self.krate,
            ty: InEnvironment { value: ty, environment: self.ty.environment.clone() },
        }
    }

    pub fn walk(&self, db: &dyn HirDatabase, mut cb: impl FnMut(Type)) {
        // TypeWalk::walk for a Ty at first visits parameters and only after that the Ty itself.
        // We need a different order here.

        fn walk_substs(
            db: &dyn HirDatabase,
            type_: &Type,
            substs: &Substs,
            cb: &mut impl FnMut(Type),
        ) {
            for ty in substs.iter() {
                walk_type(db, &type_.derived(ty.clone()), cb);
            }
        }

        fn walk_bounds(
            db: &dyn HirDatabase,
            type_: &Type,
            bounds: &[GenericPredicate],
            cb: &mut impl FnMut(Type),
        ) {
            for pred in bounds {
                match pred {
                    GenericPredicate::Implemented(trait_ref) => {
                        cb(type_.clone());
                        walk_substs(db, type_, &trait_ref.substs, cb);
                    }
                    _ => (),
                }
            }
        }

        fn walk_type(db: &dyn HirDatabase, type_: &Type, cb: &mut impl FnMut(Type)) {
            let ty = type_.ty.value.strip_references();
            match ty {
                Ty::Apply(ApplicationTy { ctor, parameters }) => {
                    match ctor {
                        TypeCtor::Adt(_) => {
                            cb(type_.derived(ty.clone()));
                        }
                        TypeCtor::AssociatedType(_) => {
                            if let Some(_) = ty.associated_type_parent_trait(db) {
                                cb(type_.derived(ty.clone()));
                            }
                        }
                        TypeCtor::OpaqueType(..) => {
                            if let Some(bounds) = ty.impl_trait_bounds(db) {
                                walk_bounds(db, &type_.derived(ty.clone()), &bounds, cb);
                            }
                        }
                        _ => (),
                    }

                    // adt params, tuples, etc...
                    walk_substs(db, type_, parameters, cb);
                }
                Ty::Opaque(opaque_ty) => {
                    if let Some(bounds) = ty.impl_trait_bounds(db) {
                        walk_bounds(db, &type_.derived(ty.clone()), &bounds, cb);
                    }

                    walk_substs(db, type_, &opaque_ty.parameters, cb);
                }
                Ty::Placeholder(_) => {
                    if let Some(bounds) = ty.impl_trait_bounds(db) {
                        walk_bounds(db, &type_.derived(ty.clone()), &bounds, cb);
                    }
                }
                Ty::Dyn(bounds) => {
                    walk_bounds(db, &type_.derived(ty.clone()), bounds.as_ref(), cb);
                }

                _ => (),
            }
        }

        walk_type(db, self, &mut cb);
    }
}

impl HirDisplay for Type {
    fn hir_fmt(&self, f: &mut HirFormatter) -> Result<(), HirDisplayError> {
        self.ty.value.hir_fmt(f)
    }
}

// FIXME: closures
#[derive(Debug)]
pub struct Callable {
    ty: Type,
    sig: FnSig,
    def: Option<CallableDefId>,
    pub(crate) is_bound_method: bool,
}

pub enum CallableKind {
    Function(Function),
    TupleStruct(Struct),
    TupleEnumVariant(Variant),
    Closure,
}

impl Callable {
    pub fn kind(&self) -> CallableKind {
        match self.def {
            Some(CallableDefId::FunctionId(it)) => CallableKind::Function(it.into()),
            Some(CallableDefId::StructId(it)) => CallableKind::TupleStruct(it.into()),
            Some(CallableDefId::EnumVariantId(it)) => CallableKind::TupleEnumVariant(it.into()),
            None => CallableKind::Closure,
        }
    }
    pub fn receiver_param(&self, db: &dyn HirDatabase) -> Option<ast::SelfParam> {
        let func = match self.def {
            Some(CallableDefId::FunctionId(it)) if self.is_bound_method => it,
            _ => return None,
        };
        let src = func.lookup(db.upcast()).source(db.upcast());
        let param_list = src.value.param_list()?;
        param_list.self_param()
    }
    pub fn n_params(&self) -> usize {
        self.sig.params().len() - if self.is_bound_method { 1 } else { 0 }
    }
    pub fn params(
        &self,
        db: &dyn HirDatabase,
    ) -> Vec<(Option<Either<ast::SelfParam, ast::Pat>>, Type)> {
        let types = self
            .sig
            .params()
            .iter()
            .skip(if self.is_bound_method { 1 } else { 0 })
            .map(|ty| self.ty.derived(ty.clone()));
        let patterns = match self.def {
            Some(CallableDefId::FunctionId(func)) => {
                let src = func.lookup(db.upcast()).source(db.upcast());
                src.value.param_list().map(|param_list| {
                    param_list
                        .self_param()
                        .map(|it| Some(Either::Left(it)))
                        .filter(|_| !self.is_bound_method)
                        .into_iter()
                        .chain(param_list.params().map(|it| it.pat().map(Either::Right)))
                })
            }
            _ => None,
        };
        patterns.into_iter().flatten().chain(iter::repeat(None)).zip(types).collect()
    }
    pub fn return_type(&self) -> Type {
        self.ty.derived(self.sig.ret().clone())
    }
}

/// For IDE only
#[derive(Debug)]
pub enum ScopeDef {
    ModuleDef(ModuleDef),
    MacroDef(MacroDef),
    GenericParam(GenericParam),
    ImplSelfType(Impl),
    AdtSelfType(Adt),
    Local(Local),
    Unknown,
}

impl ScopeDef {
    pub fn all_items(def: PerNs) -> ArrayVec<[Self; 3]> {
        let mut items = ArrayVec::new();

        match (def.take_types(), def.take_values()) {
            (Some(m1), None) => items.push(ScopeDef::ModuleDef(m1.into())),
            (None, Some(m2)) => items.push(ScopeDef::ModuleDef(m2.into())),
            (Some(m1), Some(m2)) => {
                // Some items, like unit structs and enum variants, are
                // returned as both a type and a value. Here we want
                // to de-duplicate them.
                if m1 != m2 {
                    items.push(ScopeDef::ModuleDef(m1.into()));
                    items.push(ScopeDef::ModuleDef(m2.into()));
                } else {
                    items.push(ScopeDef::ModuleDef(m1.into()));
                }
            }
            (None, None) => {}
        };

        if let Some(macro_def_id) = def.take_macros() {
            items.push(ScopeDef::MacroDef(macro_def_id.into()));
        }

        if items.is_empty() {
            items.push(ScopeDef::Unknown);
        }

        items
    }
}

pub trait HasVisibility {
    fn visibility(&self, db: &dyn HirDatabase) -> Visibility;
    fn is_visible_from(&self, db: &dyn HirDatabase, module: Module) -> bool {
        let vis = self.visibility(db);
        vis.is_visible_from(db.upcast(), module.id)
    }
}
