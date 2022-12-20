use crate::

fn main() {
    let mut t = TransationalLog::new_empty();

    t.append(String::from("One"));
    t.append(String::from("Two"));
    t.append(String::from("Three"));
    t.append(String::from("Four"));
    t.append(String::from("Five"));

    println!("{:#?}", t.pop().unwrap());
    println!("{:#?}", t.pop().unwrap());
    println!("{:#?}", t.pop().unwrap());
    println!("{:#?}", t.pop().unwrap());
    println!("{:#?}", t.pop().unwrap());
}
