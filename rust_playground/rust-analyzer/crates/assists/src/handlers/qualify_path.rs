use std::iter;

use hir::{AsAssocItem, AsName};
use ide_db::helpers::{import_assets::ImportCandidate, mod_path_to_ast};
use ide_db::RootDatabase;
use syntax::{
    ast,
    ast::{make, ArgListOwner},
    AstNode,
};
use test_utils::mark;

use crate::{
    assist_context::{AssistContext, Assists},
    AssistId, AssistKind, GroupLabel,
};

use super::auto_import::find_importable_node;

// Assist: qualify_path
//
// If the name is unresolved, provides all possible qualified paths for it.
//
// ```
// fn main() {
//     let map = HashMap$0::new();
// }
// # pub mod std { pub mod collections { pub struct HashMap { } } }
// ```
// ->
// ```
// fn main() {
//     let map = std::collections::HashMap::new();
// }
// # pub mod std { pub mod collections { pub struct HashMap { } } }
// ```
pub(crate) fn qualify_path(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let (import_assets, syntax_under_caret) = find_importable_node(ctx)?;
    let proposed_imports = import_assets.search_for_relative_paths(&ctx.sema);
    if proposed_imports.is_empty() {
        return None;
    }

    let candidate = import_assets.import_candidate();
    let range = ctx.sema.original_range(&syntax_under_caret).range;

    let qualify_candidate = match candidate {
        ImportCandidate::Path(candidate) => {
            if candidate.qualifier.is_some() {
                mark::hit!(qualify_path_qualifier_start);
                let path = ast::Path::cast(syntax_under_caret)?;
                let (prev_segment, segment) = (path.qualifier()?.segment()?, path.segment()?);
                QualifyCandidate::QualifierStart(segment, prev_segment.generic_arg_list())
            } else {
                mark::hit!(qualify_path_unqualified_name);
                let path = ast::Path::cast(syntax_under_caret)?;
                let generics = path.segment()?.generic_arg_list();
                QualifyCandidate::UnqualifiedName(generics)
            }
        }
        ImportCandidate::TraitAssocItem(_) => {
            mark::hit!(qualify_path_trait_assoc_item);
            let path = ast::Path::cast(syntax_under_caret)?;
            let (qualifier, segment) = (path.qualifier()?, path.segment()?);
            QualifyCandidate::TraitAssocItem(qualifier, segment)
        }
        ImportCandidate::TraitMethod(_) => {
            mark::hit!(qualify_path_trait_method);
            let mcall_expr = ast::MethodCallExpr::cast(syntax_under_caret)?;
            QualifyCandidate::TraitMethod(ctx.sema.db, mcall_expr)
        }
    };

    let group_label = group_label(candidate);
    for (import, item) in proposed_imports {
        acc.add_group(
            &group_label,
            AssistId("qualify_path", AssistKind::QuickFix),
            label(candidate, &import),
            range,
            |builder| {
                qualify_candidate.qualify(
                    |replace_with: String| builder.replace(range, replace_with),
                    import,
                    item,
                )
            },
        );
    }
    Some(())
}

enum QualifyCandidate<'db> {
    QualifierStart(ast::PathSegment, Option<ast::GenericArgList>),
    UnqualifiedName(Option<ast::GenericArgList>),
    TraitAssocItem(ast::Path, ast::PathSegment),
    TraitMethod(&'db RootDatabase, ast::MethodCallExpr),
}

