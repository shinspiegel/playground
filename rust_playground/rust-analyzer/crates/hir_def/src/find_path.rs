//! An algorithm to find a path to refer to a certain item.

use hir_expand::name::{known, AsName, Name};
use rustc_hash::FxHashSet;
use test_utils::mark;

use crate::nameres::DefMap;
use crate::{
    db::DefDatabase,
    item_scope::ItemInNs,
    path::{ModPath, PathKind},
    visibility::Visibility,
    ModuleDefId, ModuleId,
};

/// Find a path that can be used to refer to a certain item. This can depend on
/// *from where* you're referring to the item, hence the `from` parameter.
pub fn find_path(db: &dyn DefDatabase, item: ItemInNs, from: ModuleId) -> Option<ModPath> {
    let _p = profile::span("find_path");
    find_path_inner(db, item, from, MAX_PATH_LEN, None)
}

pub fn find_path_prefixed(
    db: &dyn DefDatabase,
    item: ItemInNs,
    from: ModuleId,
    prefix_kind: PrefixKind,
) -> Option<ModPath> {
    let _p = profile::span("find_path_prefixed");
    find_path_inner(db, item, from, MAX_PATH_LEN, Some(prefix_kind))
}

const MAX_PATH_LEN: usize = 15;

impl ModPath {
    fn starts_with_std(&self) -> bool {
        self.segments().first() == Some(&known::std)
    }

    // When std library is present, paths starting with `std::`
    // should be preferred over paths starting with `core::` and `alloc::`
    fn can_start_with_std(&self) -> bool {
        let first_segment = self.segments().first();
        first_segment == Some(&known::alloc) || first_segment == Some(&known::core)
    }
}

fn check_self_super(def_map: &DefMap, item: ItemInNs, from: ModuleId) -> Option<ModPath> {
    if item == ItemInNs::Types(from.into()) {
        // - if the item is the module we're in, use `self`
        Some(ModPath::from_segments(PathKind::Super(0), Vec::new()))
    } else if let Some(parent_id) = def_map[from.local_id].parent {
        // - if the item is the parent module, use `super` (this is not used recursively, since `super::super` is ugly)
        let parent_id = def_map.module_id(parent_id);
        if item == ItemInNs::Types(ModuleDefId::ModuleId(parent_id)) {
            Some(ModPath::from_segments(PathKind::Super(1), Vec::new()))
        } else {
            None
        }
    } else {
        None
    }
}

#[derive(Copy, Clone, Debug, PartialEq, Eq)]
pub enum PrefixKind {
    /// Causes paths to always start with either `self`, `super`, `crate` or a crate-name.
    /// This is the same as plain, just that paths will start with `self` iprepended f the path
    /// starts with an identifier that is not a crate.
    BySelf,
    /// Causes paths to ignore imports in the local module.
    Plain,
    /// Causes paths to start with `crate` where applicable, effectively forcing paths to be absolute.
    ByCrate,
}

impl PrefixKind {
    #[inline]
    fn prefix(self) -> PathKind {
        match self {
            PrefixKind::BySelf => PathKind::Super(0),
            PrefixKind::Plain => PathKind::Plain,
            PrefixKind::ByCrate => PathKind::Crate,
        }
    }

    #[inline]
    fn is_absolute(&self) -> bool {
        self == &PrefixKind::ByCrate
    }
}

