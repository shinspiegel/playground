use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();

    for i in &args {
        println!("{}", i);
    }

    println!("{:?}", args);

    
}

