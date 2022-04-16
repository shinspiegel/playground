//! Conversion of rust-analyzer specific types to lsp_types equivalents.
use std::{
    path::{self, Path},
    sync::atomic::{AtomicU32, Ordering},
};

use ide::{
    Assist, AssistKind, CallInfo, CompletionItem, CompletionItemKind, Documentation, FileId,
    FileRange, FileSystemEdit, Fold, FoldKind, Highlight, HlMod, HlPunct, HlRange, HlTag, Indel,
    InlayHint, InlayKind, InsertTextFormat, LineIndex, Markup, NavigationTarget, ReferenceAccess,
    RenameError, Runnable, Severity, SourceChange, TextEdit, TextRange, TextSize,
};
use ide_db::SymbolKind;
use itertools::Itertools;

use crate::{
    cargo_target_spec::CargoTargetSpec, global_state::GlobalStateSnapshot,
    line_endings::LineEndings, lsp_ext, semantic_tokens, Result,
};

pub(crate) fn position(line_index: &LineIndex, offset: TextSize) -> lsp_types::Position {
    let line_col = line_index.line_col(offset);
    lsp_types::Position::new(line_col.line, line_col.col_utf16)
}

pub(crate) fn range(line_index: &LineIndex, range: TextRange) -> lsp_types::Range {
    let start = position(line_index, range.start());
    let end = position(line_index, range.end());
    lsp_types::Range::new(start, end)
}

pub(crate) fn symbol_kind(symbol_kind: SymbolKind) -> lsp_types::SymbolKind {
    match symbol_kind {
        SymbolKind::Function => lsp_types::SymbolKind::Function,
        SymbolKind::Struct => lsp_types::SymbolKind::Struct,
        SymbolKind::Enum => lsp_types::SymbolKind::Enum,
        SymbolKind::Variant => lsp_types::SymbolKind::EnumMember,
        SymbolKind::Trait => lsp_types::SymbolKind::Interface,
        SymbolKind::Macro => lsp_types::SymbolKind::Function,
        SymbolKind::Module => lsp_types::SymbolKind::Module,
        SymbolKind::TypeAlias | SymbolKind::TypeParam => lsp_types::SymbolKind::TypeParameter,
        SymbolKind::Field => lsp_types::SymbolKind::Field,
        SymbolKind::Static => lsp_types::SymbolKind::Constant,
        SymbolKind::Const => lsp_types::SymbolKind::Constant,
        SymbolKind::ConstParam => lsp_types::SymbolKind::Constant,
        SymbolKind::Impl => lsp_types::SymbolKind::Object,
        SymbolKind::Local
        | SymbolKind::SelfParam
        | SymbolKind::LifetimeParam
        | SymbolKind::ValueParam
        | SymbolKind::Label => lsp_types::SymbolKind::Variable,
        SymbolKind::Union => lsp_types::SymbolKind::Struct,
    }
}

pub(crate) fn document_highlight_kind(
    reference_access: ReferenceAccess,
) -> lsp_types::DocumentHighlightKind {
    match reference_access {
        ReferenceAccess::Read => lsp_types::DocumentHighlightKind::Read,
        ReferenceAccess::Write => lsp_types::DocumentHighlightKind::Write,
    }
}

pub(crate) fn diagnostic_severity(severity: Severity) -> lsp_types::DiagnosticSeverity {
    match severity {
        Severity::Error => lsp_types::DiagnosticSeverity::Error,
        Severity::WeakWarning => lsp_types::DiagnosticSeverity::Hint,
    }
}

pub(crate) fn documentation(documentation: Documentation) -> lsp_types::Documentation {
    let value = crate::markdown::format_docs(documentation.as_str());
    let markup_content = lsp_types::MarkupContent { kind: lsp_types::MarkupKind::Markdown, value };
    lsp_types::Documentation::MarkupContent(markup_content)
}

pub(crate) fn insert_text_format(
    insert_text_format: InsertTextFormat,
) -> lsp_types::InsertTextFormat {
    match insert_text_format {
        InsertTextFormat::Snippet => lsp_types::InsertTextFormat::Snippet,
        InsertTextFormat::PlainText => lsp_types::InsertTextFormat::PlainText,
    }
}

