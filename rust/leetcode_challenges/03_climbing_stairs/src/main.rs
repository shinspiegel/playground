fn solution(n: i32) -> i32 {
    if n <= 0 {
        return 1;
    }

    let mut ways: i32 = 0;

    for i in 0..=(n / 2) {
        ways += combination(n - i, i);
    }

    return ways;
}

fn combination(n: i32, k: i32) -> i32 {
    return factorial(n) / (factorial(k) * factorial(n - k));
}

fn factorial(n: i32) -> i32 {
    if n == 0 {
        return 1;
    }
    return n * factorial(n - 1);
}

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn one() {
        assert_eq!(crate::solution(1), 1);
    }

    #[test]
    fn two() {
        assert_eq!(crate::solution(2), 2);
    }

    #[test]
    fn three() {
        assert_eq!(crate::solution(3), 3);
    }

    #[test]
    fn four() {
        assert_eq!(crate::solution(4), 5);
    }

    #[test]
    fn five() {
        assert_eq!(crate::solution(5), 8);
    }
}
