fn solution(coins: &Vec<i32>, amount: i32) -> i32 {
    let mut coins_used: Vec<i32> = Vec::new();
    let mut coins = coins.clone();
    let mut amount = amount;
    coins.sort_by(|a, b| b.cmp(a));

    for coin in coins.iter() {
        if amount / coin > 0 {
            let reduced_value = (amount / coin) * coin;
            let coins_amount = reduced_value / coin;
            amount -= reduced_value;
            coins_used.push(coins_amount)
        }
    }

    return coins_used.iter().sum();
}

fn main() {
    solution(&vec![1, 2, 5, 20], 11);
    solution(&vec![1], 3);
    solution(&vec![2, 10], 22);

    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn one() {
        assert_eq!(crate::solution(&vec![1, 2, 5], 11), 3);
    }

    #[test]
    fn two() {
        assert_eq!(crate::solution(&vec![1], 3), 3);
    }

    #[test]
    fn three() {
        assert_eq!(crate::solution(&vec![2, 10], 22), 3);
    }
}
