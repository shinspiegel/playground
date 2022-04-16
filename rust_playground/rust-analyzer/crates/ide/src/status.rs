use std::{fmt, iter::FromIterator, sync::Arc};

use hir::{ExpandResult, MacroFile};
use ide_db::base_db::{
    salsa::debug::{DebugQueryTable, TableEntry},
    CrateId, FileId, FileTextQuery, SourceDatabase, SourceRootId,
};
use ide_db::{
    symbol_index::{LibrarySymbolsQuery, SymbolIndex},
    RootDatabase,
};
use itertools::Itertools;
use profile::{memory_usage, Bytes};
use rustc_hash::FxHashMap;
use stdx::format_to;
use syntax::{ast, Parse, SyntaxNode};

fn syntax_tree_stats(db: &RootDatabase) -> SyntaxTreeStats {
    ide_db::base_db::ParseQuery.in_db(db).entries::<SyntaxTreeStats>()
}
fn macro_syntax_tree_stats(db: &RootDatabase) -> SyntaxTreeStats {
    hir::db::ParseMacroExpansionQuery.in_db(db).entries::<SyntaxTreeStats>()
}

// Feature: Status
//
// Shows internal statistic about memory usage of rust-analyzer.
//
// |===
// | Editor  | Action Name
//
// | VS Code | **Rust Analyzer: Status**
// |===
pub(crate) fn status(db: &RootDatabase, file_id: Option<FileId>) -> String {
    let mut buf = String::new();
    format_to!(buf, "{}\n", FileTextQuery.in_db(db).entries::<FilesStats>());
    format_to!(buf, "{}\n", LibrarySymbolsQuery.in_db(db).entries::<LibrarySymbolsStats>());
    format_to!(buf, "{}\n", syntax_tree_stats(db));
    format_to!(buf, "{} (macros)\n", macro_syntax_tree_stats(db));
    format_to!(buf, "{} total\n", memory_usage());
    format_to!(buf, "\ncounts:\n{}", profile::countme::get_all());

    if let Some(file_id) = file_id {
        format_to!(buf, "\nfile info:\n");
        let krate = crate::parent_module::crate_for(db, file_id).pop();
        match krate {
            Some(krate) => {
                let crate_graph = db.crate_graph();
                let display_crate = |krate: CrateId| match &crate_graph[krate].display_name {
                    Some(it) => format!("{}({:?})", it, krate),
                    None => format!("{:?}", krate),
                };
                format_to!(buf, "crate: {}\n", display_crate(krate));
                let deps = crate_graph[krate]
                    .dependencies
                    .iter()
                    .map(|dep| format!("{}={:?}", dep.name, dep.crate_id))
                    .format(", ");
                format_to!(buf, "deps: {}\n", deps);
            }
            None => format_to!(buf, "does not belong to any crate"),
        }
    }

    buf
}

#[derive(Default)]
struct FilesStats {
    total: usize,
    size: Bytes,
}

impl fmt::Display for FilesStats {
    fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result {
        write!(fmt, "{} ({}) files", self.total, self.size)
    }
}

impl FromIterator<TableEntry<FileId, Arc<String>>> for FilesStats {
    fn from_iter<T>(iter: T) -> FilesStats
    where
        T: IntoIterator<Item = TableEntry<FileId, Arc<String>>>,
    {
        let mut res = FilesStats::default();
        for entry in iter {
            res.total += 1;
            res.size += entry.value.unwrap().len();
        }
        res
    }
}

#[derive(Default)]
pub(crate) struct SyntaxTreeStats {
    total: usize,
    pub(crate) retained: usize,
}

impl fmt::Display for SyntaxTreeStats {
    fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result {
        write!(fmt, "{} trees, {} retained", self.total, self.retained)
    }
}

impl FromIterator<TableEntry<FileId, Parse<ast::SourceFile>>> for SyntaxTreeStats {
    fn from_iter<T>(iter: T) -> SyntaxTreeStats
    where
        T: IntoIterator<Item = TableEntry<FileId, Parse<ast::SourceFile>>>,
    {
        let mut res = SyntaxTreeStats::default();
        for entry in iter {
            res.total += 1;
            res.retained += entry.value.is_some() as usize;
        }
        res
    }
}

impl<M> FromIterator<TableEntry<MacroFile, ExpandResult<Option<(Parse<SyntaxNode>, M)>>>>
    for SyntaxTreeStats
{
    fn from_iter<T>(iter: T) -> SyntaxTreeStats
    where
        T: IntoIterator<Item = TableEntry<MacroFile, ExpandResult<Option<(Parse<SyntaxNode>, M)>>>>,
    {
        let mut res = SyntaxTreeStats::default();
        for entry in iter {
            res.total += 1;
            res.retained += entry.value.is_some() as usize;
        }
        res
    }
}

#[derive(Default)]
struct LibrarySymbolsStats {
    total: usize,
    size: Bytes,
}

impl fmt::Display for LibrarySymbolsStats {
    fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result {
        write!(fmt, "{} ({}) index symbols", self.total, self.size)
    }
}

impl FromIterator<TableEntry<(), Arc<FxHashMap<SourceRootId, SymbolIndex>>>>
    for LibrarySymbolsStats
{
    fn from_iter<T>(iter: T) -> LibrarySymbolsStats
    where
        T: IntoIterator<Item = TableEntry<(), Arc<FxHashMap<SourceRootId, SymbolIndex>>>>,
    {
        let mut res = LibrarySymbolsStats::default();
        for entry in iter {
            let value = entry.value.unwrap();
            for symbols in value.values() {
                res.total += symbols.len();
                res.size += symbols.memory_size();
            }
        }
        res
    }
}