pub(crate) fn completion_item_kind(
    completion_item_kind: CompletionItemKind,
) -> lsp_types::CompletionItemKind {
    match completion_item_kind {
        CompletionItemKind::Attribute => lsp_types::CompletionItemKind::EnumMember,
        CompletionItemKind::Binding => lsp_types::CompletionItemKind::Variable,
        CompletionItemKind::BuiltinType => lsp_types::CompletionItemKind::Struct,
        CompletionItemKind::Keyword => lsp_types::CompletionItemKind::Keyword,
        CompletionItemKind::Method => lsp_types::CompletionItemKind::Method,
        CompletionItemKind::Snippet => lsp_types::CompletionItemKind::Snippet,
        CompletionItemKind::UnresolvedReference => lsp_types::CompletionItemKind::Reference,
        CompletionItemKind::SymbolKind(symbol) => match symbol {
            SymbolKind::Const => lsp_types::CompletionItemKind::Constant,
            SymbolKind::ConstParam => lsp_types::CompletionItemKind::TypeParameter,
            SymbolKind::Enum => lsp_types::CompletionItemKind::Enum,
            SymbolKind::Field => lsp_types::CompletionItemKind::Field,
            SymbolKind::Function => lsp_types::CompletionItemKind::Function,
            SymbolKind::Impl => lsp_types::CompletionItemKind::Text,
            SymbolKind::Label => lsp_types::CompletionItemKind::Variable,
            SymbolKind::LifetimeParam => lsp_types::CompletionItemKind::TypeParameter,
            SymbolKind::Local => lsp_types::CompletionItemKind::Variable,
            SymbolKind::Macro => lsp_types::CompletionItemKind::Method,
            SymbolKind::Module => lsp_types::CompletionItemKind::Module,
            SymbolKind::SelfParam => lsp_types::CompletionItemKind::Value,
            SymbolKind::Static => lsp_types::CompletionItemKind::Value,
            SymbolKind::Struct => lsp_types::CompletionItemKind::Struct,
            SymbolKind::Trait => lsp_types::CompletionItemKind::Interface,
            SymbolKind::TypeAlias => lsp_types::CompletionItemKind::Struct,
            SymbolKind::TypeParam => lsp_types::CompletionItemKind::TypeParameter,
            SymbolKind::Union => lsp_types::CompletionItemKind::Struct,
            SymbolKind::ValueParam => lsp_types::CompletionItemKind::Value,
            SymbolKind::Variant => lsp_types::CompletionItemKind::EnumMember,
        },
    }
}

pub(crate) fn text_edit(
    line_index: &LineIndex,
    line_endings: LineEndings,
    indel: Indel,
) -> lsp_types::TextEdit {
    let range = range(line_index, indel.delete);
    let new_text = match line_endings {
        LineEndings::Unix => indel.insert,
        LineEndings::Dos => indel.insert.replace('\n', "\r\n"),
    };
    lsp_types::TextEdit { range, new_text }
}

pub(crate) fn snippet_text_edit(
    line_index: &LineIndex,
    line_endings: LineEndings,
    is_snippet: bool,
    indel: Indel,
) -> lsp_ext::SnippetTextEdit {
    let text_edit = text_edit(line_index, line_endings, indel);
    let insert_text_format =
        if is_snippet { Some(lsp_types::InsertTextFormat::Snippet) } else { None };
    lsp_ext::SnippetTextEdit {
        range: text_edit.range,
        new_text: text_edit.new_text,
        insert_text_format,
    }
}

pub(crate) fn text_edit_vec(
    line_index: &LineIndex,
    line_endings: LineEndings,
    text_edit: TextEdit,
) -> Vec<lsp_types::TextEdit> {
    text_edit.into_iter().map(|indel| self::text_edit(line_index, line_endings, indel)).collect()
}

pub(crate) fn snippet_text_edit_vec(
    line_index: &LineIndex,
    line_endings: LineEndings,
    is_snippet: bool,
    text_edit: TextEdit,
) -> Vec<lsp_ext::SnippetTextEdit> {
    text_edit
        .into_iter()
        .map(|indel| self::snippet_text_edit(line_index, line_endings, is_snippet, indel))
        .collect()
}