impl QualifyCandidate<'_> {
    fn qualify(&self, mut replacer: impl FnMut(String), import: hir::ModPath, item: hir::ItemInNs) {
        let import = mod_path_to_ast(&import);
        match self {
            QualifyCandidate::QualifierStart(segment, generics) => {
                let generics = generics.as_ref().map_or_else(String::new, ToString::to_string);
                replacer(format!("{}{}::{}", import, generics, segment));
            }
            QualifyCandidate::UnqualifiedName(generics) => {
                let generics = generics.as_ref().map_or_else(String::new, ToString::to_string);
                replacer(format!("{}{}", import.to_string(), generics));
            }
            QualifyCandidate::TraitAssocItem(qualifier, segment) => {
                replacer(format!("<{} as {}>::{}", qualifier, import, segment));
            }
            &QualifyCandidate::TraitMethod(db, ref mcall_expr) => {
                Self::qualify_trait_method(db, mcall_expr, replacer, import, item);
            }
        }
    }

    fn qualify_trait_method(
        db: &RootDatabase,
        mcall_expr: &ast::MethodCallExpr,
        mut replacer: impl FnMut(String),
        import: ast::Path,
        item: hir::ItemInNs,
    ) -> Option<()> {
        let receiver = mcall_expr.receiver()?;
        let trait_method_name = mcall_expr.name_ref()?;
        let generics =
            mcall_expr.generic_arg_list().as_ref().map_or_else(String::new, ToString::to_string);
        let arg_list = mcall_expr.arg_list().map(|arg_list| arg_list.args());
        let trait_ = item_as_trait(db, item)?;
        let method = find_trait_method(db, trait_, &trait_method_name)?;
        if let Some(self_access) = method.self_param(db).map(|sp| sp.access(db)) {
            let receiver = match self_access {
                hir::Access::Shared => make::expr_ref(receiver, false),
                hir::Access::Exclusive => make::expr_ref(receiver, true),
                hir::Access::Owned => receiver,
            };
            replacer(format!(
                "{}::{}{}{}",
                import,
                trait_method_name,
                generics,
                match arg_list {
                    Some(args) => make::arg_list(iter::once(receiver).chain(args)),
                    None => make::arg_list(iter::once(receiver)),
                }
            ));
        }
        Some(())
    }
}

fn find_trait_method(
    db: &RootDatabase,
    trait_: hir::Trait,
    trait_method_name: &ast::NameRef,
) -> Option<hir::Function> {
    if let Some(hir::AssocItem::Function(method)) =
        trait_.items(db).into_iter().find(|item: &hir::AssocItem| {
            item.name(db).map(|name| name == trait_method_name.as_name()).unwrap_or(false)
        })
    {
        Some(method)
    } else {
        None
    }
}

fn item_as_trait(db: &RootDatabase, item: hir::ItemInNs) -> Option<hir::Trait> {
    let item_module_def = hir::ModuleDef::from(item.as_module_def_id()?);

    if let hir::ModuleDef::Trait(trait_) = item_module_def {
        Some(trait_)
    } else {
        item_module_def.as_assoc_item(db)?.containing_trait(db)
    }
}

fn group_label(candidate: &ImportCandidate) -> GroupLabel {
    let name = match candidate {
        ImportCandidate::Path(it) => &it.name,
        ImportCandidate::TraitAssocItem(it) | ImportCandidate::TraitMethod(it) => &it.name,
    }
    .text();
    GroupLabel(format!("Qualify {}", name))
}

fn label(candidate: &ImportCandidate, import: &hir::ModPath) -> String {
    match candidate {
        ImportCandidate::Path(candidate) => {
            if candidate.qualifier.is_some() {
                format!("Qualify with `{}`", &import)
            } else {
                format!("Qualify as `{}`", &import)
            }
        }
        ImportCandidate::TraitAssocItem(_) => format!("Qualify `{}`", &import),
        ImportCandidate::TraitMethod(_) => format!("Qualify with cast as `{}`", &import),
    }
}

#[cfg(test)]
mod tests {
    use crate::tests::{check_assist, check_assist_not_applicable, check_assist_target};

    use super::*;

    #[test]
    fn applicable_when_found_an_import_partial() {
        mark::check!(qualify_path_unqualified_name);
        check_assist(
            qualify_path,
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

            use std::fmt;

            fmt::Formatter
            ",
        );
    }

    #[test]
    fn applicable_when_found_an_import() {
        check_assist(
            qualify_path,
            r"
            $0PubStruct

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
            r"
            PubMod::PubStruct

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
        );
    }

