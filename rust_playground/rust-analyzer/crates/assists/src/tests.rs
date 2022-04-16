mod generated;

use hir::Semantics;
use ide_db::{
    base_db::{fixture::WithFixture, FileId, FileRange, SourceDatabaseExt},
    helpers::{
        insert_use::{InsertUseConfig, MergeBehavior},
        SnippetCap,
    },
    source_change::FileSystemEdit,
    RootDatabase,
};
use syntax::TextRange;
use test_utils::{assert_eq_text, extract_offset, extract_range};

use crate::{handlers::Handler, Assist, AssistConfig, AssistContext, AssistKind, Assists};
use stdx::{format_to, trim_indent};

pub(crate) const TEST_CONFIG: AssistConfig = AssistConfig {
    snippet_cap: SnippetCap::new(true),
    allowed: None,
    insert_use: InsertUseConfig {
        merge: Some(MergeBehavior::Full),
        prefix_kind: hir::PrefixKind::Plain,
    },
};

pub(crate) fn with_single_file(text: &str) -> (RootDatabase, FileId) {
    RootDatabase::with_single_file(text)
}

pub(crate) fn check_assist(assist: Handler, ra_fixture_before: &str, ra_fixture_after: &str) {
    let ra_fixture_after = trim_indent(ra_fixture_after);
    check(assist, ra_fixture_before, ExpectedResult::After(&ra_fixture_after), None);
}

// There is no way to choose what assist within a group you want to test against,
// so this is here to allow you choose.
pub(crate) fn check_assist_by_label(
    assist: Handler,
    ra_fixture_before: &str,
    ra_fixture_after: &str,
    label: &str,
) {
    let ra_fixture_after = trim_indent(ra_fixture_after);
    check(assist, ra_fixture_before, ExpectedResult::After(&ra_fixture_after), Some(label));
}

// FIXME: instead of having a separate function here, maybe use
// `extract_ranges` and mark the target as `<target> </target>` in the
// fixture?
#[track_caller]
pub(crate) fn check_assist_target(assist: Handler, ra_fixture: &str, target: &str) {
    check(assist, ra_fixture, ExpectedResult::Target(target), None);
}

#[track_caller]
pub(crate) fn check_assist_not_applicable(assist: Handler, ra_fixture: &str) {
    check(assist, ra_fixture, ExpectedResult::NotApplicable, None);
}

#[track_caller]
fn check_doc_test(assist_id: &str, before: &str, after: &str) {
    let after = trim_indent(after);
    let (db, file_id, selection) = RootDatabase::with_range_or_offset(&before);
    let before = db.file_text(file_id).to_string();
    let frange = FileRange { file_id, range: selection.into() };

    let assist = Assist::get(&db, &TEST_CONFIG, true, frange)
        .into_iter()
        .find(|assist| assist.id.0 == assist_id)
        .unwrap_or_else(|| {
            panic!(
                "\n\nAssist is not applicable: {}\nAvailable assists: {}",
                assist_id,
                Assist::get(&db, &TEST_CONFIG, false, frange)
                    .into_iter()
                    .map(|assist| assist.id.0)
                    .collect::<Vec<_>>()
                    .join(", ")
            )
        });

    let actual = {
        let source_change = assist.source_change.unwrap();
        let mut actual = before;
        if let Some(source_file_edit) = source_change.get_source_edit(file_id) {
            source_file_edit.apply(&mut actual);
        }
        actual
    };
    assert_eq_text!(&after, &actual);
}

