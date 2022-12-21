fn two_sum(numbers: Vec<i32>, target: i32) -> Vec<i32> {
    let mut first: usize = 0;
    let mut second: usize = 1;

    loop {
        if numbers[first] + numbers[second] == target {
            break;
        }

        first += 1;
        second += 1;
    }

    let first: i32 = i32::try_from(first).expect("Failed to convert");
    let second: i32 = i32::try_from(second).expect("Failed to convert");

    return vec![first, second];
}

fn main() {}

#[cfg(test)]
mod tests {
    #[test]
    fn first() {
        assert_eq!(crate::two_sum(vec![2, 7, 11, 15], 9), vec![0, 1]);
    }

    #[test]
    fn second() {
        assert_eq!(crate::two_sum(vec![3, 2, 4], 6), vec![1, 2]);
    }

    #[test]
    fn third() {
        assert_eq!(crate::two_sum(vec![3, 3], 6), vec![0, 1]);
    }
}