    #[test]
    fn applicable_in_macros() {
        check_assist(
            qualify_path,
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
            macro_rules! foo {
                ($i:ident) => { fn foo(a: $i) {} }
            }
            foo!(PubMod::PubStruct);

            pub mod PubMod {
                pub struct PubStruct;
            }
            ",
        );
    }

    #[test]
    fn applicable_when_found_multiple_imports() {
        check_assist(
            qualify_path,
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
            PubMod3::PubStruct

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
            qualify_path,
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
            qualify_path,
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
            qualify_path,
            "
            PubStruct$0",
        );
    }

    #[test]
    fn not_applicable_in_import_statements() {
        check_assist_not_applicable(
            qualify_path,
            r"
            use PubStruct$0;

            pub mod PubMod {
                pub struct PubStruct;
            }",
        );
    }

    #[test]
    fn qualify_function() {
        check_assist(
            qualify_path,
            r"
            test_function$0

            pub mod PubMod {
                pub fn test_function() {};
            }
            ",
            r"
            PubMod::test_function

            pub mod PubMod {
                pub fn test_function() {};
            }
            ",
        );
    }

    #[test]
    fn qualify_macro() {
        check_assist(
            qualify_path,
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
            r"
fn main() {
    crate_with_macro::foo
}
",
        );
    }

    #[test]
    fn qualify_path_target() {
        check_assist_target(
            qualify_path,
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
            qualify_path,
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
            qualify_path,
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
            qualify_path,
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
            mod test_mod {
                pub struct TestStruct {}
                impl TestStruct {
                    pub fn test_function() {}
                }
            }

            fn main() {
                test_mod::TestStruct::test_function
            }
            ",
        );
    }

