//! Defines `Body`: a lowered representation of bodies of functions, statics and
//! consts.
mod lower;
mod diagnostics;
#[cfg(test)]
mod tests;
pub mod scope;

use std::{mem, ops::Index, sync::Arc};

use base_db::CrateId;
use cfg::CfgOptions;
use drop_bomb::DropBomb;
use either::Either;
use hir_expand::{
    ast_id_map::AstIdMap, diagnostics::DiagnosticSink, hygiene::Hygiene, AstId, ExpandResult,
    HirFileId, InFile, MacroDefId,
};
use la_arena::{Arena, ArenaMap};
use profile::Count;
use rustc_hash::FxHashMap;
use syntax::{ast, AstNode, AstPtr};
use test_utils::mark;

pub(crate) use lower::LowerCtx;

use crate::{
    attr::{Attrs, RawAttrs},
    db::DefDatabase,
    expr::{Expr, ExprId, Label, LabelId, Pat, PatId},
    item_scope::BuiltinShadowMode,
    item_scope::ItemScope,
    nameres::DefMap,
    path::{ModPath, Path},
    src::HasSource,
    AsMacroCall, DefWithBodyId, HasModule, LocalModuleId, Lookup, ModuleId,
};

/// A subset of Expander that only deals with cfg attributes. We only need it to
/// avoid cyclic queries in crate def map during enum processing.
pub(crate) struct CfgExpander {
    cfg_options: CfgOptions,
    hygiene: Hygiene,
    krate: CrateId,
}

pub(crate) struct Expander {
    cfg_expander: CfgExpander,
    def_map: Arc<DefMap>,
    current_file_id: HirFileId,
    ast_id_map: Arc<AstIdMap>,
    module: LocalModuleId,
    recursion_limit: usize,
}

#[cfg(test)]
const EXPANSION_RECURSION_LIMIT: usize = 32;

#[cfg(not(test))]
const EXPANSION_RECURSION_LIMIT: usize = 128;

impl CfgExpander {
    pub(crate) fn new(
        db: &dyn DefDatabase,
        current_file_id: HirFileId,
        krate: CrateId,
    ) -> CfgExpander {
        let hygiene = Hygiene::new(db.upcast(), current_file_id);
        let cfg_options = db.crate_graph()[krate].cfg_options.clone();
        CfgExpander { cfg_options, hygiene, krate }
    }

    pub(crate) fn parse_attrs(&self, db: &dyn DefDatabase, owner: &dyn ast::AttrsOwner) -> Attrs {
        RawAttrs::new(owner, &self.hygiene).filter(db, self.krate)
    }

    pub(crate) fn is_cfg_enabled(&self, db: &dyn DefDatabase, owner: &dyn ast::AttrsOwner) -> bool {
        let attrs = self.parse_attrs(db, owner);
        attrs.is_cfg_enabled(&self.cfg_options)
    }
}

impl Expander {
    pub(crate) fn new(
        db: &dyn DefDatabase,
        current_file_id: HirFileId,
        module: ModuleId,
    ) -> Expander {
        let cfg_expander = CfgExpander::new(db, current_file_id, module.krate);
        let crate_def_map = module.def_map(db);
        let ast_id_map = db.ast_id_map(current_file_id);
        Expander {
            cfg_expander,
            def_map: crate_def_map,
            current_file_id,
            ast_id_map,
            module: module.local_id,
            recursion_limit: 0,
        }
    }

    pub(crate) fn enter_expand<T: ast::AstNode>(
        &mut self,
        db: &dyn DefDatabase,
        macro_call: ast::MacroCall,
    ) -> ExpandResult<Option<(Mark, T)>> {
        if self.recursion_limit + 1 > EXPANSION_RECURSION_LIMIT {
            mark::hit!(your_stack_belongs_to_me);
            return ExpandResult::str_err("reached recursion limit during macro expansion".into());
        }

        let macro_call = InFile::new(self.current_file_id, &macro_call);

        let resolver =
            |path: ModPath| -> Option<MacroDefId> { self.resolve_path_as_macro(db, &path) };

        let mut err = None;
        let call_id =
            macro_call.as_call_id_with_errors(db, self.def_map.krate(), resolver, &mut |e| {
                err.get_or_insert(e);
            });
        let call_id = match call_id {
            Some(it) => it,
            None => {
                if err.is_none() {
                    eprintln!("no error despite `as_call_id_with_errors` returning `None`");
                }
                return ExpandResult { value: None, err };
            }
        };

        if err.is_none() {
            err = db.macro_expand_error(call_id);
        }

        let file_id = call_id.as_file();

        let raw_node = match db.parse_or_expand(file_id) {
            Some(it) => it,
            None => {
                // Only `None` if the macro expansion produced no usable AST.
                if err.is_none() {
                    log::warn!("no error despite `parse_or_expand` failing");
                }

                return ExpandResult::only_err(err.unwrap_or_else(|| {
                    mbe::ExpandError::Other("failed to parse macro invocation".into())
                }));
            }
        };

        let node = match T::cast(raw_node) {
            Some(it) => it,
            None => {
                // This can happen without being an error, so only forward previous errors.
                return ExpandResult { value: None, err };
            }
        };

        log::debug!("macro expansion {:#?}", node.syntax());

        self.recursion_limit += 1;
        let mark = Mark {
            file_id: self.current_file_id,
            ast_id_map: mem::take(&mut self.ast_id_map),
            bomb: DropBomb::new("expansion mark dropped"),
        };
        self.cfg_expander.hygiene = Hygiene::new(db.upcast(), file_id);
        self.current_file_id = file_id;
        self.ast_id_map = db.ast_id_map(file_id);

        ExpandResult { value: Some((mark, node)), err }
    }

