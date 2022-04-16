//! See `CompletionItem` structure.

use std::fmt;

use hir::{Documentation, ModPath, Mutability};
use ide_db::{
    helpers::{
        insert_use::{self, ImportScope, MergeBehavior},
        mod_path_to_ast, SnippetCap,
    },
    SymbolKind,
};
use stdx::{impl_from, never};
use syntax::{algo, TextRange};
use text_edit::TextEdit;

/// `CompletionItem` describes a single completion variant in the editor pop-up.
/// It is basically a POD with various properties. To construct a
/// `CompletionItem`, use `new` method and the `Builder` struct.
#[derive(Clone)]
pub struct CompletionItem {
    /// Used only internally in tests, to check only specific kind of
    /// completion (postfix, keyword, reference, etc).
    #[allow(unused)]
    pub(crate) completion_kind: CompletionKind,
    /// Label in the completion pop up which identifies completion.
    label: String,
    /// Range of identifier that is being completed.
    ///
    /// It should be used primarily for UI, but we also use this to convert
    /// genetic TextEdit into LSP's completion edit (see conv.rs).
    ///
    /// `source_range` must contain the completion offset. `insert_text` should
    /// start with what `source_range` points to, or VSCode will filter out the
    /// completion silently.
    source_range: TextRange,
    /// What happens when user selects this item.
    ///
    /// Typically, replaces `source_range` with new identifier.
    text_edit: TextEdit,

    insert_text_format: InsertTextFormat,

    /// What item (struct, function, etc) are we completing.
    kind: Option<CompletionItemKind>,

    /// Lookup is used to check if completion item indeed can complete current
    /// ident.
    ///
    /// That is, in `foo.bar$0` lookup of `abracadabra` will be accepted (it
    /// contains `bar` sub sequence), and `quux` will rejected.
    lookup: Option<String>,

    /// Additional info to show in the UI pop up.
    detail: Option<String>,
    documentation: Option<Documentation>,

    /// Whether this item is marked as deprecated
    deprecated: bool,

    /// If completing a function call, ask the editor to show parameter popup
    /// after completion.
    trigger_call_info: bool,

    /// Score is useful to pre select or display in better order completion items
    score: Option<CompletionScore>,

    /// Indicates that a reference or mutable reference to this variable is a
    /// possible match.
    ref_match: Option<(Mutability, CompletionScore)>,

    /// The import data to add to completion's edits.
    import_to_add: Option<ImportEdit>,
}

// We use custom debug for CompletionItem to make snapshot tests more readable.
impl fmt::Debug for CompletionItem {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let mut s = f.debug_struct("CompletionItem");
        s.field("label", &self.label()).field("source_range", &self.source_range());
        if self.text_edit().len() == 1 {
            let atom = &self.text_edit().iter().next().unwrap();
            s.field("delete", &atom.delete);
            s.field("insert", &atom.insert);
        } else {
            s.field("text_edit", &self.text_edit);
        }
        if let Some(kind) = self.kind().as_ref() {
            s.field("kind", kind);
        }
        if self.lookup() != self.label() {
            s.field("lookup", &self.lookup());
        }
        if let Some(detail) = self.detail() {
            s.field("detail", &detail);
        }
        if let Some(documentation) = self.documentation() {
            s.field("documentation", &documentation);
        }
        if self.deprecated {
            s.field("deprecated", &true);
        }
        if let Some(score) = &self.score {
            s.field("score", score);
        }
        if self.trigger_call_info {
            s.field("trigger_call_info", &true);
        }
        s.finish()
    }
}

#[derive(Debug, Clone, Copy, Ord, PartialOrd, Eq, PartialEq)]
pub enum CompletionScore {
    /// If only type match
    TypeMatch,
    /// If type and name match
    TypeAndNameMatch,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum CompletionItemKind {
    SymbolKind(SymbolKind),
    Attribute,
    Binding,
    BuiltinType,
    Keyword,
    Method,
    Snippet,
    UnresolvedReference,
}

impl_from!(SymbolKind for CompletionItemKind);

impl CompletionItemKind {
    #[cfg(test)]
    pub(crate) fn tag(&self) -> &'static str {
        match self {
            CompletionItemKind::SymbolKind(kind) => match kind {
                SymbolKind::Const => "ct",
                SymbolKind::ConstParam => "cp",
                SymbolKind::Enum => "en",
                SymbolKind::Field => "fd",
                SymbolKind::Function => "fn",
                SymbolKind::Impl => "im",
                SymbolKind::Label => "lb",
                SymbolKind::LifetimeParam => "lt",
                SymbolKind::Local => "lc",
                SymbolKind::Macro => "ma",
                SymbolKind::Module => "md",
                SymbolKind::SelfParam => "sp",
                SymbolKind::Static => "sc",
                SymbolKind::Struct => "st",
                SymbolKind::Trait => "tt",
                SymbolKind::TypeAlias => "ta",
                SymbolKind::TypeParam => "tp",
                SymbolKind::Union => "un",
                SymbolKind::ValueParam => "vp",
                SymbolKind::Variant => "ev",
            },
            CompletionItemKind::Attribute => "at",
            CompletionItemKind::Binding => "bn",
            CompletionItemKind::BuiltinType => "bt",
            CompletionItemKind::Keyword => "kw",
            CompletionItemKind::Method => "me",
            CompletionItemKind::Snippet => "sn",
            CompletionItemKind::UnresolvedReference => "??",
        }
    }
}