fn find_path_inner(
    db: &dyn DefDatabase,
    item: ItemInNs,
    from: ModuleId,
    max_len: usize,
    prefixed: Option<PrefixKind>,
) -> Option<ModPath> {
    if max_len == 0 {
        return None;
    }

    // Base cases:

    // - if the item is already in scope, return the name under which it is
    let def_map = from.def_map(db);
    let scope_name = def_map.with_ancestor_maps(db, from.local_id, &mut |def_map, local_id| {
        def_map[local_id].scope.name_of(item).map(|(name, _)| name.clone())
    });
    if prefixed.is_none() && scope_name.is_some() {
        return scope_name
            .map(|scope_name| ModPath::from_segments(PathKind::Plain, vec![scope_name]));
    }

    // - if the item is the crate root, return `crate`
    let root = def_map.module_id(def_map.root());
    if item == ItemInNs::Types(ModuleDefId::ModuleId(root)) && def_map.block_id().is_none() {
        return Some(ModPath::from_segments(PathKind::Crate, Vec::new()));
    }

    if prefixed.filter(PrefixKind::is_absolute).is_none() {
        if let modpath @ Some(_) = check_self_super(&def_map, item, from) {
            return modpath;
        }
    }

    // - if the item is the crate root of a dependency crate, return the name from the extern prelude
    for (name, def_id) in def_map.extern_prelude() {
        if item == ItemInNs::Types(*def_id) {
            let name = scope_name.unwrap_or_else(|| name.clone());
            return Some(ModPath::from_segments(PathKind::Plain, vec![name]));
        }
    }

    // - if the item is in the prelude, return the name from there
    if let Some(prelude_module) = def_map.prelude() {
        let prelude_def_map = prelude_module.def_map(db);
        let prelude_scope: &crate::item_scope::ItemScope =
            &prelude_def_map[prelude_module.local_id].scope;
        if let Some((name, vis)) = prelude_scope.name_of(item) {
            if vis.is_visible_from(db, from) {
                return Some(ModPath::from_segments(PathKind::Plain, vec![name.clone()]));
            }
        }
    }

    // - if the item is a builtin, it's in scope
    if let ItemInNs::Types(ModuleDefId::BuiltinType(builtin)) = item {
        return Some(ModPath::from_segments(PathKind::Plain, vec![builtin.as_name()]));
    }

    // Recursive case:
    // - if the item is an enum variant, refer to it via the enum
    if let Some(ModuleDefId::EnumVariantId(variant)) = item.as_module_def_id() {
        if let Some(mut path) = find_path(db, ItemInNs::Types(variant.parent.into()), from) {
            let data = db.enum_data(variant.parent);
            path.push_segment(data.variants[variant.local_id].name.clone());
            return Some(path);
        }
        // If this doesn't work, it seems we have no way of referring to the
        // enum; that's very weird, but there might still be a reexport of the
        // variant somewhere
    }

    // - otherwise, look for modules containing (reexporting) it and import it from one of those

    let crate_root = def_map.module_id(def_map.root());
    let crate_attrs = db.attrs(crate_root.into());
    let prefer_no_std = crate_attrs.by_key("no_std").exists();
    let mut best_path = None;
    let mut best_path_len = max_len;

    if item.krate(db) == Some(from.krate) {
        // Item was defined in the same crate that wants to import it. It cannot be found in any
        // dependency in this case.

        let local_imports = find_local_import_locations(db, item, from);
        for (module_id, name) in local_imports {
            if let Some(mut path) = find_path_inner(
                db,
                ItemInNs::Types(ModuleDefId::ModuleId(module_id)),
                from,
                best_path_len - 1,
                prefixed,
            ) {
                path.push_segment(name);

                let new_path = if let Some(best_path) = best_path {
                    select_best_path(best_path, path, prefer_no_std)
                } else {
                    path
                };
                best_path_len = new_path.len();
                best_path = Some(new_path);
            }
        }
    } else {
        // Item was defined in some upstream crate. This means that it must be exported from one,
        // too (unless we can't name it at all). It could *also* be (re)exported by the same crate
        // that wants to import it here, but we always prefer to use the external path here.

        let crate_graph = db.crate_graph();
        let extern_paths = crate_graph[from.krate].dependencies.iter().filter_map(|dep| {
            let import_map = db.import_map(dep.crate_id);
            import_map.import_info_for(item).and_then(|info| {
                // Determine best path for containing module and append last segment from `info`.
                let mut path = find_path_inner(
                    db,
                    ItemInNs::Types(ModuleDefId::ModuleId(info.container)),
                    from,
                    best_path_len - 1,
                    prefixed,
                )?;
                mark::hit!(partially_imported);
                path.push_segment(info.path.segments.last().unwrap().clone());
                Some(path)
            })
        });

        for path in extern_paths {
            let new_path = if let Some(best_path) = best_path {
                select_best_path(best_path, path, prefer_no_std)
            } else {
                path
            };
            best_path = Some(new_path);
        }
    }

    if let Some(mut prefix) = prefixed.map(PrefixKind::prefix) {
        if matches!(prefix, PathKind::Crate | PathKind::Super(0)) && def_map.block_id().is_some() {
            // Inner items cannot be referred to via `crate::` or `self::` paths.
            prefix = PathKind::Plain;
        }

        best_path.or_else(|| {
            scope_name.map(|scope_name| ModPath::from_segments(prefix, vec![scope_name]))
        })
    } else {
        best_path
    }
}

