use ide_db::helpers::FamousDefs;
use ide_db::RootDatabase;
use syntax::ast::{self, AstNode, NameOwner};
use test_utils::mark;

use crate::{AssistContext, AssistId, AssistKind, Assists};

// Assist: generate_default_from_enum_variant
//
// Adds a Default impl for an enum using a variant.
//
// ```
// enum Version {
//  Undefined,
//  Minor$0,
//  Major,
// }
// ```
// ->
// ```
// enum Version {
//  Undefined,
//  Minor,
//  Major,
// }
//
// impl Default for Version {
//     fn default() -> Self {
//         Self::Minor
//     }
// }
// ```
pub(crate) fn generate_default_from_enum_variant(
    acc: &mut Assists,
    ctx: &AssistContext,
) -> Option<()> {
    let variant = ctx.find_node_at_offset::<ast::Variant>()?;
    let variant_name = variant.name()?;
    let enum_name = variant.parent_enum().name()?;
    if !matches!(variant.kind(), ast::StructKind::Unit) {
        mark::hit!(test_gen_default_on_non_unit_variant_not_implemented);
        return None;
    }

    if existing_default_impl(&ctx.sema, &variant).is_some() {
        mark::hit!(test_gen_default_impl_already_exists);
        return None;
    }

    let target = variant.syntax().text_range();
    acc.add(
        AssistId("generate_default_from_enum_variant", AssistKind::Generate),
        "Generate `Default` impl from this enum variant",
        target,
        |edit| {
            let start_offset = variant.parent_enum().syntax().text_range().end();
            let buf = format!(
                r#"

impl Default for {0} {{
    fn default() -> Self {{
        Self::{1}
    }}
}}"#,
                enum_name, variant_name
            );
            edit.insert(start_offset, buf);
        },
    )
}

fn existing_default_impl(
    sema: &'_ hir::Semantics<'_, RootDatabase>,
    variant: &ast::Variant,
) -> Option<()> {
    let variant = sema.to_def(variant)?;
    let enum_ = variant.parent_enum(sema.db);
    let krate = enum_.module(sema.db).krate();

    let default_trait = FamousDefs(sema, Some(krate)).core_default_Default()?;
    let enum_type = enum_.ty(sema.db);

    if enum_type.impls_trait(sema.db, default_trait, &[]) {
        Some(())
    } else {
        None
    }
}

#[cfg(test)]
mod tests {
    use test_utils::mark;

    use crate::tests::{check_assist, check_assist_not_applicable};

    use super::*;

    fn check_not_applicable(ra_fixture: &str) {
        let fixture =
            format!("//- /main.rs crate:main deps:core\n{}\n{}", ra_fixture, FamousDefs::FIXTURE);
        check_assist_not_applicable(generate_default_from_enum_variant, &fixture)
    }

    #[test]
    fn test_generate_default_from_variant() {
        check_assist(
            generate_default_from_enum_variant,
            r#"
enum Variant {
    Undefined,
    Minor$0,
    Major,
}"#,
            r#"enum Variant {
    Undefined,
    Minor,
    Major,
}

impl Default for Variant {
    fn default() -> Self {
        Self::Minor
    }
}"#,
        );
    }

    #[test]
    fn test_generate_default_already_implemented() {
        mark::check!(test_gen_default_impl_already_exists);
        check_not_applicable(
            r#"
enum Variant {
    Undefined,
    Minor$0,
    Major,
}

impl Default for Variant {
    fn default() -> Self {
        Self::Minor
    }
}"#,
        );
    }

    #[test]
    fn test_add_from_impl_no_element() {
        mark::check!(test_gen_default_on_non_unit_variant_not_implemented);
        check_not_applicable(
            r#"
enum Variant {
    Undefined,
    Minor(u32)$0,
    Major,
}"#,
        );
    }

    #[test]
    fn test_generate_default_from_variant_with_one_variant() {
        check_assist(
            generate_default_from_enum_variant,
            r#"enum Variant { Undefi$0ned }"#,
            r#"
enum Variant { Undefined }

impl Default for Variant {
    fn default() -> Self {
        Self::Undefined
    }
}"#,
        );
    }
}