pub(crate) fn completion_item(
    line_index: &LineIndex,
    line_endings: LineEndings,
    completion_item: CompletionItem,
) -> Vec<lsp_types::CompletionItem> {
    fn set_score(res: &mut lsp_types::CompletionItem, label: &str) {
        res.preselect = Some(true);
        // HACK: sort preselect items first
        res.sort_text = Some(format!(" {}", label));
    }

    let mut additional_text_edits = Vec::new();
    let mut text_edit = None;
    // LSP does not allow arbitrary edits in completion, so we have to do a
    // non-trivial mapping here.
    let source_range = completion_item.source_range();
    for indel in completion_item.text_edit().iter() {
        if indel.delete.contains_range(source_range) {
            text_edit = Some(if indel.delete == source_range {
                self::text_edit(line_index, line_endings, indel.clone())
            } else {
                assert!(source_range.end() == indel.delete.end());
                let range1 = TextRange::new(indel.delete.start(), source_range.start());
                let range2 = source_range;
                let indel1 = Indel::replace(range1, String::new());
                let indel2 = Indel::replace(range2, indel.insert.clone());
                additional_text_edits.push(self::text_edit(line_index, line_endings, indel1));
                self::text_edit(line_index, line_endings, indel2)
            })
        } else {
            assert!(source_range.intersect(indel.delete).is_none());
            let text_edit = self::text_edit(line_index, line_endings, indel.clone());
            additional_text_edits.push(text_edit);
        }
    }
    let text_edit = text_edit.unwrap();

    let mut res = lsp_types::CompletionItem {
        label: completion_item.label().to_string(),
        detail: completion_item.detail().map(|it| it.to_string()),
        filter_text: Some(completion_item.lookup().to_string()),
        kind: completion_item.kind().map(completion_item_kind),
        text_edit: Some(text_edit.into()),
        additional_text_edits: Some(additional_text_edits),
        documentation: completion_item.documentation().map(documentation),
        deprecated: Some(completion_item.deprecated()),
        ..Default::default()
    };

    if completion_item.score().is_some() {
        set_score(&mut res, completion_item.label());
    }

    if completion_item.deprecated() {
        res.tags = Some(vec![lsp_types::CompletionItemTag::Deprecated])
    }

    if completion_item.trigger_call_info() {
        res.command = Some(lsp_types::Command {
            title: "triggerParameterHints".into(),
            command: "editor.action.triggerParameterHints".into(),
            arguments: None,
        });
    }

    let mut all_results = match completion_item.ref_match() {
        Some(ref_match) => {
            let mut refed = res.clone();
            let (mutability, _score) = ref_match;
            let label = format!("&{}{}", mutability.as_keyword_for_ref(), refed.label);
            set_score(&mut refed, &label);
            refed.label = label;
            vec![res, refed]
        }
        None => vec![res],
    };

    for mut r in all_results.iter_mut() {
        r.insert_text_format = Some(insert_text_format(completion_item.insert_text_format()));
    }
    all_results
}

pub(crate) fn signature_help(
    call_info: CallInfo,
    concise: bool,
    label_offsets: bool,
) -> lsp_types::SignatureHelp {
    let (label, parameters) = match (concise, label_offsets) {
        (_, false) => {
            let params = call_info
                .parameter_labels()
                .map(|label| lsp_types::ParameterInformation {
                    label: lsp_types::ParameterLabel::Simple(label.to_string()),
                    documentation: None,
                })
                .collect::<Vec<_>>();
            let label =
                if concise { call_info.parameter_labels().join(", ") } else { call_info.signature };
            (label, params)
        }
        (false, true) => {
            let params = call_info
                .parameter_ranges()
                .iter()
                .map(|it| [u32::from(it.start()).into(), u32::from(it.end()).into()])
                .map(|label_offsets| lsp_types::ParameterInformation {
                    label: lsp_types::ParameterLabel::LabelOffsets(label_offsets),
                    documentation: None,
                })
                .collect::<Vec<_>>();
            (call_info.signature, params)
        }
        (true, true) => {
            let mut params = Vec::new();
            let mut label = String::new();
            let mut first = true;
            for param in call_info.parameter_labels() {
                if !first {
                    label.push_str(", ");
                }
                first = false;
                let start = label.len() as u32;
                label.push_str(param);
                let end = label.len() as u32;
                params.push(lsp_types::ParameterInformation {
                    label: lsp_types::ParameterLabel::LabelOffsets([start, end]),
                    documentation: None,
                });
            }

            (label, params)
        }
    };

    let documentation = if concise {
        None
    } else {
        call_info.doc.map(|doc| {
            lsp_types::Documentation::MarkupContent(lsp_types::MarkupContent {
                kind: lsp_types::MarkupKind::Markdown,
                value: doc,
            })
        })
    };

    let active_parameter = call_info.active_parameter.map(|it| it as u32);

    let signature = lsp_types::SignatureInformation {
        label,
        documentation,
        parameters: Some(parameters),
        active_parameter,
    };
    lsp_types::SignatureHelp {
        signatures: vec![signature],
        active_signature: None,
        active_parameter,
    }
}

pub(crate) fn inlay_hint(line_index: &LineIndex, inlay_hint: InlayHint) -> lsp_ext::InlayHint {
    lsp_ext::InlayHint {
        label: inlay_hint.label.to_string(),
        range: range(line_index, inlay_hint.range),
        kind: match inlay_hint.kind {
            InlayKind::ParameterHint => lsp_ext::InlayKind::ParameterHint,
            InlayKind::TypeHint => lsp_ext::InlayKind::TypeHint,
            InlayKind::ChainingHint => lsp_ext::InlayKind::ChainingHint,
        },
    }
}

static TOKEN_RESULT_COUNTER: AtomicU32 = AtomicU32::new(1);

pub(crate) fn semantic_tokens(
    text: &str,
    line_index: &LineIndex,
    highlights: Vec<HlRange>,
) -> lsp_types::SemanticTokens {
    let id = TOKEN_RESULT_COUNTER.fetch_add(1, Ordering::SeqCst).to_string();
    let mut builder = semantic_tokens::SemanticTokensBuilder::new(id);

    for highlight_range in highlights {
        if highlight_range.highlight.is_empty() {
            continue;
        }
        let (type_, mods) = semantic_token_type_and_modifiers(highlight_range.highlight);
        let token_index = semantic_tokens::type_index(type_);
        let modifier_bitset = mods.0;

        for mut text_range in line_index.lines(highlight_range.range) {
            if text[text_range].ends_with('\n') {
                text_range =
                    TextRange::new(text_range.start(), text_range.end() - TextSize::of('\n'));
            }
            let range = range(&line_index, text_range);
            builder.push(range, token_index, modifier_bitset);
        }
    }

    builder.build()
}

