use std::{
    collections::HashMap,
    path::{Path, PathBuf},
};

use xshell::{cmd, read_file};
use xtask::{
    cargo_files,
    codegen::{self, Mode},
    project_root, run_rustfmt, rust_files,
};

#[test]
fn generated_grammar_is_fresh() {
    if let Err(error) = codegen::generate_syntax(Mode::Verify) {
        panic!("{}. Please update it by running `cargo xtask codegen`", error);
    }
}

#[test]
fn generated_tests_are_fresh() {
    if let Err(error) = codegen::generate_parser_tests(Mode::Verify) {
        panic!("{}. Please update tests by running `cargo xtask codegen`", error);
    }
}

#[test]
fn generated_assists_are_fresh() {
    if let Err(error) = codegen::generate_assists_tests(Mode::Verify) {
        panic!("{}. Please update assists by running `cargo xtask codegen`", error);
    }
}

#[test]
fn check_code_formatting() {
    if let Err(error) = run_rustfmt(Mode::Verify) {
        panic!("{}. Please format the code by running `cargo format`", error);
    }
}

#[test]
fn smoke_test_docs_generation() {
    // We don't commit docs to the repo, so we can just overwrite in tests.
    codegen::generate_assists_docs(Mode::Overwrite).unwrap();
    codegen::generate_feature_docs(Mode::Overwrite).unwrap();
    codegen::generate_diagnostic_docs(Mode::Overwrite).unwrap();
}

#[test]
fn check_lsp_extensions_docs() {
    let expected_hash = {
        let lsp_ext_rs =
            read_file(project_root().join("crates/rust-analyzer/src/lsp_ext.rs")).unwrap();
        stable_hash(lsp_ext_rs.as_str())
    };

    let actual_hash = {
        let lsp_extensions_md =
            read_file(project_root().join("docs/dev/lsp-extensions.md")).unwrap();
        let text = lsp_extensions_md
            .lines()
            .find_map(|line| line.strip_prefix("lsp_ext.rs hash:"))
            .unwrap()
            .trim();
        u64::from_str_radix(text, 16).unwrap()
    };

    if actual_hash != expected_hash {
        panic!(
            "
lsp_ext.rs was changed without touching lsp-extensions.md.

Expected hash: {:x}
Actual hash:   {:x}

Please adjust docs/dev/lsp-extensions.md.
",
            expected_hash, actual_hash
        )
    }
}

#[test]
fn rust_files_are_tidy() {
    let mut tidy_docs = TidyDocs::default();
    for path in rust_files() {
        let text = read_file(&path).unwrap();
        check_todo(&path, &text);
        check_dbg(&path, &text);
        check_trailing_ws(&path, &text);
        deny_clippy(&path, &text);
        tidy_docs.visit(&path, &text);
    }
    tidy_docs.finish();
}

#[test]
fn cargo_files_are_tidy() {
    for cargo in cargo_files() {
        let mut section = None;
        for (line_no, text) in read_file(&cargo).unwrap().lines().enumerate() {
            let text = text.trim();
            if text.starts_with("[") {
                section = Some(text);
                continue;
            }
            if !section.map(|it| it.starts_with("[dependencies")).unwrap_or(false) {
                continue;
            }
            let text: String = text.split_whitespace().collect();
            if text.contains("path=") && !text.contains("version") {
                panic!(
                    "\ncargo internal dependencies should have version.\n\
                     {}:{}\n",
                    cargo.display(),
                    line_no + 1
                )
            }
        }
    }
}

