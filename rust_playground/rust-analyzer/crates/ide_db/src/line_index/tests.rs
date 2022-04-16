use super::*;

#[test]
fn test_line_index() {
    let text = "hello\nworld";
    let index = LineIndex::new(text);
    assert_eq!(index.line_col(0.into()), LineCol { line: 0, col_utf16: 0 });
    assert_eq!(index.line_col(1.into()), LineCol { line: 0, col_utf16: 1 });
    assert_eq!(index.line_col(5.into()), LineCol { line: 0, col_utf16: 5 });
    assert_eq!(index.line_col(6.into()), LineCol { line: 1, col_utf16: 0 });
    assert_eq!(index.line_col(7.into()), LineCol { line: 1, col_utf16: 1 });
    assert_eq!(index.line_col(8.into()), LineCol { line: 1, col_utf16: 2 });
    assert_eq!(index.line_col(10.into()), LineCol { line: 1, col_utf16: 4 });
    assert_eq!(index.line_col(11.into()), LineCol { line: 1, col_utf16: 5 });
    assert_eq!(index.line_col(12.into()), LineCol { line: 1, col_utf16: 6 });

    let text = "\nhello\nworld";
    let index = LineIndex::new(text);
    assert_eq!(index.line_col(0.into()), LineCol { line: 0, col_utf16: 0 });
    assert_eq!(index.line_col(1.into()), LineCol { line: 1, col_utf16: 0 });
    assert_eq!(index.line_col(2.into()), LineCol { line: 1, col_utf16: 1 });
    assert_eq!(index.line_col(6.into()), LineCol { line: 1, col_utf16: 5 });
    assert_eq!(index.line_col(7.into()), LineCol { line: 2, col_utf16: 0 });
}

#[test]
fn test_char_len() {
    assert_eq!('メ'.len_utf8(), 3);
    assert_eq!('メ'.len_utf16(), 1);
}

#[test]
fn test_empty_index() {
    let col_index = LineIndex::new(
        "
const C: char = 'x';
",
    );
    assert_eq!(col_index.utf16_lines.len(), 0);
}

#[test]
fn test_single_char() {
    let col_index = LineIndex::new(
        "
const C: char = 'メ';
",
    );

    assert_eq!(col_index.utf16_lines.len(), 1);
    assert_eq!(col_index.utf16_lines[&1].len(), 1);
    assert_eq!(col_index.utf16_lines[&1][0], Utf16Char { start: 17.into(), end: 20.into() });

    // UTF-8 to UTF-16, no changes
    assert_eq!(col_index.utf8_to_utf16_col(1, 15.into()), 15);

    // UTF-8 to UTF-16
    assert_eq!(col_index.utf8_to_utf16_col(1, 22.into()), 20);

    // UTF-16 to UTF-8, no changes
    assert_eq!(col_index.utf16_to_utf8_col(1, 15), TextSize::from(15));

    // UTF-16 to UTF-8
    assert_eq!(col_index.utf16_to_utf8_col(1, 19), TextSize::from(21));

    let col_index = LineIndex::new("a𐐏b");
    assert_eq!(col_index.utf16_to_utf8_col(0, 3), TextSize::from(5));
}

#[test]
fn test_string() {
    let col_index = LineIndex::new(
        "
const C: char = \"メ メ\";
",
    );

    assert_eq!(col_index.utf16_lines.len(), 1);
    assert_eq!(col_index.utf16_lines[&1].len(), 2);
    assert_eq!(col_index.utf16_lines[&1][0], Utf16Char { start: 17.into(), end: 20.into() });
    assert_eq!(col_index.utf16_lines[&1][1], Utf16Char { start: 21.into(), end: 24.into() });

    // UTF-8 to UTF-16
    assert_eq!(col_index.utf8_to_utf16_col(1, 15.into()), 15);

    assert_eq!(col_index.utf8_to_utf16_col(1, 21.into()), 19);
    assert_eq!(col_index.utf8_to_utf16_col(1, 25.into()), 21);

    assert!(col_index.utf8_to_utf16_col(2, 15.into()) == 15);

    // UTF-16 to UTF-8
    assert_eq!(col_index.utf16_to_utf8_col(1, 15), TextSize::from(15));

    // メ UTF-8: 0xE3 0x83 0xA1, UTF-16: 0x30E1
    assert_eq!(col_index.utf16_to_utf8_col(1, 17), TextSize::from(17)); // first メ at 17..20
    assert_eq!(col_index.utf16_to_utf8_col(1, 18), TextSize::from(20)); // space
    assert_eq!(col_index.utf16_to_utf8_col(1, 19), TextSize::from(21)); // second メ at 21..24

    assert_eq!(col_index.utf16_to_utf8_col(2, 15), TextSize::from(15));
}

#[test]
fn test_splitlines() {
    fn r(lo: u32, hi: u32) -> TextRange {
        TextRange::new(lo.into(), hi.into())
    }

    let text = "a\nbb\nccc\n";
    let line_index = LineIndex::new(text);

    let actual = line_index.lines(r(0, 9)).collect::<Vec<_>>();
    let expected = vec![r(0, 2), r(2, 5), r(5, 9)];
    assert_eq!(actual, expected);

    let text = "";
    let line_index = LineIndex::new(text);

    let actual = line_index.lines(r(0, 0)).collect::<Vec<_>>();
    let expected = vec![];
    assert_eq!(actual, expected);

    let text = "\n";
    let line_index = LineIndex::new(text);

    let actual = line_index.lines(r(0, 1)).collect::<Vec<_>>();
    let expected = vec![r(0, 1)];
    assert_eq!(actual, expected)
}