pub(crate) fn semantic_token_delta(
    previous: &lsp_types::SemanticTokens,
    current: &lsp_types::SemanticTokens,
) -> lsp_types::SemanticTokensDelta {
    let result_id = current.result_id.clone();
    let edits = semantic_tokens::diff_tokens(&previous.data, &current.data);
    lsp_types::SemanticTokensDelta { result_id, edits }
}

fn semantic_token_type_and_modifiers(
    highlight: Highlight,
) -> (lsp_types::SemanticTokenType, semantic_tokens::ModifierSet) {
    let mut mods = semantic_tokens::ModifierSet::default();
    let type_ = match highlight.tag {
        HlTag::Symbol(symbol) => match symbol {
            SymbolKind::Module => lsp_types::SemanticTokenType::NAMESPACE,
            SymbolKind::Impl => lsp_types::SemanticTokenType::TYPE,
            SymbolKind::Field => lsp_types::SemanticTokenType::PROPERTY,
            SymbolKind::TypeParam => lsp_types::SemanticTokenType::TYPE_PARAMETER,
            SymbolKind::ConstParam => semantic_tokens::CONST_PARAMETER,
            SymbolKind::LifetimeParam => semantic_tokens::LIFETIME,
            SymbolKind::Label => semantic_tokens::LABEL,
            SymbolKind::ValueParam => lsp_types::SemanticTokenType::PARAMETER,
            SymbolKind::SelfParam => semantic_tokens::SELF_KEYWORD,
            SymbolKind::Local => lsp_types::SemanticTokenType::VARIABLE,
            SymbolKind::Function => {
                if highlight.mods.contains(HlMod::Associated) {
                    lsp_types::SemanticTokenType::METHOD
                } else {
                    lsp_types::SemanticTokenType::FUNCTION
                }
            }
            SymbolKind::Const => {
                mods |= semantic_tokens::CONSTANT;
                mods |= lsp_types::SemanticTokenModifier::STATIC;
                lsp_types::SemanticTokenType::VARIABLE
            }
            SymbolKind::Static => {
                mods |= lsp_types::SemanticTokenModifier::STATIC;
                lsp_types::SemanticTokenType::VARIABLE
            }
            SymbolKind::Struct => lsp_types::SemanticTokenType::STRUCT,
            SymbolKind::Enum => lsp_types::SemanticTokenType::ENUM,
            SymbolKind::Variant => lsp_types::SemanticTokenType::ENUM_MEMBER,
            SymbolKind::Union => semantic_tokens::UNION,
            SymbolKind::TypeAlias => semantic_tokens::TYPE_ALIAS,
            SymbolKind::Trait => lsp_types::SemanticTokenType::INTERFACE,
            SymbolKind::Macro => lsp_types::SemanticTokenType::MACRO,
        },
        HlTag::BuiltinType => semantic_tokens::BUILTIN_TYPE,
        HlTag::None => semantic_tokens::GENERIC,
        HlTag::ByteLiteral | HlTag::NumericLiteral => lsp_types::SemanticTokenType::NUMBER,
        HlTag::BoolLiteral => semantic_tokens::BOOLEAN,
        HlTag::StringLiteral => lsp_types::SemanticTokenType::STRING,
        HlTag::CharLiteral => semantic_tokens::CHAR_LITERAL,
        HlTag::Comment => lsp_types::SemanticTokenType::COMMENT,
        HlTag::Attribute => semantic_tokens::ATTRIBUTE,
        HlTag::Keyword => lsp_types::SemanticTokenType::KEYWORD,
        HlTag::UnresolvedReference => semantic_tokens::UNRESOLVED_REFERENCE,
        HlTag::FormatSpecifier => semantic_tokens::FORMAT_SPECIFIER,
        HlTag::Operator => lsp_types::SemanticTokenType::OPERATOR,
        HlTag::EscapeSequence => semantic_tokens::ESCAPE_SEQUENCE,
        HlTag::Punctuation(punct) => match punct {
            HlPunct::Bracket => semantic_tokens::BRACKET,
            HlPunct::Brace => semantic_tokens::BRACE,
            HlPunct::Parenthesis => semantic_tokens::PARENTHESIS,
            HlPunct::Angle => semantic_tokens::ANGLE,
            HlPunct::Comma => semantic_tokens::COMMA,
            HlPunct::Dot => semantic_tokens::DOT,
            HlPunct::Colon => semantic_tokens::COLON,
            HlPunct::Semi => semantic_tokens::SEMICOLON,
            HlPunct::Other => semantic_tokens::PUNCTUATION,
        },
    };

    for modifier in highlight.mods.iter() {
        let modifier = match modifier {
            HlMod::Attribute => semantic_tokens::ATTRIBUTE_MODIFIER,
            HlMod::Definition => lsp_types::SemanticTokenModifier::DECLARATION,
            HlMod::Documentation => lsp_types::SemanticTokenModifier::DOCUMENTATION,
            HlMod::Injected => semantic_tokens::INJECTED,
            HlMod::ControlFlow => semantic_tokens::CONTROL_FLOW,
            HlMod::Mutable => semantic_tokens::MUTABLE,
            HlMod::Consuming => semantic_tokens::CONSUMING,
            HlMod::Unsafe => semantic_tokens::UNSAFE,
            HlMod::Callable => semantic_tokens::CALLABLE,
            HlMod::Static => lsp_types::SemanticTokenModifier::STATIC,
            HlMod::Associated => continue,
        };
        mods |= modifier;
    }

    (type_, mods)
}

