use ide_db::helpers::{
    import_assets::{ImportAssets, ImportCandidate},
    insert_use::{insert_use, ImportScope},
    mod_path_to_ast,
};
use syntax::{ast, AstNode, SyntaxNode};

use crate::{AssistContext, AssistId, AssistKind, Assists, GroupLabel};

// Feature: Auto Import
//
// Using the `auto-import` assist it is possible to insert missing imports for unresolved items.
// When inserting an import it will do so in a structured manner by keeping imports grouped,
// separated by a newline in the following order:
//
// - `std` and `core`
// - External Crates
// - Current Crate, paths prefixed by `crate`
// - Current Module, paths prefixed by `self`
// - Super Module, paths prefixed by `super`
//
// Example:
// ```rust
// use std::fs::File;
//
// use itertools::Itertools;
// use syntax::ast;
//
// use crate::utils::insert_use;
//
// use self::auto_import;
//
// use super::AssistContext;
// ```
//
// .Merge Behaviour
//
// It is possible to configure how use-trees are merged with the `importMergeBehaviour` setting.
// It has the following configurations:
//
// - `full`: This setting will cause auto-import to always completely merge use-trees that share the
//  same path prefix while also merging inner trees that share the same path-prefix. This kind of
//  nesting is only supported in Rust versions later than 1.24.
// - `last`: This setting will cause auto-import to merge use-trees as long as the resulting tree
//  will only contain a nesting of single segment paths at the very end.
// - `none`: This setting will cause auto-import to never merge use-trees keeping them as simple
//  paths.
//
// In `VS Code` the configuration for this is `rust-analyzer.assist.importMergeBehaviour`.
//
// .Import Prefix
//
// The style of imports in the same crate is configurable through the `importPrefix` setting.
// It has the following configurations:
//
// - `by_crate`: This setting will force paths to be always absolute, starting with the `crate`
//  prefix, unless the item is defined outside of the current crate.
// - `by_self`: This setting will force paths that are relative to the current module to always
//  start with `self`. This will result in paths that always start with either `crate`, `self`,
//  `super` or an extern crate identifier.
// - `plain`: This setting does not impose any restrictions in imports.
//
// In `VS Code` the configuration for this is `rust-analyzer.assist.importPrefix`.

// Assist: auto_import
//
// If the name is unresolved, provides all possible imports for it.
//
// ```
// fn main() {
//     let map = HashMap$0::new();
// }
// # pub mod std { pub mod collections { pub struct HashMap { } } }
// ```
// ->
// ```
// use std::collections::HashMap;
//
// fn main() {
//     let map = HashMap::new();
// }
// # pub mod std { pub mod collections { pub struct HashMap { } } }
// ```
pub(crate) fn auto_import(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let (import_assets, syntax_under_caret) = find_importable_node(ctx)?;
    let proposed_imports =
        import_assets.search_for_imports(&ctx.sema, ctx.config.insert_use.prefix_kind);
    if proposed_imports.is_empty() {
        return None;
    }

    let range = ctx.sema.original_range(&syntax_under_caret).range;
    let group = import_group_message(import_assets.import_candidate());
    let scope = ImportScope::find_insert_use_container(&syntax_under_caret, &ctx.sema)?;
    for (import, _) in proposed_imports {
        acc.add_group(
            &group,
            AssistId("auto_import", AssistKind::QuickFix),
            format!("Import `{}`", &import),
            range,
            |builder| {
                let rewriter =
                    insert_use(&scope, mod_path_to_ast(&import), ctx.config.insert_use.merge);
                builder.rewrite(rewriter);
            },
        );
    }
    Some(())
}

pub(super) fn find_importable_node(ctx: &AssistContext) -> Option<(ImportAssets, SyntaxNode)> {
    if let Some(path_under_caret) = ctx.find_node_at_offset_with_descend::<ast::Path>() {
        ImportAssets::for_exact_path(&path_under_caret, &ctx.sema)
            .zip(Some(path_under_caret.syntax().clone()))
    } else if let Some(method_under_caret) =
        ctx.find_node_at_offset_with_descend::<ast::MethodCallExpr>()
    {
        ImportAssets::for_method_call(&method_under_caret, &ctx.sema)
            .zip(Some(method_under_caret.syntax().clone()))
    } else {
        None
    }
}

