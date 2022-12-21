fn solution(number: i32) -> i32 {
    let mut is_negative = false;

    if number < 0 {
        is_negative = true;
    }

    let mut number: String = number.to_string();

    if is_negative {
        is_negative = true;
        number.remove(0);
    }

    let number = number.chars().rev().collect::<String>();

    let mut number: i32 = number.parse().unwrap();

    if is_negative {
        number *= -1;
    }

    return number;
}

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn one() {
        assert_eq!(crate::solution(123), 321);
    }

    #[test]
    fn two() {
        assert_eq!(crate::solution(-123), -321);
    }

    #[test]
    fn three() {
        assert_eq!(crate::solution(120), 21);
    }
}
