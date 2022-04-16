fn main() {
    println!("This is only here to not be empty");
}

fn find_odd(arr: Vec<i32>) -> i32 {
    let mut value = 0;
    let mut quantity = 0;

    for v in arr.iter() {
        let filtered = arr.iter().filter(|x| *x == v);
        let count = filtered.count();

        if count % 2 != 0 && count > quantity {
            value = *v;
            quantity = count;
        }
    }

    return value;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn basic_tests() {
        let array_test = vec![1, 1, 2, -2, 5, 2, 4, 4, -1, -2, 5];
        assert_eq!(find_odd(array_test), -1);
        let array_test = vec![20, 1, 1, 2, 2, 3, 3, 5, 5, 4, 20, 4, 5];
        assert_eq!(find_odd(array_test), 5);
        let array_test = vec![10];
        assert_eq!(find_odd(array_test), 10);
    }
}