fn select_best_path(old_path: ModPath, new_path: ModPath, prefer_no_std: bool) -> ModPath {
    if old_path.starts_with_std() && new_path.can_start_with_std() {
        if prefer_no_std {
            mark::hit!(prefer_no_std_paths);
            new_path
        } else {
            mark::hit!(prefer_std_paths);
            old_path
        }
    } else if new_path.starts_with_std() && old_path.can_start_with_std() {
        if prefer_no_std {
            mark::hit!(prefer_no_std_paths);
            old_path
        } else {
            mark::hit!(prefer_std_paths);
            new_path
        }
    } else if new_path.len() < old_path.len() {
        new_path
    } else {
        old_path
    }
}

/// Finds locations in `from.krate` from which `item` can be imported by `from`.
fn find_local_import_locations(
    db: &dyn DefDatabase,
    item: ItemInNs,
    from: ModuleId,
) -> Vec<(ModuleId, Name)> {
    let _p = profile::span("find_local_import_locations");

    // `from` can import anything below `from` with visibility of at least `from`, and anything
    // above `from` with any visibility. That means we do not need to descend into private siblings
    // of `from` (and similar).

    let def_map = from.def_map(db);

    // Compute the initial worklist. We start with all direct child modules of `from` as well as all
    // of its (recursive) parent modules.
    let data = &def_map[from.local_id];
    let mut worklist =
        data.children.values().map(|child| def_map.module_id(*child)).collect::<Vec<_>>();
    let mut parent = data.parent;
    while let Some(p) = parent {
        worklist.push(def_map.module_id(p));
        parent = def_map[p].parent;
    }

    let mut seen: FxHashSet<_> = FxHashSet::default();

    let mut locations = Vec::new();
    while let Some(module) = worklist.pop() {
        if !seen.insert(module) {
            continue; // already processed this module
        }

        let ext_def_map;
        let data = if module.krate == from.krate {
            &def_map[module.local_id]
        } else {
            // The crate might reexport a module defined in another crate.
            ext_def_map = module.def_map(db);
            &ext_def_map[module.local_id]
        };

        if let Some((name, vis)) = data.scope.name_of(item) {
            if vis.is_visible_from(db, from) {
                let is_private = if let Visibility::Module(private_to) = vis {
                    private_to.local_id == module.local_id
                } else {
                    false
                };
                let is_original_def = if let Some(module_def_id) = item.as_module_def_id() {
                    data.scope.declarations().any(|it| it == module_def_id)
                } else {
                    false
                };

                // Ignore private imports. these could be used if we are
                // in a submodule of this module, but that's usually not
                // what the user wants; and if this module can import
                // the item and we're a submodule of it, so can we.
                // Also this keeps the cached data smaller.
                if !is_private || is_original_def {
                    locations.push((module, name.clone()));
                }
            }
        }

        // Descend into all modules visible from `from`.
        for (_, per_ns) in data.scope.entries() {
            if let Some((ModuleDefId::ModuleId(module), vis)) = per_ns.take_types_vis() {
                if vis.is_visible_from(db, from) {
                    worklist.push(module);
                }
            }
        }
    }

    locations
}

#[cfg(test)]
mod tests {
    use base_db::fixture::WithFixture;
    use hir_expand::hygiene::Hygiene;
    use syntax::ast::AstNode;
    use test_utils::mark;

    use crate::test_db::TestDB;