    #[test]
    fn associated_struct_const() {
        mark::check!(qualify_path_qualifier_start);
        check_assist(
            qualify_path,
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
            mod test_mod {
                pub struct TestStruct {}
                impl TestStruct {
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
    fn associated_trait_function() {
        check_assist(
            qualify_path,
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
                <test_mod::TestStruct as test_mod::TestTrait>::test_function
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_imported_trait_for_function() {
        check_assist_not_applicable(
            qualify_path,
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
        mark::check!(qualify_path_trait_assoc_item);
        check_assist(
            qualify_path,
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
                <test_mod::TestStruct as test_mod::TestTrait>::TEST_CONST
            }
            ",
        );
    }

    #[test]
    fn not_applicable_for_imported_trait_for_const() {
        check_assist_not_applicable(
            qualify_path,
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
        mark::check!(qualify_path_trait_method);
        check_assist(
            qualify_path,
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
                test_mod::TestTrait::test_method(&test_struct)
            }
            ",
        );
    }

    #[test]
    fn trait_method_multi_params() {
        check_assist(
            qualify_path,
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method(&self, test: i32);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(&self, test: i32) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_struct.test_meth$0od(42)
            }
            ",
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method(&self, test: i32);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(&self, test: i32) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_mod::TestTrait::test_method(&test_struct, 42)
            }
            ",
        );
    }

    #[test]
    fn trait_method_consume() {
        check_assist(
            qualify_path,
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method(self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(self) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_struct.test_meth$0od()
            }
            ",
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method(self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method(self) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_mod::TestTrait::test_method(test_struct)
            }
            ",
        );
    }

    #[test]
    fn trait_method_cross_crate() {
        check_assist(
            qualify_path,
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
            fn main() {
                let test_struct = dep::test_mod::TestStruct {};
                dep::test_mod::TestTrait::test_method(&test_struct)
            }
            ",
        );
    }

    #[test]
    fn assoc_fn_cross_crate() {
        check_assist(
            qualify_path,
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
            fn main() {
                <dep::test_mod::TestStruct as dep::test_mod::TestTrait>::test_function
            }
            ",
        );
    }

    #[test]
    fn assoc_const_cross_crate() {
        check_assist(
            qualify_path,
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
            fn main() {
                <dep::test_mod::TestStruct as dep::test_mod::TestTrait>::CONST
            }
            ",
        );
    }

    #[test]
    fn assoc_fn_as_method_cross_crate() {
        check_assist_not_applicable(
            qualify_path,
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
            qualify_path,
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
            qualify_path,
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
            qualify_path,
            r"
//- /lib.rs crate:dep
pub struct Struct;

//- /main.rs crate:main deps:dep
fn main() {
    Struct$0
}
",
            r"
fn main() {
    dep::Struct
}
",
        );
    }

    #[test]
    fn whole_segment() {
        // Tests that only imports whose last segment matches the identifier get suggested.
        check_assist(
            qualify_path,
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
            r"
struct S;

impl dep::fmt::Display for S {}
",
        );
    }

    #[test]
    fn macro_generated() {
        // Tests that macro-generated items are suggested from external crates.
        check_assist(
            qualify_path,
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
            r"
fn main() {
    dep::Cheese;
}
",
        );
    }

    #[test]
    fn casing() {
        // Tests that differently cased names don't interfere and we only suggest the matching one.
        check_assist(
            qualify_path,
            r"
//- /lib.rs crate:dep
pub struct FMT;
pub struct fmt;

//- /main.rs crate:main deps:dep
fn main() {
    FMT$0;
}
",
            r"
fn main() {
    dep::FMT;
}
",
        );
    }

    #[test]
    fn keep_generic_annotations() {
        check_assist(
            qualify_path,
            r"
//- /lib.rs crate:dep
pub mod generic { pub struct Thing<'a, T>(&'a T); }

//- /main.rs crate:main deps:dep
fn foo() -> Thin$0g<'static, ()> {}

fn main() {}
",
            r"
fn foo() -> dep::generic::Thing<'static, ()> {}

fn main() {}
",
        );
    }

    #[test]
    fn keep_generic_annotations_leading_colon() {
        check_assist(
            qualify_path,
            r"
//- /lib.rs crate:dep
pub mod generic { pub struct Thing<'a, T>(&'a T); }

//- /main.rs crate:main deps:dep
fn foo() -> Thin$0g::<'static, ()> {}

fn main() {}
",
            r"
fn foo() -> dep::generic::Thing::<'static, ()> {}

fn main() {}
",
        );
    }

    #[test]
    fn associated_struct_const_generic() {
        check_assist(
            qualify_path,
            r"
            mod test_mod {
                pub struct TestStruct<T> {}
                impl<T> TestStruct<T> {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                TestStruct::<()>::TEST_CONST$0
            }
            ",
            r"
            mod test_mod {
                pub struct TestStruct<T> {}
                impl<T> TestStruct<T> {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                test_mod::TestStruct::<()>::TEST_CONST
            }
            ",
        );
    }

    #[test]
    fn associated_trait_const_generic() {
        check_assist(
            qualify_path,
            r"
            mod test_mod {
                pub trait TestTrait {
                    const TEST_CONST: u8;
                }
                pub struct TestStruct<T> {}
                impl<T> TestTrait for TestStruct<T> {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                test_mod::TestStruct::<()>::TEST_CONST$0
            }
            ",
            r"
            mod test_mod {
                pub trait TestTrait {
                    const TEST_CONST: u8;
                }
                pub struct TestStruct<T> {}
                impl<T> TestTrait for TestStruct<T> {
                    const TEST_CONST: u8 = 42;
                }
            }

            fn main() {
                <test_mod::TestStruct::<()> as test_mod::TestTrait>::TEST_CONST
            }
            ",
        );
    }

    #[test]
    fn trait_method_generic() {
        check_assist(
            qualify_path,
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method<T>(&self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method<T>(&self) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_struct.test_meth$0od::<()>()
            }
            ",
            r"
            mod test_mod {
                pub trait TestTrait {
                    fn test_method<T>(&self);
                }
                pub struct TestStruct {}
                impl TestTrait for TestStruct {
                    fn test_method<T>(&self) {}
                }
            }

            fn main() {
                let test_struct = test_mod::TestStruct {};
                test_mod::TestTrait::test_method::<()>(&test_struct)
            }
            ",
        );
    }
}