#[derive(Debug, PartialEq, Eq, Copy, Clone)]
pub(crate) enum CompletionKind {
    /// Parser-based keyword completion.
    Keyword,
    /// Your usual "complete all valid identifiers".
    Reference,
    /// "Secret sauce" completions.
    Magic,
    Snippet,
    Postfix,
    BuiltinType,
    Attribute,
}

#[derive(Debug, PartialEq, Eq, Copy, Clone)]
pub enum InsertTextFormat {
    PlainText,
    Snippet,
}

impl CompletionItem {
    pub(crate) fn new(
        completion_kind: CompletionKind,
        source_range: TextRange,
        label: impl Into<String>,
    ) -> Builder {
        let label = label.into();
        Builder {
            source_range,
            completion_kind,
            label,
            insert_text: None,
            insert_text_format: InsertTextFormat::PlainText,
            detail: None,
            documentation: None,
            lookup: None,
            kind: None,
            text_edit: None,
            deprecated: None,
            trigger_call_info: None,
            score: None,
            ref_match: None,
            import_to_add: None,
        }
    }

    /// What user sees in pop-up in the UI.
    pub fn label(&self) -> &str {
        &self.label
    }
    pub fn source_range(&self) -> TextRange {
        self.source_range
    }

    pub fn insert_text_format(&self) -> InsertTextFormat {
        self.insert_text_format
    }

    pub fn text_edit(&self) -> &TextEdit {
        &self.text_edit
    }

    /// Short one-line additional information, like a type
    pub fn detail(&self) -> Option<&str> {
        self.detail.as_deref()
    }
    /// A doc-comment
    pub fn documentation(&self) -> Option<Documentation> {
        self.documentation.clone()
    }
    /// What string is used for filtering.
    pub fn lookup(&self) -> &str {
        self.lookup.as_deref().unwrap_or(&self.label)
    }

    pub fn kind(&self) -> Option<CompletionItemKind> {
        self.kind
    }

    pub fn deprecated(&self) -> bool {
        self.deprecated
    }

    pub fn score(&self) -> Option<CompletionScore> {
        self.score
    }

    pub fn trigger_call_info(&self) -> bool {
        self.trigger_call_info
    }

    pub fn ref_match(&self) -> Option<(Mutability, CompletionScore)> {
        self.ref_match
    }

    pub fn import_to_add(&self) -> Option<&ImportEdit> {
        self.import_to_add.as_ref()
    }
}

/// An extra import to add after the completion is applied.
#[derive(Debug, Clone)]
pub struct ImportEdit {
    pub import_path: ModPath,
    pub import_scope: ImportScope,
    pub import_for_trait_assoc_item: bool,
}

impl ImportEdit {
    /// Attempts to insert the import to the given scope, producing a text edit.
    /// May return no edit in edge cases, such as scope already containing the import.
    pub fn to_text_edit(&self, merge_behavior: Option<MergeBehavior>) -> Option<TextEdit> {
        let _p = profile::span("ImportEdit::to_text_edit");

        let rewriter = insert_use::insert_use(
            &self.import_scope,
            mod_path_to_ast(&self.import_path),
            merge_behavior,
        );
        let old_ast = rewriter.rewrite_root()?;
        let mut import_insert = TextEdit::builder();
        algo::diff(&old_ast, &rewriter.rewrite(&old_ast)).into_text_edit(&mut import_insert);

        Some(import_insert.finish())
    }
}

/// A helper to make `CompletionItem`s.
#[must_use]
#[derive(Clone)]
pub(crate) struct Builder {
    source_range: TextRange,
    completion_kind: CompletionKind,
    import_to_add: Option<ImportEdit>,
    label: String,
    insert_text: Option<String>,
    insert_text_format: InsertTextFormat,
    detail: Option<String>,
    documentation: Option<Documentation>,
    lookup: Option<String>,
    kind: Option<CompletionItemKind>,
    text_edit: Option<TextEdit>,
    deprecated: Option<bool>,
    trigger_call_info: Option<bool>,
    score: Option<CompletionScore>,
    ref_match: Option<(Mutability, CompletionScore)>,
}

