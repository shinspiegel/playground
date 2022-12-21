fn solution(s: &String) -> bool {
    let mut pending: Vec<char> = Vec::new();

    for c in s.chars() {
        if vec!['(', '[', '{'].contains(&c) {
            pending.push(c);
        }

        if vec![']', ')', '}'].contains(&c) {
            let last = pending.pop().expect("No item to remove from the list");
            if last != '[' && c == ']' {
                return false;
            }

            if last != '(' && c == ')' {
                return false;
            }

            if last != '{' && c == '}' {
                return false;
            }
        }
    }

    if pending.len() > 0 {
        return false;
    }

    return true;
}

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn one() {
        assert_eq!(crate::solution(&String::from("()")), true);
    }

    #[test]
    fn two() {
        assert_eq!(crate::solution(&String::from("()[]{}")), true);
    }

    #[test]
    fn three() {
        assert_eq!(crate::solution(&String::from("(]")), false);
    }

    #[test]
    fn four() {
        assert_eq!(crate::solution(&String::from("([)]")), false);
    }
}
