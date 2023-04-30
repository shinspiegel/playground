fn main() {
    let a = ShinCalendar.new()
}

pub struct ShinCalendar {
    epoch: i64,
}

impl ShinCalendar {
    pub fn new(val: Option<i64>) -> ShinCalendar {
        return ShinCalendar {
            epoch: 0,
        }
    }
} 


#[cfg(test)]
mod tests {
    #[test]
    fn first() {
        assert_eq!(0, 1)
    }
}
