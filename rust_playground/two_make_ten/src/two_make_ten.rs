pub fn check(y: i32, x: i32) -> bool {
    if x == 10 || y == 10 {
        return true;
    }

    if x + y == 10 {
        return true;
    }

    return false;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn ten_sum() {
        let result = check(1,9);
        assert_eq!(result, true);
    }

    #[test]
    fn first_should_be_ten() {
        let result = check(10,9);
        assert_eq!(result, true);
    }

    #[test]
    fn second_should_be_ten() {
        let result = check(9,10);
        assert_eq!(result, true);
    }

    #[test]
    fn false_otherwise() {
        let result = check(1,1);
        assert_eq!(result, false);
    }
}