impl Builder {
    pub(crate) fn build(self) -> CompletionItem {
        let _p = profile::span("item::Builder::build");

        let mut label = self.label;
        let mut lookup = self.lookup;
        let mut insert_text = self.insert_text;

        if let Some(import_to_add) = self.import_to_add.as_ref() {
            if import_to_add.import_for_trait_assoc_item {
                lookup = lookup.or_else(|| Some(label.clone()));
                insert_text = insert_text.or_else(|| Some(label.clone()));
                label = format!("{} ({})", label, import_to_add.import_path);
            } else {
                let mut import_path_without_last_segment = import_to_add.import_path.to_owned();
                let _ = import_path_without_last_segment.pop_segment();

                if !import_path_without_last_segment.segments().is_empty() {
                    lookup = lookup.or_else(|| Some(label.clone()));
                    insert_text = insert_text.or_else(|| Some(label.clone()));
                    label = format!("{}::{}", import_path_without_last_segment, label);
                }
            }
        }

        let text_edit = match self.text_edit {
            Some(it) => it,
            None => {
                TextEdit::replace(self.source_range, insert_text.unwrap_or_else(|| label.clone()))
            }
        };

        CompletionItem {
            source_range: self.source_range,
            label,
            insert_text_format: self.insert_text_format,
            text_edit,
            detail: self.detail,
            documentation: self.documentation,
            lookup,
            kind: self.kind,
            completion_kind: self.completion_kind,
            deprecated: self.deprecated.unwrap_or(false),
            trigger_call_info: self.trigger_call_info.unwrap_or(false),
            score: self.score,
            ref_match: self.ref_match,
            import_to_add: self.import_to_add,
        }
    }
    pub(crate) fn lookup_by(mut self, lookup: impl Into<String>) -> Builder {
        self.lookup = Some(lookup.into());
        self
    }
    pub(crate) fn label(mut self, label: impl Into<String>) -> Builder {
        self.label = label.into();
        self
    }
    pub(crate) fn insert_text(mut self, insert_text: impl Into<String>) -> Builder {
        self.insert_text = Some(insert_text.into());
        self
    }
    pub(crate) fn insert_snippet(
        mut self,
        _cap: SnippetCap,
        snippet: impl Into<String>,
    ) -> Builder {
        self.insert_text_format = InsertTextFormat::Snippet;
        self.insert_text(snippet)
    }
    pub(crate) fn kind(mut self, kind: impl Into<CompletionItemKind>) -> Builder {
        self.kind = Some(kind.into());
        self
    }
    pub(crate) fn text_edit(mut self, edit: TextEdit) -> Builder {
        self.text_edit = Some(edit);
        self
    }
    pub(crate) fn snippet_edit(mut self, _cap: SnippetCap, edit: TextEdit) -> Builder {
        self.insert_text_format = InsertTextFormat::Snippet;
        self.text_edit(edit)
    }
    pub(crate) fn detail(self, detail: impl Into<String>) -> Builder {
        self.set_detail(Some(detail))
    }
    pub(crate) fn set_detail(mut self, detail: Option<impl Into<String>>) -> Builder {
        self.detail = detail.map(Into::into);
        if let Some(detail) = &self.detail {
            if never!(detail.contains('\n'), "multiline detail:\n{}", detail) {
                self.detail = Some(detail.splitn(2, '\n').next().unwrap().to_string());
            }
        }
        self
    }
    #[allow(unused)]
    pub(crate) fn documentation(self, docs: Documentation) -> Builder {
        self.set_documentation(Some(docs))
    }
    pub(crate) fn set_documentation(mut self, docs: Option<Documentation>) -> Builder {
        self.documentation = docs.map(Into::into);
        self
    }
    pub(crate) fn set_deprecated(mut self, deprecated: bool) -> Builder {
        self.deprecated = Some(deprecated);
        self
    }
    pub(crate) fn set_score(mut self, score: CompletionScore) -> Builder {
        self.score = Some(score);
        self
    }
    pub(crate) fn trigger_call_info(mut self) -> Builder {
        self.trigger_call_info = Some(true);
        self
    }
    pub(crate) fn add_import(mut self, import_to_add: Option<ImportEdit>) -> Builder {
        self.import_to_add = import_to_add;
        self
    }
    pub(crate) fn set_ref_match(
        mut self,
        ref_match: Option<(Mutability, CompletionScore)>,
    ) -> Builder {
        self.ref_match = ref_match;
        self
    }
}

impl<'a> Into<CompletionItem> for Builder {
    fn into(self) -> CompletionItem {
        self.build()
    }
}