pub(crate) fn folding_range(
    text: &str,
    line_index: &LineIndex,
    line_folding_only: bool,
    fold: Fold,
) -> lsp_types::FoldingRange {
    let kind = match fold.kind {
        FoldKind::Comment => Some(lsp_types::FoldingRangeKind::Comment),
        FoldKind::Imports => Some(lsp_types::FoldingRangeKind::Imports),
        FoldKind::Mods | FoldKind::Block | FoldKind::ArgList => None,
    };

    let range = range(line_index, fold.range);

    if line_folding_only {
        // Clients with line_folding_only == true (such as VSCode) will fold the whole end line
        // even if it contains text not in the folding range. To prevent that we exclude
        // range.end.line from the folding region if there is more text after range.end
        // on the same line.
        let has_more_text_on_end_line = text[TextRange::new(fold.range.end(), TextSize::of(text))]
            .chars()
            .take_while(|it| *it != '\n')
            .any(|it| !it.is_whitespace());

        let end_line = if has_more_text_on_end_line {
            range.end.line.saturating_sub(1)
        } else {
            range.end.line
        };

        lsp_types::FoldingRange {
            start_line: range.start.line,
            start_character: None,
            end_line,
            end_character: None,
            kind,
        }
    } else {
        lsp_types::FoldingRange {
            start_line: range.start.line,
            start_character: Some(range.start.character),
            end_line: range.end.line,
            end_character: Some(range.end.character),
            kind,
        }
    }
}

pub(crate) fn url(snap: &GlobalStateSnapshot, file_id: FileId) -> lsp_types::Url {
    snap.file_id_to_url(file_id)
}

/// Returns a `Url` object from a given path, will lowercase drive letters if present.
/// This will only happen when processing windows paths.
///
/// When processing non-windows path, this is essentially the same as `Url::from_file_path`.
pub(crate) fn url_from_abs_path(path: &Path) -> lsp_types::Url {
    assert!(path.is_absolute());
    let url = lsp_types::Url::from_file_path(path).unwrap();
    match path.components().next() {
        Some(path::Component::Prefix(prefix))
            if matches!(prefix.kind(), path::Prefix::Disk(_) | path::Prefix::VerbatimDisk(_)) =>
        {
            // Need to lowercase driver letter
        }
        _ => return url,
    }

    let driver_letter_range = {
        let (scheme, drive_letter, _rest) = match url.as_str().splitn(3, ':').collect_tuple() {
            Some(it) => it,
            None => return url,
        };
        let start = scheme.len() + ':'.len_utf8();
        start..(start + drive_letter.len())
    };

    // Note: lowercasing the `path` itself doesn't help, the `Url::parse`
    // machinery *also* canonicalizes the drive letter. So, just massage the
    // string in place.
    let mut url = url.into_string();
    url[driver_letter_range].make_ascii_lowercase();
    lsp_types::Url::parse(&url).unwrap()
}

pub(crate) fn optional_versioned_text_document_identifier(
    snap: &GlobalStateSnapshot,
    file_id: FileId,
) -> lsp_types::OptionalVersionedTextDocumentIdentifier {
    let url = url(snap, file_id);
    let version = snap.url_file_version(&url);
    lsp_types::OptionalVersionedTextDocumentIdentifier { uri: url, version }
}

pub(crate) fn location(
    snap: &GlobalStateSnapshot,
    frange: FileRange,
) -> Result<lsp_types::Location> {
    let url = url(snap, frange.file_id);
    let line_index = snap.analysis.file_line_index(frange.file_id)?;
    let range = range(&line_index, frange.range);
    let loc = lsp_types::Location::new(url, range);
    Ok(loc)
}

