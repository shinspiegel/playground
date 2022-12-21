fn solution(numbers: Vec<i32>) -> i32 {
    return 0;
}

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn one() {
        assert_eq!(crate::solution(vec![2, 2, 1]), 1);
    }

    #[test]
    fn two() {
        assert_eq!(crate::solution(vec![4, 1, 2, 1, 2]), 4);
    }

    #[test]
    fn three() {
        assert_eq!(crate::solution(vec![1]), 1);
    }
}
