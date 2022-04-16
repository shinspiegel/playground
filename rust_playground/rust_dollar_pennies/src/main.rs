mod get_float;

fn main() {
    let original_value = get_float::get();
    let mut total_cents: i32 = (original_value * 100.0) as i32;

    let half_dolar = total_cents / 50;
    total_cents = total_cents - (half_dolar * 50);

    let quarter_coins = total_cents / 25;
    total_cents = total_cents - (quarter_coins * 25);

    let dime_coins = total_cents / 10;
    total_cents = total_cents - (dime_coins * 10);

    let nickel_coins = total_cents / 5;
    total_cents = total_cents - (nickel_coins * 5);

    let penny_coins = total_cents;

    let total_coins = half_dolar + quarter_coins + dime_coins + nickel_coins + penny_coins;

    println!(
        "You have {} coins.\nThey are half dolars: {}, quarter: {}, dimes: {}, nickel: {} and penny: {}",
        total_coins,
        half_dolar,
        quarter_coins,
        dime_coins,
        nickel_coins,
        penny_coins
    );
}
