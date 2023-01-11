fn sum_multiple_3_5(number: i32) -> i32 {
    let mut sum: i32 = 0;

    if number <= 0 {
        return 0;
    }

    for n in 0..number {
        if n % 3 == 0 || n % 5 == 0 {
            sum += n;
        }
    }

    return sum;
}

fn main() {}

#[cfg(test)]
mod tests {
    #[test]
    fn one() {
        assert_eq!(crate::sum_multiple_3_5(-1), 0);
        assert_eq!(crate::sum_multiple_3_5(0), 0);
        assert_eq!(crate::sum_multiple_3_5(1), 0);
        assert_eq!(crate::sum_multiple_3_5(2), 0);
        assert_eq!(crate::sum_multiple_3_5(3), 0);
        assert_eq!(crate::sum_multiple_3_5(4), 3);
        assert_eq!(crate::sum_multiple_3_5(5), 3);
        assert_eq!(crate::sum_multiple_3_5(6), 8);
        assert_eq!(crate::sum_multiple_3_5(10), 23);
        assert_eq!(crate::sum_multiple_3_5(20), 78);
        assert_eq!(crate::sum_multiple_3_5(100), 2318);
        assert_eq!(crate::sum_multiple_3_5(200), 9168);
        assert_eq!(crate::sum_multiple_3_5(200), 9168);
    }
}