/// Perefer using `location_link`, if the client has the cap.
pub(crate) fn location_from_nav(
    snap: &GlobalStateSnapshot,
    nav: NavigationTarget,
) -> Result<lsp_types::Location> {
    let url = url(snap, nav.file_id);
    let line_index = snap.analysis.file_line_index(nav.file_id)?;
    let range = range(&line_index, nav.full_range);
    let loc = lsp_types::Location::new(url, range);
    Ok(loc)
}

pub(crate) fn location_link(
    snap: &GlobalStateSnapshot,
    src: Option<FileRange>,
    target: NavigationTarget,
) -> Result<lsp_types::LocationLink> {
    let origin_selection_range = match src {
        Some(src) => {
            let line_index = snap.analysis.file_line_index(src.file_id)?;
            let range = range(&line_index, src.range);
            Some(range)
        }
        None => None,
    };
    let (target_uri, target_range, target_selection_range) = location_info(snap, target)?;
    let res = lsp_types::LocationLink {
        origin_selection_range,
        target_uri,
        target_range,
        target_selection_range,
    };
    Ok(res)
}

fn location_info(
    snap: &GlobalStateSnapshot,
    target: NavigationTarget,
) -> Result<(lsp_types::Url, lsp_types::Range, lsp_types::Range)> {
    let line_index = snap.analysis.file_line_index(target.file_id)?;

    let target_uri = url(snap, target.file_id);
    let target_range = range(&line_index, target.full_range);
    let target_selection_range =
        target.focus_range.map(|it| range(&line_index, it)).unwrap_or(target_range);
    Ok((target_uri, target_range, target_selection_range))
}

pub(crate) fn goto_definition_response(
    snap: &GlobalStateSnapshot,
    src: Option<FileRange>,
    targets: Vec<NavigationTarget>,
) -> Result<lsp_types::GotoDefinitionResponse> {
    if snap.config.location_link() {
        let links = targets
            .into_iter()
            .map(|nav| location_link(snap, src, nav))
            .collect::<Result<Vec<_>>>()?;
        Ok(links.into())
    } else {
        let locations = targets
            .into_iter()
            .map(|nav| {
                location(snap, FileRange { file_id: nav.file_id, range: nav.focus_or_full_range() })
            })
            .collect::<Result<Vec<_>>>()?;
        Ok(locations.into())
    }
}

pub(crate) fn snippet_text_document_edit(
    snap: &GlobalStateSnapshot,
    is_snippet: bool,
    file_id: FileId,
    edit: TextEdit,
) -> Result<lsp_ext::SnippetTextDocumentEdit> {
    let text_document = optional_versioned_text_document_identifier(snap, file_id);
    let line_index = snap.analysis.file_line_index(file_id)?;
    let line_endings = snap.file_line_endings(file_id);
    let edits = edit
        .into_iter()
        .map(|it| snippet_text_edit(&line_index, line_endings, is_snippet, it))
        .collect();
    Ok(lsp_ext::SnippetTextDocumentEdit { text_document, edits })
}

pub(crate) fn snippet_text_document_ops(
    snap: &GlobalStateSnapshot,
    file_system_edit: FileSystemEdit,
) -> Vec<lsp_ext::SnippetDocumentChangeOperation> {
    let mut ops = Vec::new();
    match file_system_edit {
        FileSystemEdit::CreateFile { dst, initial_contents } => {
            let uri = snap.anchored_path(&dst);
            let create_file = lsp_types::ResourceOp::Create(lsp_types::CreateFile {
                uri: uri.clone(),
                options: None,
                annotation_id: None,
            });
            ops.push(lsp_ext::SnippetDocumentChangeOperation::Op(create_file));
            if !initial_contents.is_empty() {
                let text_document =
                    lsp_types::OptionalVersionedTextDocumentIdentifier { uri, version: None };
                let range = range(&LineIndex::new(""), TextRange::empty(TextSize::from(0)));
                let text_edit = lsp_ext::SnippetTextEdit {
                    range,
                    new_text: initial_contents,
                    insert_text_format: Some(lsp_types::InsertTextFormat::PlainText),
                };
                let edit_file =
                    lsp_ext::SnippetTextDocumentEdit { text_document, edits: vec![text_edit] };
                ops.push(lsp_ext::SnippetDocumentChangeOperation::Edit(edit_file));
            }
        }
        FileSystemEdit::MoveFile { src, dst } => {
            let old_uri = snap.file_id_to_url(src);
            let new_uri = snap.anchored_path(&dst);
            let rename_file = lsp_types::ResourceOp::Rename(lsp_types::RenameFile {
                old_uri,
                new_uri,
                options: None,
                annotation_id: None,
            });
            ops.push(lsp_ext::SnippetDocumentChangeOperation::Op(rename_file))
        }
    }
    ops
}