    pub(crate) fn exit(&mut self, db: &dyn DefDatabase, mut mark: Mark) {
        self.cfg_expander.hygiene = Hygiene::new(db.upcast(), mark.file_id);
        self.current_file_id = mark.file_id;
        self.ast_id_map = mem::take(&mut mark.ast_id_map);
        self.recursion_limit -= 1;
        mark.bomb.defuse();
    }

    pub(crate) fn to_source<T>(&self, value: T) -> InFile<T> {
        InFile { file_id: self.current_file_id, value }
    }

    pub(crate) fn parse_attrs(&self, db: &dyn DefDatabase, owner: &dyn ast::AttrsOwner) -> Attrs {
        self.cfg_expander.parse_attrs(db, owner)
    }

    pub(crate) fn cfg_options(&self) -> &CfgOptions {
        &self.cfg_expander.cfg_options
    }

    fn parse_path(&mut self, path: ast::Path) -> Option<Path> {
        Path::from_src(path, &self.cfg_expander.hygiene)
    }

    fn resolve_path_as_macro(&self, db: &dyn DefDatabase, path: &ModPath) -> Option<MacroDefId> {
        self.def_map.resolve_path(db, self.module, path, BuiltinShadowMode::Other).0.take_macros()
    }

    fn ast_id<N: AstNode>(&self, item: &N) -> AstId<N> {
        let file_local_id = self.ast_id_map.ast_id(item);
        AstId::new(self.current_file_id, file_local_id)
    }
}

pub(crate) struct Mark {
    file_id: HirFileId,
    ast_id_map: Arc<AstIdMap>,
    bomb: DropBomb,
}

/// The body of an item (function, const etc.).
#[derive(Debug, Eq, PartialEq)]
pub struct Body {
    pub exprs: Arena<Expr>,
    pub pats: Arena<Pat>,
    pub labels: Arena<Label>,
    /// The patterns for the function's parameters. While the parameter types are
    /// part of the function signature, the patterns are not (they don't change
    /// the external type of the function).
    ///
    /// If this `Body` is for the body of a constant, this will just be
    /// empty.
    pub params: Vec<PatId>,
    /// The `ExprId` of the actual body expression.
    pub body_expr: ExprId,
    pub item_scope: ItemScope,
    _c: Count<Self>,
}

pub type ExprPtr = AstPtr<ast::Expr>;
pub type ExprSource = InFile<ExprPtr>;

pub type PatPtr = Either<AstPtr<ast::Pat>, AstPtr<ast::SelfParam>>;
pub type PatSource = InFile<PatPtr>;

pub type LabelPtr = AstPtr<ast::Label>;
pub type LabelSource = InFile<LabelPtr>;
/// An item body together with the mapping from syntax nodes to HIR expression
/// IDs. This is needed to go from e.g. a position in a file to the HIR
/// expression containing it; but for type inference etc., we want to operate on
/// a structure that is agnostic to the actual positions of expressions in the
/// file, so that we don't recompute types whenever some whitespace is typed.
///
/// One complication here is that, due to macro expansion, a single `Body` might
/// be spread across several files. So, for each ExprId and PatId, we record
/// both the HirFileId and the position inside the file. However, we only store
/// AST -> ExprId mapping for non-macro files, as it is not clear how to handle
/// this properly for macros.
#[derive(Default, Debug, Eq, PartialEq)]
pub struct BodySourceMap {
    expr_map: FxHashMap<ExprSource, ExprId>,
    expr_map_back: ArenaMap<ExprId, Result<ExprSource, SyntheticSyntax>>,
    pat_map: FxHashMap<PatSource, PatId>,
    pat_map_back: ArenaMap<PatId, Result<PatSource, SyntheticSyntax>>,
    label_map: FxHashMap<LabelSource, LabelId>,
    label_map_back: ArenaMap<LabelId, LabelSource>,
    field_map: FxHashMap<(ExprId, usize), InFile<AstPtr<ast::RecordExprField>>>,
    expansions: FxHashMap<InFile<AstPtr<ast::MacroCall>>, HirFileId>,

