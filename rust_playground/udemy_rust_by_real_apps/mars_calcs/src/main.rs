use std::io;

fn main() {
    println!("Enter your weight (kg):");

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();

    let weight: f32 = input.trim().parse().unwrap();
    let weight_on_mars = calculate_weigh(weight);

    println!("Weight on mars: {}kgs", weight_on_mars);
}

fn calculate_weigh(weight: f32) -> f32 {
    return (weight / 9.81) * 3.711;
}
