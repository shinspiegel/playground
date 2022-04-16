//! Renderer for `enum` variants.

use hir::{HasAttrs, HirDisplay, ModPath, StructKind};
use ide_db::SymbolKind;
use itertools::Itertools;
use test_utils::mark;

use crate::{
    item::{CompletionItem, CompletionKind, ImportEdit},
    render::{builder_ext::Params, RenderContext},
};

pub(crate) fn render_variant<'a>(
    ctx: RenderContext<'a>,
    import_to_add: Option<ImportEdit>,
    local_name: Option<String>,
    variant: hir::Variant,
    path: Option<ModPath>,
) -> CompletionItem {
    let _p = profile::span("render_enum_variant");
    EnumRender::new(ctx, local_name, variant, path).render(import_to_add)
}

#[derive(Debug)]
struct EnumRender<'a> {
    ctx: RenderContext<'a>,
    name: String,
    variant: hir::Variant,
    path: Option<ModPath>,
    qualified_name: String,
    short_qualified_name: String,
    variant_kind: StructKind,
}

impl<'a> EnumRender<'a> {
    fn new(
        ctx: RenderContext<'a>,
        local_name: Option<String>,
        variant: hir::Variant,
        path: Option<ModPath>,
    ) -> EnumRender<'a> {
        let name = local_name.unwrap_or_else(|| variant.name(ctx.db()).to_string());
        let variant_kind = variant.kind(ctx.db());

        let (qualified_name, short_qualified_name) = match &path {
            Some(path) => {
                let full = path.to_string();
                let segments = path.segments();
                let short = segments[segments.len().saturating_sub(2)..].iter().join("::");
                (full, short)
            }
            None => (name.to_string(), name.to_string()),
        };

        EnumRender { ctx, name, variant, path, qualified_name, short_qualified_name, variant_kind }
    }

    fn render(self, import_to_add: Option<ImportEdit>) -> CompletionItem {
        let mut builder = CompletionItem::new(
            CompletionKind::Reference,
            self.ctx.source_range(),
            self.qualified_name.clone(),
        )
        .kind(SymbolKind::Variant)
        .set_documentation(self.variant.docs(self.ctx.db()))
        .set_deprecated(self.ctx.is_deprecated(self.variant))
        .add_import(import_to_add)
        .detail(self.detail());

        if self.variant_kind == StructKind::Tuple {
            mark::hit!(inserts_parens_for_tuple_enums);
            let params = Params::Anonymous(self.variant.fields(self.ctx.db()).len());
            builder =
                builder.add_call_parens(self.ctx.completion, self.short_qualified_name, params);
        } else if self.path.is_some() {
            builder = builder.lookup_by(self.short_qualified_name);
        }

        builder.build()
    }

    fn detail(&self) -> String {
        let detail_types = self
            .variant
            .fields(self.ctx.db())
            .into_iter()
            .map(|field| (field.name(self.ctx.db()), field.signature_ty(self.ctx.db())));

        match self.variant_kind {
            StructKind::Tuple | StructKind::Unit => format!(
                "({})",
                detail_types.map(|(_, t)| t.display(self.ctx.db()).to_string()).format(", ")
            ),
            StructKind::Record => format!(
                "{{ {} }}",
                detail_types
                    .map(|(n, t)| format!("{}: {}", n, t.display(self.ctx.db()).to_string()))
                    .format(", ")
            ),
        }
    }
}

#[cfg(test)]
mod tests {
    use test_utils::mark;

    use crate::test_utils::check_edit;

    #[test]
    fn inserts_parens_for_tuple_enums() {
        mark::check!(inserts_parens_for_tuple_enums);
        check_edit(
            "Some",
            r#"
enum Option<T> { Some(T), None }
use Option::*;
fn main() -> Option<i32> {
    Som$0
}
"#,
            r#"
enum Option<T> { Some(T), None }
use Option::*;
fn main() -> Option<i32> {
    Some($0)
}
"#,
        );
    }
}