fn import_group_message(import_candidate: &ImportCandidate) -> GroupLabel {
    let name = match import_candidate {
        ImportCandidate::Path(candidate) => format!("Import {}", candidate.name.text()),
        ImportCandidate::TraitAssocItem(candidate) => {
            format!("Import a trait for item {}", candidate.name.text())
        }
        ImportCandidate::TraitMethod(candidate) => {
            format!("Import a trait for method {}", candidate.name.text())
        }
    };
    GroupLabel(name)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tests::{check_assist, check_assist_not_applicable, check_assist_target};

    #[test]
    fn applicable_when_found_an_import_partial() {
        check_assist(
            auto_import,
            r"
            mod std {
                pub mod fmt {
                    pub struct Formatter;
                }
            }

            use std::fmt;

            $0Formatter
            ",
            r"
            mod std {
                pub mod fmt {
                    pub struct Formatter;
                }
            }

            use std::fmt::{self, Formatter};

            Formatter
            ",
        );
    }

    #[test]
    fn applicable_when_found_an_import() {
        check_assist(
            auto_import,
            r"
            $0PubStruct

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
            r"
            use PubMod::PubStruct;

            PubStruct

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
        );
    }

    #[test]
    fn applicable_when_found_an_import_in_macros() {
        check_assist(
            auto_import,
            r"
            macro_rules! foo {
                ($i:ident) => { fn foo(a: $i) {} }
            }
            foo!(Pub$0Struct);

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
            r"
            use PubMod::PubStruct;

            macro_rules! foo {
                ($i:ident) => { fn foo(a: $i) {} }
            }
            foo!(PubStruct);

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
        );
    }

    #[test]
    fn auto_imports_are_merged() {
        check_assist(
            auto_import,
            r"
            use PubMod::PubStruct1;

            struct Test {
                test: Pub$0Struct2<u8>,
            }

            pub mod PubMod {
                pub struct PubStruct1;
                pub struct PubStruct2<T> {
                    _t: T,
                }
            }
            ",
            r"
            use PubMod::{PubStruct1, PubStruct2};

            struct Test {
                test: PubStruct2<u8>,
            }

            pub mod PubMod {
                pub struct PubStruct1;
                pub struct PubStruct2<T> {
                    _t: T,
                }
            }
            ",
        );
    }

    #[test]
    fn applicable_when_found_multiple_imports() {
        check_assist(
            auto_import,
            r"
            PubSt$0ruct

            pub mod PubMod1 {
                pub struct PubStruct;
            }
            pub mod PubMod2 {
                pub struct PubStruct;
            }
            pub mod PubMod3 {
                pub struct PubStruct;
            }
            ",
            r"
            use PubMod3::PubStruct;

            PubStruct

            pub mod PubMod1 {
                pub struct PubStruct;
            }
            pub mod PubMod2 {
                pub struct PubStruct;
            }
            pub mod PubMod3 {
                pub struct PubStruct;
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_already_imported_types() {
        check_assist_not_applicable(
            auto_import,
            r"
            use PubMod::PubStruct;

            PubStruct$0

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_types_with_private_paths() {
        check_assist_not_applicable(
            auto_import,
            r"
            PrivateStruct$0

            pub mod PubMod {
                struct PrivateStruct;
            }
            ",
        );
    }

    #[test]
    fn not_applicable_when_no_imports_found() {
        check_assist_not_applicable(
            auto_import,
            "
            PubStruct$0",
        );
    }

    #[test]
    fn not_applicable_in_import_statements() {
        check_assist_not_applicable(
            auto_import,
            r"
            use PubStruct$0;

            pub mod PubMod {
                pub struct PubStruct;
            }",
        );
    }

    #[test]
    fn function_import() {
        check_assist(
            auto_import,
            r"
            test_function$0

            pub mod PubMod {
                pub fn test_function() {};
            }
            ",
            r"
            use PubMod::test_function;

            test_function

            pub mod PubMod {
                pub fn test_function() {};
            }
            ",
        );
    }

    #[test]
    fn macro_import() {
        check_assist(
            auto_import,
            r"
//- /lib.rs crate:crate_with_macro
#[macro_export]
macro_rules! foo {
    () => ()
}

//- /main.rs crate:main deps:crate_with_macro
fn main() {
    foo$0
}
",
            r"use crate_with_macro::foo;

fn main() {
    foo
}
",
        );
    }

    #[test]
    fn auto_import_target() {
        check_assist_target(
            auto_import,
            r"
            struct AssistInfo {
                group_label: Option<$0GroupLabel>,
            }

            mod m { pub struct GroupLabel; }
            ",
            "GroupLabel",
        )
    }

    #[test]
    fn not_applicable_when_path_start_is_imported() {
        check_assist_not_applicable(
            auto_import,
            r"
            pub mod mod1 {
                pub mod mod2 {
                    pub mod mod3 {
                        pub struct TestStruct;
                    }
                }
            }

            use mod1::mod2;
            fn main() {
                mod2::mod3::TestStruct$0
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_imported_function() {
        check_assist_not_applicable(
            auto_import,
            r"
            pub mod test_mod {
                pub fn test_function() {}
            }

            use test_mod::test_function;
            fn main() {
                test_function$0
            }
            ",
        );
    }

    #[test]
    fn associated_struct_function() {
        check_assist(
            auto_import,
            r"
            mod test_mod {
                pub struct TestStruct {}
                impl TestStruct {
                    pub fn test_function() {}
                }
            }

            fn main() {
                TestStruct::test_function$0
            }
            ",
            r"
            use test_mod::TestStruct;

            mod test_mod {
                pub struct TestStruct {}
                impl TestStruct {
                    pub fn test_function() {}
                }
            }

            fn main() {
                TestStruct::test_function
            }
            ",
        );
    }

    #[test]
    fn associated_struct_const() {
        check_assist(
            auto_import,
            r"
            mod test_mod {
                pub struct TestStruct {}
                impl TestStruct {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                TestStruct::TEST_CONST$0
            }
            ",
            r"
            use test_mod::TestStruct;

            mod test_mod {
                pub struct TestStruct {}
                impl TestStruct {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                TestStruct::TEST_CONST
            }
            ",
        );
    }

    #[test]
    fn associated_trait_function() {
        check_assist(
            auto_import,
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_function();
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_function() {}
                }
            }

            fn main() {
                test_mod::TestStruct::test_function$0
            }
            ",
            r"
            use test_mod::TestTrait;

            mod test_mod {
                pub trait TestTrait {
                    fn test_function();
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_function() {}
                }
            }

            fn main() {
                test_mod::TestStruct::test_function
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_imported_trait_for_function() {
        check_assist_not_applicable(
            auto_import,
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_function();
                }
                pub trait TestTrait2 {
                    fn test_function();
                }
                pub enum TestEnum {
                    One,
                    Two,
                }
                impl TestTrait2 for TestEnum {
                    fn test_function() {}
                }
                impl TestTrait for TestEnum {
                    fn test_function() {}
                }
            }

            use test_mod::TestTrait2;
            fn main() {
                test_mod::TestEnum::test_function$0;
            }
            ",
        )
    }

    #[test]
    fn associated_trait_const() {
        check_assist(
            auto_import,
            r"
            mod test_mod {
                pub trait TestTrait {
                    const TEST_CONST: u8;
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                test_mod::TestStruct::TEST_CONST$0
            }
            ",
            r"
            use test_mod::TestTrait;

            mod test_mod {
                pub trait TestTrait {
                    const TEST_CONST: u8;
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                test_mod::TestStruct::TEST_CONST
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_imported_trait_for_const() {
        check_assist_not_applicable(
            auto_import,
            r"
            mod test_mod {
                pub trait TestTrait {
                    const TEST_CONST: u8;
                }
                pub trait TestTrait2 {
                    const TEST_CONST: f64;
                }
                pub enum TestEnum {
                    One,
                    Two,
                }
                impl TestTrait2 for TestEnum {
                    const TEST_CONST: f64 = 42.0;
                }
                impl TestTrait for TestEnum {
                    const TEST_CONST: u8 = 42;
                }
            }

            use test_mod::TestTrait2;
            fn main() {
                test_mod::TestEnum::TEST_CONST$0;
            }
            ",
        )
    }

    #[test]
    fn trait_method() {
        check_assist(
            auto_import,
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method(&self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(&self) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_struct.test_meth$0od()
            }
            ",
            r"
            use test_mod::TestTrait;

            mod test_mod {
                pub trait TestTrait {
                    fn test_method(&self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(&self) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_struct.test_method()
            }
            ",
        );
    }

    #[test]
    fn trait_method_cross_crate() {
        check_assist(
            auto_import,
            r"
            //- /main.rs crate:main deps:dep
            fn main() {
                let test_struct = dep::test_mod::TestStruct {};
                test_struct.test_meth$0od()
            }
            //- /dep.rs crate:dep
            pub mod test_mod {
                pub trait TestTrait {
                    fn test_method(&self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(&self) {}
                }
            }
            ",
            r"
            use dep::test_mod::TestTrait;

            fn main() {
                let test_struct = dep::test_mod::TestStruct {};
                test_struct.test_method()
            }
            ",
        );
    }

    #[test]
    fn assoc_fn_cross_crate() {
        check_assist(
            auto_import,
            r"
            //- /main.rs crate:main deps:dep
            fn main() {
                dep::test_mod::TestStruct::test_func$0tion
            }
            //- /dep.rs crate:dep
            pub mod test_mod {
                pub trait TestTrait {
                    fn test_function();
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_function() {}
                }
            }
            ",
            r"
            use dep::test_mod::TestTrait;

            fn main() {
                dep::test_mod::TestStruct::test_function
            }
            ",
        );
    }

    #[test]
    fn assoc_const_cross_crate() {
        check_assist(
            auto_import,
            r"
            //- /main.rs crate:main deps:dep
            fn main() {
                dep::test_mod::TestStruct::CONST$0
            }
            //- /dep.rs crate:dep
            pub mod test_mod {
                pub trait TestTrait {
                    const CONST: bool;
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    const CONST: bool = true;
                }
            }
            ",
            r"
            use dep::test_mod::TestTrait;

            fn main() {
                dep::test_mod::TestStruct::CONST
            }
            ",
        );
    }

    #[test]
    fn assoc_fn_as_method_cross_crate() {
        check_assist_not_applicable(
            auto_import,
            r"
            //- /main.rs crate:main deps:dep
            fn main() {
                let test_struct = dep::test_mod::TestStruct {};
                test_struct.test_func$0tion()
            }
            //- /dep.rs crate:dep
            pub mod test_mod {
                pub trait TestTrait {
                    fn test_function();
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_function() {}
                }
            }
            ",
        );
    }

    #[test]
    fn private_trait_cross_crate() {
        check_assist_not_applicable(
            auto_import,
            r"
            //- /main.rs crate:main deps:dep
            fn main() {
                let test_struct = dep::test_mod::TestStruct {};
                test_struct.test_meth$0od()
            }
            //- /dep.rs crate:dep
            pub mod test_mod {
                trait TestTrait {
                    fn test_method(&self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(&self) {}
                }
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_imported_trait_for_method() {
        check_assist_not_applicable(
            auto_import,
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method(&self);
                }
                pub trait TestTrait2 {
                    fn test_method(&self);
                }
                pub enum TestEnum {
                    One,
                    Two,
                }
                impl TestTrait2 for TestEnum {
                    fn test_method(&self) {}
                }
                impl TestTrait for TestEnum {
                    fn test_method(&self) {}
                }
            }

            use test_mod::TestTrait2;
            fn main() {
                let one = test_mod::TestEnum::One;
                one.test$0_method();
            }
            ",
        )
    }

    #[test]
    fn dep_import() {
        check_assist(
            auto_import,
            r"
//- /lib.rs crate:dep
pub struct Struct;

//- /main.rs crate:main deps:dep
fn main() {
    Struct$0
}
",
            r"use dep::Struct;

fn main() {
    Struct
}
",
        );
    }

    #[test]
    fn whole_segment() {
        // Tests that only imports whose last segment matches the identifier get suggested.
        check_assist(
            auto_import,
            r"
//- /lib.rs crate:dep
pub mod fmt {
    pub trait Display {}
}

pub fn panic_fmt() {}

//- /main.rs crate:main deps:dep
struct S;

impl f$0mt::Display for S {}
",
            r"use dep::fmt;

struct S;

impl fmt::Display for S {}
",
        );
    }

    #[test]
    fn macro_generated() {
        // Tests that macro-generated items are suggested from external crates.
        check_assist(
            auto_import,
            r"
//- /lib.rs crate:dep
macro_rules! mac {
    () => {
        pub struct Cheese;
    };
}

mac!();

//- /main.rs crate:main deps:dep
fn main() {
    Cheese$0;
}
",
            r"use dep::Cheese;

fn main() {
    Cheese;
}
",
        );
    }

    #[test]
    fn casing() {
        // Tests that differently cased names don't interfere and we only suggest the matching one.
        check_assist(
            auto_import,
            r"
//- /lib.rs crate:dep
pub struct FMT;
pub struct fmt;

//- /main.rs crate:main deps:dep
fn main() {
    FMT$0;
}
",
            r"use dep::FMT;

fn main() {
    FMT;
}
",
        );
    }
}