#[test]
fn check_merge_commits() {
    let stdout = cmd!("git rev-list --merges --invert-grep --author 'bors\\[bot\\]' HEAD~19..")
        .read()
        .unwrap();
    if !stdout.is_empty() {
        panic!(
            "
Merge commits are not allowed in the history.

When updating a pull-request, please rebase your feature branch
on top of master by running `git rebase master`. If rebase fails,
you can re-apply your changes like this:

  # Just look around to see the current state.
  $ git status
  $ git log

  # Abort in-progress rebase and merges, if any.
  $ git rebase --abort
  $ git merge --abort

  # Make the branch point to the latest commit from master,
  # while maintaining your local changes uncommited.
  $ git reset --soft origin/master

  # Commit all changes in a single batch.
  $ git commit -am'My changes'

  # Verify that everything looks alright.
  $ git status
  $ git log

  # Push the changes. We did a rebase, so we need `--force` option.
  # `--force-with-lease` is a more safe (Rusty) version of `--force`.
  $ git push --force-with-lease

  # Verify that both local and remote branch point to the same commit.
  $ git log

And don't fear to mess something up during a rebase -- you can
always restore the previous state using `git ref-log`:

https://github.blog/2015-06-08-how-to-undo-almost-anything-with-git/#redo-after-undo-local
"
        );
    }
}

fn deny_clippy(path: &PathBuf, text: &String) {
    let ignore = &[
        // The documentation in string literals may contain anything for its own purposes
        "completion/src/generated_lint_completions.rs",
    ];
    if ignore.iter().any(|p| path.ends_with(p)) {
        return;
    }

    if text.contains("\u{61}llow(clippy") {
        panic!(
            "\n\nallowing lints is forbidden: {}.
rust-analyzer intentionally doesn't check clippy on CI.
You can allow lint globally via `xtask clippy`.
See https://github.com/rust-lang/rust-clippy/issues/5537 for discussion.

",
            path.display()
        )
    }
}