    use super::*;

    /// `code` needs to contain a cursor marker; checks that `find_path` for the
    /// item the `path` refers to returns that same path when called from the
    /// module the cursor is in.
    fn check_found_path_(ra_fixture: &str, path: &str, prefix_kind: Option<PrefixKind>) {
        let (db, pos) = TestDB::with_position(ra_fixture);
        let module = db.module_at_position(pos);
        let parsed_path_file = syntax::SourceFile::parse(&format!("use {};", path));
        let ast_path =
            parsed_path_file.syntax_node().descendants().find_map(syntax::ast::Path::cast).unwrap();
        let mod_path = ModPath::from_src(ast_path, &Hygiene::new_unhygienic()).unwrap();

        let def_map = module.def_map(&db);
        let resolved = def_map
            .resolve_path(
                &db,
                module.local_id,
                &mod_path,
                crate::item_scope::BuiltinShadowMode::Module,
            )
            .0
            .take_types()
            .unwrap();

        let found_path =
            find_path_inner(&db, ItemInNs::Types(resolved), module, MAX_PATH_LEN, prefix_kind);
        assert_eq!(found_path, Some(mod_path), "{:?}", prefix_kind);
    }

    fn check_found_path(
        ra_fixture: &str,
        unprefixed: &str,
        prefixed: &str,
        absolute: &str,
        self_prefixed: &str,
    ) {
        check_found_path_(ra_fixture, unprefixed, None);
        check_found_path_(ra_fixture, prefixed, Some(PrefixKind::Plain));
        check_found_path_(ra_fixture, absolute, Some(PrefixKind::ByCrate));
        check_found_path_(ra_fixture, self_prefixed, Some(PrefixKind::BySelf));
    }

    #[test]
    fn same_module() {
        let code = r#"
            //- /main.rs
            struct S;
            $0
        "#;
        check_found_path(code, "S", "S", "crate::S", "self::S");
    }

    #[test]
    fn enum_variant() {
        let code = r#"
            //- /main.rs
            enum E { A }
            $0
        "#;
        check_found_path(code, "E::A", "E::A", "E::A", "E::A");
    }

    #[test]
    fn sub_module() {
        let code = r#"
            //- /main.rs
            mod foo {
                pub struct S;
            }
            $0
        "#;
        check_found_path(code, "foo::S", "foo::S", "crate::foo::S", "self::foo::S");
    }

    #[test]
    fn super_module() {
        let code = r#"
            //- /main.rs
            mod foo;
            //- /foo.rs
            mod bar;
            struct S;
            //- /foo/bar.rs
            $0
        "#;
        check_found_path(code, "super::S", "super::S", "crate::foo::S", "super::S");
    }

    #[test]
    fn self_module() {
        let code = r#"
            //- /main.rs
            mod foo;
            //- /foo.rs
            $0
        "#;
        check_found_path(code, "self", "self", "crate::foo", "self");
    }

    #[test]
    fn crate_root() {
        let code = r#"
            //- /main.rs
            mod foo;
            //- /foo.rs
            $0
        "#;
        check_found_path(code, "crate", "crate", "crate", "crate");
    }

    #[test]
    fn same_crate() {
        let code = r#"
            //- /main.rs
            mod foo;
            struct S;
            //- /foo.rs
            $0
        "#;
        check_found_path(code, "crate::S", "crate::S", "crate::S", "crate::S");
    }

    #[test]
    fn different_crate() {
        let code = r#"
            //- /main.rs crate:main deps:std
            $0
            //- /std.rs crate:std
            pub struct S;
        "#;
        check_found_path(code, "std::S", "std::S", "std::S", "std::S");
    }

    #[test]
    fn different_crate_renamed() {
        let code = r#"
            //- /main.rs crate:main deps:std
            extern crate std as std_renamed;
            $0
            //- /std.rs crate:std
            pub struct S;
        "#;
        check_found_path(
            code,
            "std_renamed::S",
            "std_renamed::S",
            "std_renamed::S",
            "std_renamed::S",
        );
    }

