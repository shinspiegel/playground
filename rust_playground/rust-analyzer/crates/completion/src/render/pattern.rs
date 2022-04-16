//! Renderer for patterns.

use hir::{db::HirDatabase, HasAttrs, HasVisibility, Name, StructKind};
use ide_db::helpers::SnippetCap;
use itertools::Itertools;

use crate::{item::CompletionKind, render::RenderContext, CompletionItem, CompletionItemKind};

fn visible_fields(
    ctx: &RenderContext<'_>,
    fields: &[hir::Field],
    item: impl HasAttrs,
) -> Option<(Vec<hir::Field>, bool)> {
    let module = ctx.completion.scope.module()?;
    let n_fields = fields.len();
    let fields = fields
        .into_iter()
        .filter(|field| field.is_visible_from(ctx.db(), module))
        .copied()
        .collect::<Vec<_>>();

    let fields_omitted =
        n_fields - fields.len() > 0 || item.attrs(ctx.db()).by_key("non_exhaustive").exists();
    Some((fields, fields_omitted))
}

pub(crate) fn render_struct_pat(
    ctx: RenderContext<'_>,
    strukt: hir::Struct,
    local_name: Option<Name>,
) -> Option<CompletionItem> {
    let _p = profile::span("render_struct_pat");

    let fields = strukt.fields(ctx.db());
    let (visible_fields, fields_omitted) = visible_fields(&ctx, &fields, strukt)?;

    if visible_fields.is_empty() {
        // Matching a struct without matching its fields is pointless, unlike matching a Variant without its fields
        return None;
    }

    let name = local_name.unwrap_or_else(|| strukt.name(ctx.db())).to_string();
    let pat = render_pat(&ctx, &name, strukt.kind(ctx.db()), &visible_fields, fields_omitted)?;

    Some(build_completion(ctx, name, pat, strukt))
}

pub(crate) fn render_variant_pat(
    ctx: RenderContext<'_>,
    variant: hir::Variant,
    local_name: Option<Name>,
    path: Option<hir::ModPath>,
) -> Option<CompletionItem> {
    let _p = profile::span("render_variant_pat");

    let fields = variant.fields(ctx.db());
    let (visible_fields, fields_omitted) = visible_fields(&ctx, &fields, variant)?;

    let name = match &path {
        Some(path) => path.to_string(),
        None => local_name.unwrap_or_else(|| variant.name(ctx.db())).to_string(),
    };
    let pat = render_pat(&ctx, &name, variant.kind(ctx.db()), &visible_fields, fields_omitted)?;

    Some(build_completion(ctx, name, pat, variant))
}

fn build_completion(
    ctx: RenderContext<'_>,
    name: String,
    pat: String,
    item: impl HasAttrs + Copy,
) -> CompletionItem {
    let completion = CompletionItem::new(CompletionKind::Snippet, ctx.source_range(), name)
        .kind(CompletionItemKind::Binding)
        .set_documentation(ctx.docs(item))
        .set_deprecated(ctx.is_deprecated(item))
        .detail(&pat);
    let completion = if let Some(snippet_cap) = ctx.snippet_cap() {
        completion.insert_snippet(snippet_cap, pat)
    } else {
        completion.insert_text(pat)
    };
    completion.build()
}

fn render_pat(
    ctx: &RenderContext<'_>,
    name: &str,
    kind: StructKind,
    fields: &[hir::Field],
    fields_omitted: bool,
) -> Option<String> {
    let mut pat = match kind {
        StructKind::Tuple if ctx.snippet_cap().is_some() => {
            render_tuple_as_pat(&fields, &name, fields_omitted)
        }
        StructKind::Record => {
            render_record_as_pat(ctx.db(), ctx.snippet_cap(), &fields, &name, fields_omitted)
        }
        _ => return None,
    };

    if ctx.completion.is_param {
        pat.push(':');
        pat.push(' ');
        pat.push_str(&name);
    }
    if ctx.snippet_cap().is_some() {
        pat.push_str("$0");
    }
    Some(pat)
}

fn render_record_as_pat(
    db: &dyn HirDatabase,
    snippet_cap: Option<SnippetCap>,
    fields: &[hir::Field],
    name: &str,
    fields_omitted: bool,
) -> String {
    let fields = fields.iter();
    if snippet_cap.is_some() {
        format!(
            "{name} {{ {}{} }}",
            fields
                .enumerate()
                .map(|(idx, field)| format!("{}${}", field.name(db), idx + 1))
                .format(", "),
            if fields_omitted { ", .." } else { "" },
            name = name
        )
    } else {
        format!(
            "{name} {{ {}{} }}",
            fields.map(|field| field.name(db)).format(", "),
            if fields_omitted { ", .." } else { "" },
            name = name
        )
    }
}

fn render_tuple_as_pat(fields: &[hir::Field], name: &str, fields_omitted: bool) -> String {
    format!(
        "{name}({}{})",
        fields.iter().enumerate().map(|(idx, _)| format!("${}", idx + 1)).format(", "),
        if fields_omitted { ", .." } else { "" },
        name = name
    )
}