#[test]
fn check_licenses() {
    let expected = "
0BSD OR MIT OR Apache-2.0
Apache-2.0
Apache-2.0 OR BSL-1.0
Apache-2.0 OR MIT
Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT
Apache-2.0/MIT
BSD-3-Clause
CC0-1.0
ISC
MIT
MIT / Apache-2.0
MIT OR Apache-2.0
MIT OR Apache-2.0 OR Zlib
MIT OR Zlib OR Apache-2.0
MIT/Apache-2.0
Unlicense OR MIT
Unlicense/MIT
Zlib OR Apache-2.0 OR MIT
"
    .lines()
    .filter(|it| !it.is_empty())
    .collect::<Vec<_>>();

    let meta = cmd!("cargo metadata --format-version 1").read().unwrap();
    let mut licenses = meta
        .split(|c| c == ',' || c == '{' || c == '}')
        .filter(|it| it.contains(r#""license""#))
        .map(|it| it.trim())
        .map(|it| it[r#""license":"#.len()..].trim_matches('"'))
        .collect::<Vec<_>>();
    licenses.sort();
    licenses.dedup();
    if licenses != expected {
        let mut diff = String::new();

        diff += &format!("New Licenses:\n");
        for &l in licenses.iter() {
            if !expected.contains(&l) {
                diff += &format!("  {}\n", l)
            }
        }

        diff += &format!("\nMissing Licenses:\n");
        for &l in expected.iter() {
            if !licenses.contains(&l) {
                diff += &format!("  {}\n", l)
            }
        }

        panic!("different set of licenses!\n{}", diff);
    }
    assert_eq!(licenses, expected);
}

fn check_todo(path: &Path, text: &str) {
    let need_todo = &[
        // This file itself obviously needs to use todo (<- like this!).
        "tests/tidy.rs",
        // Some of our assists generate `todo!()`.
        "handlers/add_turbo_fish.rs",
        "handlers/generate_function.rs",
        // To support generating `todo!()` in assists, we have `expr_todo()` in
        // `ast::make`.
        "ast/make.rs",
        // The documentation in string literals may contain anything for its own purposes
        "completion/src/generated_lint_completions.rs",
    ];
    if need_todo.iter().any(|p| path.ends_with(p)) {
        return;
    }
    if text.contains("TODO") || text.contains("TOOD") || text.contains("todo!") {
        // Generated by an assist
        if text.contains("${0:todo!()}") {
            return;
        }

        panic!(
            "\nTODO markers or todo! macros should not be committed to the master branch,\n\
             use FIXME instead\n\
             {}\n",
            path.display(),
        )
    }
}

fn check_dbg(path: &Path, text: &str) {
    let need_dbg = &[
        // This file itself obviously needs to use dbg.
        "tests/tidy.rs",
        // Assists to remove `dbg!()`
        "handlers/remove_dbg.rs",
        // We have .dbg postfix
        "completion/src/completions/postfix.rs",
        // The documentation in string literals may contain anything for its own purposes
        "completion/src/lib.rs",
        "completion/src/generated_lint_completions.rs",
        // test for doc test for remove_dbg
        "src/tests/generated.rs",
    ];
    if need_dbg.iter().any(|p| path.ends_with(p)) {
        return;
    }
    if text.contains("dbg!") {
        panic!(
            "\ndbg! macros should not be committed to the master branch,\n\
             {}\n",
            path.display(),
        )
    }
}

fn check_trailing_ws(path: &Path, text: &str) {
    if is_exclude_dir(path, &["test_data"]) {
        return;
    }
    for (line_number, line) in text.lines().enumerate() {
        if line.chars().last().map(char::is_whitespace) == Some(true) {
            panic!("Trailing whitespace in {} at line {}", path.display(), line_number)
        }
    }
}

#[derive(Default)]
struct TidyDocs {
    missing_docs: Vec<String>,
    contains_fixme: Vec<PathBuf>,
}

impl TidyDocs {
    fn visit(&mut self, path: &Path, text: &str) {
        // Test hopefully don't really need comments, and for assists we already
        // have special comments which are source of doc tests and user docs.
        if is_exclude_dir(path, &["tests", "test_data"]) {
            return;
        }

        if is_exclude_file(path) {
            return;
        }

        let first_line = match text.lines().next() {
            Some(it) => it,
            None => return,
        };

        if first_line.starts_with("//!") {
            if first_line.contains("FIXME") {
                self.contains_fixme.push(path.to_path_buf());
            }
        } else {
            if text.contains("// Feature:") || text.contains("// Assist:") {
                return;
            }
            self.missing_docs.push(path.display().to_string());
        }

        fn is_exclude_file(d: &Path) -> bool {
            let file_names = ["tests.rs", "famous_defs_fixture.rs"];

            d.file_name()
                .unwrap_or_default()
                .to_str()
                .map(|f_n| file_names.iter().any(|name| *name == f_n))
                .unwrap_or(false)
        }
    }

    fn finish(self) {
        if !self.missing_docs.is_empty() {
            panic!(
                "\nMissing docs strings\n\n\
                 modules:\n{}\n\n",
                self.missing_docs.join("\n")
            )
        }

        let poorly_documented = [
            "hir",
            "hir_expand",
            "ide",
            "mbe",
            "parser",
            "profile",
            "project_model",
            "syntax",
            "tt",
            "hir_ty",
        ];

        let mut has_fixmes =
            poorly_documented.iter().map(|it| (*it, false)).collect::<HashMap<&str, bool>>();
        'outer: for path in self.contains_fixme {
            for krate in poorly_documented.iter() {
                if path.components().any(|it| it.as_os_str() == *krate) {
                    has_fixmes.insert(krate, true);
                    continue 'outer;
                }
            }
            panic!("FIXME doc in a fully-documented crate: {}", path.display())
        }

        for (krate, has_fixme) in has_fixmes.iter() {
            if !has_fixme {
                panic!("crate {} is fully documented :tada:, remove it from the list of poorly documented crates", krate)
            }
        }
    }
}

fn is_exclude_dir(p: &Path, dirs_to_exclude: &[&str]) -> bool {
    p.strip_prefix(project_root())
        .unwrap()
        .components()
        .rev()
        .skip(1)
        .filter_map(|it| it.as_os_str().to_str())
        .any(|it| dirs_to_exclude.contains(&it))
}

#[allow(deprecated)]
fn stable_hash(text: &str) -> u64 {
    use std::hash::{Hash, Hasher, SipHasher};

    let text = text.replace('\r', "");
    let mut hasher = SipHasher::default();
    text.hash(&mut hasher);
    hasher.finish()
}
