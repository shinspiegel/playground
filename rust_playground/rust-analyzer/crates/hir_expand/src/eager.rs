//! Eager expansion related utils
//!
//! Here is a dump of a discussion from Vadim Petrochenkov about Eager Expansion and
//! Its name resolution :
//!
//! > Eagerly expanded macros (and also macros eagerly expanded by eagerly expanded macros,
//! > which actually happens in practice too!) are resolved at the location of the "root" macro
//! > that performs the eager expansion on its arguments.
//! > If some name cannot be resolved at the eager expansion time it's considered unresolved,
//! > even if becomes available later (e.g. from a glob import or other macro).
//!
//! > Eagerly expanded macros don't add anything to the module structure of the crate and
//! > don't build any speculative module structures, i.e. they are expanded in a "flat"
//! > way even if tokens in them look like modules.
//!
//! > In other words, it kinda works for simple cases for which it was originally intended,
//! > and we need to live with it because it's available on stable and widely relied upon.
//!
//!
//! See the full discussion : https://rust-lang.zulipchat.com/#narrow/stream/131828-t-compiler/topic/Eager.20expansion.20of.20built-in.20macros

use crate::{
    ast::{self, AstNode},
    db::AstDatabase,
    EagerCallLoc, EagerMacroId, InFile, MacroCallId, MacroCallKind, MacroDefId, MacroDefKind,
};

use base_db::CrateId;
use mbe::ExpandResult;
use parser::FragmentKind;
use std::sync::Arc;
use syntax::{algo::SyntaxRewriter, SyntaxNode};

pub struct ErrorEmitted {
    _private: (),
}

trait ErrorSink {
    fn emit(&mut self, err: mbe::ExpandError);

    fn option<T>(
        &mut self,
        opt: Option<T>,
        error: impl FnOnce() -> mbe::ExpandError,
    ) -> Result<T, ErrorEmitted> {
        match opt {
            Some(it) => Ok(it),
            None => {
                self.emit(error());
                Err(ErrorEmitted { _private: () })
            }
        }
    }

    fn option_with<T>(
        &mut self,
        opt: impl FnOnce() -> Option<T>,
        error: impl FnOnce() -> mbe::ExpandError,
    ) -> Result<T, ErrorEmitted> {
        self.option(opt(), error)
    }

    fn result<T>(&mut self, res: Result<T, mbe::ExpandError>) -> Result<T, ErrorEmitted> {
        match res {
            Ok(it) => Ok(it),
            Err(e) => {
                self.emit(e);
                Err(ErrorEmitted { _private: () })
            }
        }
    }

    fn expand_result_option<T>(&mut self, res: ExpandResult<Option<T>>) -> Result<T, ErrorEmitted> {
        match (res.value, res.err) {
            (None, Some(err)) => {
                self.emit(err);
                Err(ErrorEmitted { _private: () })
            }
            (Some(value), opt_err) => {
                if let Some(err) = opt_err {
                    self.emit(err);
                }
                Ok(value)
            }
            (None, None) => unreachable!("`ExpandResult` without value or error"),
        }
    }
}

impl ErrorSink for &'_ mut dyn FnMut(mbe::ExpandError) {
    fn emit(&mut self, err: mbe::ExpandError) {
        self(err);
    }
}

fn err(msg: impl Into<String>) -> mbe::ExpandError {
    mbe::ExpandError::Other(msg.into())
}