enum ExpectedResult<'a> {
    NotApplicable,
    After(&'a str),
    Target(&'a str),
}

#[track_caller]
fn check(handler: Handler, before: &str, expected: ExpectedResult, assist_label: Option<&str>) {
    let (db, file_with_caret_id, range_or_offset) = RootDatabase::with_range_or_offset(before);
    let text_without_caret = db.file_text(file_with_caret_id).to_string();

    let frange = FileRange { file_id: file_with_caret_id, range: range_or_offset.into() };

    let sema = Semantics::new(&db);
    let config = TEST_CONFIG;
    let ctx = AssistContext::new(sema, &config, frange);
    let mut acc = Assists::new(&ctx, true);
    handler(&mut acc, &ctx);
    let mut res = acc.finish();

    let assist = match assist_label {
        Some(label) => res.into_iter().find(|resolved| resolved.label == label),
        None => res.pop(),
    };

    match (assist, expected) {
        (Some(assist), ExpectedResult::After(after)) => {
            let source_change = assist.source_change.unwrap();
            assert!(!source_change.source_file_edits.is_empty());
            let skip_header = source_change.source_file_edits.len() == 1
                && source_change.file_system_edits.len() == 0;

            let mut buf = String::new();
            for (file_id, edit) in source_change.source_file_edits {
                let mut text = db.file_text(file_id).as_ref().to_owned();
                edit.apply(&mut text);
                if !skip_header {
                    let sr = db.file_source_root(file_id);
                    let sr = db.source_root(sr);
                    let path = sr.path_for_file(&file_id).unwrap();
                    format_to!(buf, "//- {}\n", path)
                }
                buf.push_str(&text);
            }

            for file_system_edit in source_change.file_system_edits {
                if let FileSystemEdit::CreateFile { dst, initial_contents } = file_system_edit {
                    let sr = db.file_source_root(dst.anchor);
                    let sr = db.source_root(sr);
                    let mut base = sr.path_for_file(&dst.anchor).unwrap().clone();
                    base.pop();
                    let created_file_path = format!("{}{}", base.to_string(), &dst.path[1..]);
                    format_to!(buf, "//- {}\n", created_file_path);
                    buf.push_str(&initial_contents);
                }
            }

            assert_eq_text!(after, &buf);
        }
        (Some(assist), ExpectedResult::Target(target)) => {
            let range = assist.target;
            assert_eq_text!(&text_without_caret[range], target);
        }
        (Some(_), ExpectedResult::NotApplicable) => panic!("assist should not be applicable!"),
        (None, ExpectedResult::After(_)) | (None, ExpectedResult::Target(_)) => {
            panic!("code action is not applicable")
        }
        (None, ExpectedResult::NotApplicable) => (),
    };
}

#[test]
fn assist_order_field_struct() {
    let before = "struct Foo { $0bar: u32 }";
    let (before_cursor_pos, before) = extract_offset(before);
    let (db, file_id) = with_single_file(&before);
    let frange = FileRange { file_id, range: TextRange::empty(before_cursor_pos) };
    let assists = Assist::get(&db, &TEST_CONFIG, false, frange);
    let mut assists = assists.iter();

    assert_eq!(assists.next().expect("expected assist").label, "Change visibility to pub(crate)");
    assert_eq!(assists.next().expect("expected assist").label, "Generate a getter method");
    assert_eq!(assists.next().expect("expected assist").label, "Generate a mut getter method");
    assert_eq!(assists.next().expect("expected assist").label, "Generate a setter method");
    assert_eq!(assists.next().expect("expected assist").label, "Add `#[derive]`");
}

#[test]
fn assist_order_if_expr() {
    let before = "
    pub fn test_some_range(a: int) -> bool {
        if let 2..6 = $05$0 {
            true
        } else {
            false
        }
    }";
    let (range, before) = extract_range(before);
    let (db, file_id) = with_single_file(&before);
    let frange = FileRange { file_id, range };
    let assists = Assist::get(&db, &TEST_CONFIG, false, frange);
    let mut assists = assists.iter();

    assert_eq!(assists.next().expect("expected assist").label, "Extract into variable");
    assert_eq!(assists.next().expect("expected assist").label, "Replace with match");
}

#[test]
fn assist_filter_works() {
    let before = "
    pub fn test_some_range(a: int) -> bool {
        if let 2..6 = $05$0 {
            true
        } else {
            false
        }
    }";
    let (range, before) = extract_range(before);
    let (db, file_id) = with_single_file(&before);
    let frange = FileRange { file_id, range };

    {
        let mut cfg = TEST_CONFIG;
        cfg.allowed = Some(vec![AssistKind::Refactor]);

        let assists = Assist::get(&db, &cfg, false, frange);
        let mut assists = assists.iter();

        assert_eq!(assists.next().expect("expected assist").label, "Extract into variable");
        assert_eq!(assists.next().expect("expected assist").label, "Replace with match");
    }

    {
        let mut cfg = TEST_CONFIG;
        cfg.allowed = Some(vec![AssistKind::RefactorExtract]);
        let assists = Assist::get(&db, &cfg, false, frange);
        assert_eq!(assists.len(), 1);

        let mut assists = assists.iter();
        assert_eq!(assists.next().expect("expected assist").label, "Extract into variable");
    }

    {
        let mut cfg = TEST_CONFIG;
        cfg.allowed = Some(vec![AssistKind::QuickFix]);
        let assists = Assist::get(&db, &cfg, false, frange);
        assert!(assists.is_empty(), "All asserts but quickfixes should be filtered out");
    }
}