pub(crate) fn snippet_workspace_edit(
    snap: &GlobalStateSnapshot,
    source_change: SourceChange,
) -> Result<lsp_ext::SnippetWorkspaceEdit> {
    let mut document_changes: Vec<lsp_ext::SnippetDocumentChangeOperation> = Vec::new();
    for op in source_change.file_system_edits {
        let ops = snippet_text_document_ops(snap, op);
        document_changes.extend_from_slice(&ops);
    }
    for (file_id, edit) in source_change.source_file_edits {
        let edit = snippet_text_document_edit(&snap, source_change.is_snippet, file_id, edit)?;
        document_changes.push(lsp_ext::SnippetDocumentChangeOperation::Edit(edit));
    }
    let workspace_edit =
        lsp_ext::SnippetWorkspaceEdit { changes: None, document_changes: Some(document_changes) };
    Ok(workspace_edit)
}

pub(crate) fn workspace_edit(
    snap: &GlobalStateSnapshot,
    source_change: SourceChange,
) -> Result<lsp_types::WorkspaceEdit> {
    assert!(!source_change.is_snippet);
    snippet_workspace_edit(snap, source_change).map(|it| it.into())
}

impl From<lsp_ext::SnippetWorkspaceEdit> for lsp_types::WorkspaceEdit {
    fn from(snippet_workspace_edit: lsp_ext::SnippetWorkspaceEdit) -> lsp_types::WorkspaceEdit {
        lsp_types::WorkspaceEdit {
            changes: None,
            document_changes: snippet_workspace_edit.document_changes.map(|changes| {
                lsp_types::DocumentChanges::Operations(
                    changes
                        .into_iter()
                        .map(|change| match change {
                            lsp_ext::SnippetDocumentChangeOperation::Op(op) => {
                                lsp_types::DocumentChangeOperation::Op(op)
                            }
                            lsp_ext::SnippetDocumentChangeOperation::Edit(edit) => {
                                lsp_types::DocumentChangeOperation::Edit(
                                    lsp_types::TextDocumentEdit {
                                        text_document: edit.text_document,
                                        edits: edit
                                            .edits
                                            .into_iter()
                                            .map(|edit| {
                                                lsp_types::OneOf::Left(lsp_types::TextEdit {
                                                    range: edit.range,
                                                    new_text: edit.new_text,
                                                })
                                            })
                                            .collect(),
                                    },
                                )
                            }
                        })
                        .collect(),
                )
            }),
            change_annotations: None,
        }
    }
}

pub(crate) fn call_hierarchy_item(
    snap: &GlobalStateSnapshot,
    target: NavigationTarget,
) -> Result<lsp_types::CallHierarchyItem> {
    let name = target.name.to_string();
    let detail = target.description.clone();
    let kind = target.kind.map(symbol_kind).unwrap_or(lsp_types::SymbolKind::Function);
    let (uri, range, selection_range) = location_info(snap, target)?;
    Ok(lsp_types::CallHierarchyItem {
        name,
        kind,
        tags: None,
        detail,
        uri,
        range,
        selection_range,
        data: None,
    })
}

pub(crate) fn code_action_kind(kind: AssistKind) -> lsp_types::CodeActionKind {
    match kind {
        AssistKind::None | AssistKind::Generate => lsp_types::CodeActionKind::EMPTY,
        AssistKind::QuickFix => lsp_types::CodeActionKind::QUICKFIX,
        AssistKind::Refactor => lsp_types::CodeActionKind::REFACTOR,
        AssistKind::RefactorExtract => lsp_types::CodeActionKind::REFACTOR_EXTRACT,
        AssistKind::RefactorInline => lsp_types::CodeActionKind::REFACTOR_INLINE,
        AssistKind::RefactorRewrite => lsp_types::CodeActionKind::REFACTOR_REWRITE,
    }
}

pub(crate) fn unresolved_code_action(
    snap: &GlobalStateSnapshot,
    code_action_params: lsp_types::CodeActionParams,
    assist: Assist,
    index: usize,
) -> Result<lsp_ext::CodeAction> {
    assert!(assist.source_change.is_none());
    let res = lsp_ext::CodeAction {
        title: assist.label.to_string(),
        group: assist.group.filter(|_| snap.config.code_action_group()).map(|gr| gr.0),
        kind: Some(code_action_kind(assist.id.1)),
        edit: None,
        is_preferred: None,
        data: Some(lsp_ext::CodeActionData {
            id: format!("{}:{}", assist.id.0, index.to_string()),
            code_action_params,
        }),
    };
    Ok(res)
}

pub(crate) fn resolved_code_action(
    snap: &GlobalStateSnapshot,
    assist: Assist,
) -> Result<lsp_ext::CodeAction> {
    let change = assist.source_change.unwrap();
    let res = lsp_ext::CodeAction {
        edit: Some(snippet_workspace_edit(snap, change)?),
        title: assist.label.to_string(),
        group: assist.group.filter(|_| snap.config.code_action_group()).map(|gr| gr.0),
        kind: Some(code_action_kind(assist.id.1)),
        is_preferred: None,
        data: None,
    };
    Ok(res)
}