    /// Diagnostics accumulated during body lowering. These contain `AstPtr`s and so are stored in
    /// the source map (since they're just as volatile).
    diagnostics: Vec<diagnostics::BodyDiagnostic>,
}

#[derive(Default, Debug, Eq, PartialEq, Clone, Copy)]
pub struct SyntheticSyntax;

impl Body {
    pub(crate) fn body_with_source_map_query(
        db: &dyn DefDatabase,
        def: DefWithBodyId,
    ) -> (Arc<Body>, Arc<BodySourceMap>) {
        let _p = profile::span("body_with_source_map_query");
        let mut params = None;

        let (file_id, module, body) = match def {
            DefWithBodyId::FunctionId(f) => {
                let f = f.lookup(db);
                let src = f.source(db);
                params = src.value.param_list();
                (src.file_id, f.module(db), src.value.body().map(ast::Expr::from))
            }
            DefWithBodyId::ConstId(c) => {
                let c = c.lookup(db);
                let src = c.source(db);
                (src.file_id, c.module(db), src.value.body())
            }
            DefWithBodyId::StaticId(s) => {
                let s = s.lookup(db);
                let src = s.source(db);
                (src.file_id, s.module(db), src.value.body())
            }
        };
        let expander = Expander::new(db, file_id, module);
        let (body, source_map) = Body::new(db, def, expander, params, body);
        (Arc::new(body), Arc::new(source_map))
    }

    pub(crate) fn body_query(db: &dyn DefDatabase, def: DefWithBodyId) -> Arc<Body> {
        db.body_with_source_map(def).0
    }

    fn new(
        db: &dyn DefDatabase,
        def: DefWithBodyId,
        expander: Expander,
        params: Option<ast::ParamList>,
        body: Option<ast::Expr>,
    ) -> (Body, BodySourceMap) {
        lower::lower(db, def, expander, params, body)
    }
}

impl Index<ExprId> for Body {
    type Output = Expr;

    fn index(&self, expr: ExprId) -> &Expr {
        &self.exprs[expr]
    }
}

impl Index<PatId> for Body {
    type Output = Pat;

    fn index(&self, pat: PatId) -> &Pat {
        &self.pats[pat]
    }
}

impl Index<LabelId> for Body {
    type Output = Label;

    fn index(&self, label: LabelId) -> &Label {
        &self.labels[label]
    }
}

impl BodySourceMap {
    pub fn expr_syntax(&self, expr: ExprId) -> Result<ExprSource, SyntheticSyntax> {
        self.expr_map_back[expr].clone()
    }

    pub fn node_expr(&self, node: InFile<&ast::Expr>) -> Option<ExprId> {
        let src = node.map(|it| AstPtr::new(it));
        self.expr_map.get(&src).cloned()
    }

    pub fn node_macro_file(&self, node: InFile<&ast::MacroCall>) -> Option<HirFileId> {
        let src = node.map(|it| AstPtr::new(it));
        self.expansions.get(&src).cloned()
    }

    pub fn pat_syntax(&self, pat: PatId) -> Result<PatSource, SyntheticSyntax> {
        self.pat_map_back[pat].clone()
    }

    pub fn node_pat(&self, node: InFile<&ast::Pat>) -> Option<PatId> {
        let src = node.map(|it| Either::Left(AstPtr::new(it)));
        self.pat_map.get(&src).cloned()
    }

    pub fn node_self_param(&self, node: InFile<&ast::SelfParam>) -> Option<PatId> {
        let src = node.map(|it| Either::Right(AstPtr::new(it)));
        self.pat_map.get(&src).cloned()
    }

    pub fn label_syntax(&self, label: LabelId) -> LabelSource {
        self.label_map_back[label].clone()
    }

    pub fn node_label(&self, node: InFile<&ast::Label>) -> Option<LabelId> {
        let src = node.map(|it| AstPtr::new(it));
        self.label_map.get(&src).cloned()
    }

    pub fn field_syntax(&self, expr: ExprId, field: usize) -> InFile<AstPtr<ast::RecordExprField>> {
        self.field_map[&(expr, field)].clone()
    }

    pub(crate) fn add_diagnostics(&self, _db: &dyn DefDatabase, sink: &mut DiagnosticSink<'_>) {
        for diag in &self.diagnostics {
            diag.add_to(sink);
        }
    }
}
