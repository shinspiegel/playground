fn main() {
    println!("I'll use the test to check this one!");
}

fn how_many_seconds(hour: i32) -> i32 {
    return hour * 3600;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn assert_one() {
        let result = how_many_seconds(2);
        assert_eq!(result, 7200);
        let result = how_many_seconds(10);
        assert_eq!(result, 36000);
        let result = how_many_seconds(24);
        assert_eq!(result, 86400);
    }
}