pub(crate) fn runnable(
    snap: &GlobalStateSnapshot,
    file_id: FileId,
    runnable: Runnable,
) -> Result<lsp_ext::Runnable> {
    let config = snap.config.runnables();
    let spec = CargoTargetSpec::for_file(snap, file_id)?;
    let workspace_root = spec.as_ref().map(|it| it.workspace_root.clone());
    let target = spec.as_ref().map(|s| s.target.clone());
    let (cargo_args, executable_args) =
        CargoTargetSpec::runnable_args(snap, spec, &runnable.kind, &runnable.cfg)?;
    let label = runnable.label(target);
    let location = location_link(snap, None, runnable.nav)?;

    Ok(lsp_ext::Runnable {
        label,
        location: Some(location),
        kind: lsp_ext::RunnableKind::Cargo,
        args: lsp_ext::CargoRunnable {
            workspace_root: workspace_root.map(|it| it.into()),
            override_cargo: config.override_cargo,
            cargo_args,
            cargo_extra_args: config.cargo_extra_args,
            executable_args,
            expect_test: None,
        },
    })
}

pub(crate) fn markup_content(markup: Markup) -> lsp_types::MarkupContent {
    let value = crate::markdown::format_docs(markup.as_str());
    lsp_types::MarkupContent { kind: lsp_types::MarkupKind::Markdown, value }
}

pub(crate) fn rename_error(err: RenameError) -> crate::LspError {
    crate::LspError { code: lsp_server::ErrorCode::InvalidParams as i32, message: err.to_string() }
}

#[cfg(test)]
mod tests {
    use hir::PrefixKind;
    use ide::Analysis;
    use ide_db::helpers::{insert_use::InsertUseConfig, SnippetCap};

    use super::*;

    #[test]
    fn test_completion_with_ref() {
        let fixture = r#"
        struct Foo;
        fn foo(arg: &Foo) {}
        fn main() {
            let arg = Foo;
            foo($0)
        }"#;

        let (offset, text) = test_utils::extract_offset(fixture);
        let line_index = LineIndex::new(&text);
        let (analysis, file_id) = Analysis::from_single_file(text);
        let completions: Vec<(String, Option<String>)> = analysis
            .completions(
                &ide::CompletionConfig {
                    enable_postfix_completions: true,
                    enable_imports_on_the_fly: true,
                    add_call_parenthesis: true,
                    add_call_argument_snippets: true,
                    snippet_cap: SnippetCap::new(true),
                    insert_use: InsertUseConfig { merge: None, prefix_kind: PrefixKind::Plain },
                },
                ide_db::base_db::FilePosition { file_id, offset },
            )
            .unwrap()
            .unwrap()
            .into_iter()
            .filter(|c| c.label().ends_with("arg"))
            .map(|c| completion_item(&line_index, LineEndings::Unix, c))
            .flat_map(|comps| comps.into_iter().map(|c| (c.label, c.sort_text)))
            .collect();
        expect_test::expect![[r#"
            [
                (
                    "arg",
                    None,
                ),
                (
                    "&arg",
                    Some(
                        " &arg",
                    ),
                ),
            ]
        "#]]
        .assert_debug_eq(&completions);
    }

    #[test]
    fn conv_fold_line_folding_only_fixup() {
        let text = r#"mod a;
mod b;
mod c;

fn main() {
    if cond {
        a::do_a();
    } else {
        b::do_b();
    }
}"#;

        let (analysis, file_id) = Analysis::from_single_file(text.to_string());
        let folds = analysis.folding_ranges(file_id).unwrap();
        assert_eq!(folds.len(), 4);

        let line_index = LineIndex::new(&text);
        let converted: Vec<lsp_types::FoldingRange> =
            folds.into_iter().map(|it| folding_range(&text, &line_index, true, it)).collect();

        let expected_lines = [(0, 2), (4, 10), (5, 6), (7, 9)];
        assert_eq!(converted.len(), expected_lines.len());
        for (folding_range, (start_line, end_line)) in converted.iter().zip(expected_lines.iter()) {
            assert_eq!(folding_range.start_line, *start_line);
            assert_eq!(folding_range.start_character, None);
            assert_eq!(folding_range.end_line, *end_line);
            assert_eq!(folding_range.end_character, None);
        }
    }

    // `Url` is not able to parse windows paths on unix machines.
    #[test]
    #[cfg(target_os = "windows")]
    fn test_lowercase_drive_letter_with_drive() {
        let url = url_from_abs_path(Path::new("C:\\Test"));
        assert_eq!(url.to_string(), "file:///c:/Test");
    }

    #[test]
    #[cfg(target_os = "windows")]
    fn test_drive_without_colon_passthrough() {
        let url = url_from_abs_path(Path::new(r#"\\localhost\C$\my_dir"#));
        assert_eq!(url.to_string(), "file://localhost/C$/my_dir");
    }
}