    #[test]
    fn partially_imported() {
        mark::check!(partially_imported);
        // Tests that short paths are used even for external items, when parts of the path are
        // already in scope.
        let code = r#"
            //- /main.rs crate:main deps:syntax

            use syntax::ast;
            $0

            //- /lib.rs crate:syntax
            pub mod ast {
                pub enum ModuleItem {
                    A, B, C,
                }
            }
        "#;
        check_found_path(
            code,
            "ast::ModuleItem",
            "syntax::ast::ModuleItem",
            "syntax::ast::ModuleItem",
            "syntax::ast::ModuleItem",
        );

        let code = r#"
            //- /main.rs crate:main deps:syntax

            $0

            //- /lib.rs crate:syntax
            pub mod ast {
                pub enum ModuleItem {
                    A, B, C,
                }
            }
        "#;
        check_found_path(
            code,
            "syntax::ast::ModuleItem",
            "syntax::ast::ModuleItem",
            "syntax::ast::ModuleItem",
            "syntax::ast::ModuleItem",
        );
    }

    #[test]
    fn same_crate_reexport() {
        let code = r#"
            //- /main.rs
            mod bar {
                mod foo { pub(super) struct S; }
                pub(crate) use foo::*;
            }
            $0
        "#;
        check_found_path(code, "bar::S", "bar::S", "crate::bar::S", "self::bar::S");
    }

    #[test]
    fn same_crate_reexport_rename() {
        let code = r#"
            //- /main.rs
            mod bar {
                mod foo { pub(super) struct S; }
                pub(crate) use foo::S as U;
            }
            $0
        "#;
        check_found_path(code, "bar::U", "bar::U", "crate::bar::U", "self::bar::U");
    }

    #[test]
    fn different_crate_reexport() {
        let code = r#"
            //- /main.rs crate:main deps:std
            $0
            //- /std.rs crate:std deps:core
            pub use core::S;
            //- /core.rs crate:core
            pub struct S;
        "#;
        check_found_path(code, "std::S", "std::S", "std::S", "std::S");
    }

    #[test]
    fn prelude() {
        let code = r#"
            //- /main.rs crate:main deps:std
            $0
            //- /std.rs crate:std
            pub mod prelude { pub struct S; }
            #[prelude_import]
            pub use prelude::*;
        "#;
        check_found_path(code, "S", "S", "S", "S");
    }

    #[test]
    fn enum_variant_from_prelude() {
        let code = r#"
            //- /main.rs crate:main deps:std
            $0
            //- /std.rs crate:std
            pub mod prelude {
                pub enum Option<T> { Some(T), None }
                pub use Option::*;
            }
            #[prelude_import]
            pub use prelude::*;
        "#;
        check_found_path(code, "None", "None", "None", "None");
        check_found_path(code, "Some", "Some", "Some", "Some");
    }

    #[test]
    fn shortest_path() {
        let code = r#"
            //- /main.rs
            pub mod foo;
            pub mod baz;
            struct S;
            $0
            //- /foo.rs
            pub mod bar { pub struct S; }
            //- /baz.rs
            pub use crate::foo::bar::S;
        "#;
        check_found_path(code, "baz::S", "baz::S", "crate::baz::S", "self::baz::S");
    }

    #[test]
    fn discount_private_imports() {
        let code = r#"
            //- /main.rs
            mod foo;
            pub mod bar { pub struct S; }
            use bar::S;
            //- /foo.rs
            $0
        "#;
        // crate::S would be shorter, but using private imports seems wrong
        check_found_path(code, "crate::bar::S", "crate::bar::S", "crate::bar::S", "crate::bar::S");
    }

    #[test]
    fn import_cycle() {
        let code = r#"
            //- /main.rs
            pub mod foo;
            pub mod bar;
            pub mod baz;
            //- /bar.rs
            $0
            //- /foo.rs
            pub use super::baz;
            pub struct S;
            //- /baz.rs
            pub use super::foo;
        "#;
        check_found_path(code, "crate::foo::S", "crate::foo::S", "crate::foo::S", "crate::foo::S");
    }