pub fn expand_eager_macro(
    db: &dyn AstDatabase,
    krate: CrateId,
    macro_call: InFile<ast::MacroCall>,
    def: MacroDefId,
    resolver: &dyn Fn(ast::Path) -> Option<MacroDefId>,
    mut diagnostic_sink: &mut dyn FnMut(mbe::ExpandError),
) -> Result<EagerMacroId, ErrorEmitted> {
    let parsed_args = diagnostic_sink.option_with(
        || Some(mbe::ast_to_token_tree(&macro_call.value.token_tree()?)?.0),
        || err("malformed macro invocation"),
    )?;

    let ast_map = db.ast_id_map(macro_call.file_id);
    let call_id = InFile::new(macro_call.file_id, ast_map.ast_id(&macro_call.value));

    // Note:
    // When `lazy_expand` is called, its *parent* file must be already exists.
    // Here we store an eager macro id for the argument expanded subtree here
    // for that purpose.
    let arg_id = db.intern_eager_expansion({
        EagerCallLoc {
            def,
            fragment: FragmentKind::Expr,
            subtree: Arc::new(parsed_args.clone()),
            krate,
            call: call_id,
        }
    });
    let arg_file_id: MacroCallId = arg_id.into();

    let parsed_args =
        diagnostic_sink.result(mbe::token_tree_to_syntax_node(&parsed_args, FragmentKind::Expr))?.0;
    let result = eager_macro_recur(
        db,
        InFile::new(arg_file_id.as_file(), parsed_args.syntax_node()),
        krate,
        resolver,
        diagnostic_sink,
    )?;
    let subtree =
        diagnostic_sink.option(to_subtree(&result), || err("failed to parse macro result"))?;

    if let MacroDefKind::BuiltInEager(eager) = def.kind {
        let res = eager.expand(db, arg_id, &subtree);

        let (subtree, fragment) = diagnostic_sink.expand_result_option(res)?;
        let eager =
            EagerCallLoc { def, fragment, subtree: Arc::new(subtree), krate, call: call_id };

        Ok(db.intern_eager_expansion(eager))
    } else {
        panic!("called `expand_eager_macro` on non-eager macro def {:?}", def);
    }
}

fn to_subtree(node: &SyntaxNode) -> Option<tt::Subtree> {
    let mut subtree = mbe::syntax_node_to_token_tree(node)?.0;
    subtree.delimiter = None;
    Some(subtree)
}

fn lazy_expand(
    db: &dyn AstDatabase,
    def: &MacroDefId,
    macro_call: InFile<ast::MacroCall>,
    krate: CrateId,
) -> ExpandResult<Option<InFile<SyntaxNode>>> {
    let ast_id = db.ast_id_map(macro_call.file_id).ast_id(&macro_call.value);

    let id: MacroCallId =
        def.as_lazy_macro(db, krate, MacroCallKind::FnLike(macro_call.with_value(ast_id))).into();

    let err = db.macro_expand_error(id);
    let value = db.parse_or_expand(id.as_file()).map(|node| InFile::new(id.as_file(), node));

    ExpandResult { value, err }
}

fn eager_macro_recur(
    db: &dyn AstDatabase,
    curr: InFile<SyntaxNode>,
    krate: CrateId,
    macro_resolver: &dyn Fn(ast::Path) -> Option<MacroDefId>,
    mut diagnostic_sink: &mut dyn FnMut(mbe::ExpandError),
) -> Result<SyntaxNode, ErrorEmitted> {
    let original = curr.value.clone();

    let children = curr.value.descendants().filter_map(ast::MacroCall::cast);
    let mut rewriter = SyntaxRewriter::default();

    // Collect replacement
    for child in children {
        let def = diagnostic_sink
            .option_with(|| macro_resolver(child.path()?), || err("failed to resolve macro"))?;
        let insert = match def.kind {
            MacroDefKind::BuiltInEager(_) => {
                let id: MacroCallId = expand_eager_macro(
                    db,
                    krate,
                    curr.with_value(child.clone()),
                    def,
                    macro_resolver,
                    diagnostic_sink,
                )?
                .into();
                db.parse_or_expand(id.as_file())
                    .expect("successful macro expansion should be parseable")
            }
            MacroDefKind::Declarative
            | MacroDefKind::BuiltIn(_)
            | MacroDefKind::BuiltInDerive(_)
            | MacroDefKind::ProcMacro(_) => {
                let res = lazy_expand(db, &def, curr.with_value(child.clone()), krate);
                let val = diagnostic_sink.expand_result_option(res)?;

                // replace macro inside
                eager_macro_recur(db, val, krate, macro_resolver, diagnostic_sink)?
            }
        };

        // check if the whole original sytnax is replaced
        // Note that SyntaxRewriter cannot replace the root node itself
        if child.syntax() == &original {
            return Ok(insert);
        }

        rewriter.replace(child.syntax(), &insert);
    }

    let res = rewriter.rewrite(&original);
    Ok(res)
}
