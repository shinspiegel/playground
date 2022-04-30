use std::io;

pub fn get() -> f32 {
  let mut input = String::new();

  println!("Please inform a value");

  io::stdin()
    .read_line(&mut input)
    .expect("Failed to read line");

  let value: f32 = input.trim().parse().expect("Invalid value");

  return value;
}