    #[test]
    fn prefer_std_paths_over_alloc() {
        mark::check!(prefer_std_paths);
        let code = r#"
        //- /main.rs crate:main deps:alloc,std
        $0

        //- /std.rs crate:std deps:alloc
        pub mod sync {
            pub use alloc::sync::Arc;
        }

        //- /zzz.rs crate:alloc
        pub mod sync {
            pub struct Arc;
        }
        "#;
        check_found_path(
            code,
            "std::sync::Arc",
            "std::sync::Arc",
            "std::sync::Arc",
            "std::sync::Arc",
        );
    }

    #[test]
    fn prefer_core_paths_over_std() {
        mark::check!(prefer_no_std_paths);
        let code = r#"
        //- /main.rs crate:main deps:core,std
        #![no_std]

        $0

        //- /std.rs crate:std deps:core

        pub mod fmt {
            pub use core::fmt::Error;
        }

        //- /zzz.rs crate:core

        pub mod fmt {
            pub struct Error;
        }
        "#;
        check_found_path(
            code,
            "core::fmt::Error",
            "core::fmt::Error",
            "core::fmt::Error",
            "core::fmt::Error",
        );
    }

    #[test]
    fn prefer_alloc_paths_over_std() {
        let code = r#"
        //- /main.rs crate:main deps:alloc,std
        #![no_std]

        $0

        //- /std.rs crate:std deps:alloc

        pub mod sync {
            pub use alloc::sync::Arc;
        }

        //- /zzz.rs crate:alloc

        pub mod sync {
            pub struct Arc;
        }
        "#;
        check_found_path(
            code,
            "alloc::sync::Arc",
            "alloc::sync::Arc",
            "alloc::sync::Arc",
            "alloc::sync::Arc",
        );
    }

    #[test]
    fn prefer_shorter_paths_if_not_alloc() {
        let code = r#"
        //- /main.rs crate:main deps:megaalloc,std
        $0

        //- /std.rs crate:std deps:megaalloc
        pub mod sync {
            pub use megaalloc::sync::Arc;
        }

        //- /zzz.rs crate:megaalloc
        pub struct Arc;
        "#;
        check_found_path(
            code,
            "megaalloc::Arc",
            "megaalloc::Arc",
            "megaalloc::Arc",
            "megaalloc::Arc",
        );
    }

    #[test]
    fn builtins_are_in_scope() {
        let code = r#"
        //- /main.rs
        $0

        pub mod primitive {
            pub use u8;
        }
        "#;
        check_found_path(code, "u8", "u8", "u8", "u8");
        check_found_path(code, "u16", "u16", "u16", "u16");
    }

    #[test]
    fn inner_items() {
        check_found_path(
            r#"
            fn main() {
                struct Inner {}
                $0
            }
        "#,
            "Inner",
            "Inner",
            "Inner",
            "Inner",
        );
    }

    #[test]
    fn inner_items_from_outer_scope() {
        check_found_path(
            r#"
            fn main() {
                struct Struct {}
                {
                    $0
                }
            }
        "#,
            "Struct",
            "Struct",
            "Struct",
            "Struct",
        );
    }

    #[test]
    fn inner_items_from_inner_module() {
        check_found_path(
            r#"
            fn main() {
                mod module {
                    struct Struct {}
                }
                {
                    $0
                }
            }
        "#,
            "module::Struct",
            "module::Struct",
            "module::Struct",
            "module::Struct",
        );
    }

    #[test]
    #[ignore]
    fn inner_items_from_parent_module() {
        // FIXME: ItemTree currently associates all inner items with `main`. Luckily, this sort of
        // code is very rare, so this isn't terrible.
        // To fix it, we should probably build dedicated `ItemTree`s for inner items, and not store
        // them in the file's main ItemTree. This would also allow us to stop parsing function
        // bodies when we only want to compute the crate's main DefMap.
        check_found_path(
            r#"
            fn main() {
                struct Struct {}
                mod module {
                    $0
                }
            }
        "#,
            "super::Struct",
            "super::Struct",
            "super::Struct",
            "super::Struct",
        );
    }
}
