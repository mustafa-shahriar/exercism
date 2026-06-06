use std::fmt::{Display, Formatter, Result};

pub struct Roman {
    n: String,
}

impl Display for Roman {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        write!(f, "{}", self.n)
    }
}

impl From<u32> for Roman {
    fn from(num: u32) -> Self {
        Roman { n: convert(num) }
    }
}

fn convert(number: u32) -> String {
    match number {
        n if n >= 1000 => "M".to_string() + &convert(number - 1000),
        n if n >= 900 => "CM".to_string() + &convert(number - 900),
        n if n >= 500 => "D".to_string() + &convert(number - 500),
        n if n >= 400 => "CD".to_string() + &convert(number - 400),
        n if n >= 100 => "C".to_string() + &convert(number - 100),
        n if n >= 90 => "XC".to_string() + &convert(number - 90),
        n if n >= 50 => "L".to_string() + &convert(number - 50),
        n if n >= 40 => "XL".to_string() + &convert(number - 40),
        n if n >= 10 => "X".to_string() + &convert(number - 10),
        n if n >= 9 => "IX".to_string() + &convert(number - 9),
        n if n >= 5 => "V".to_string() + &convert(number - 5),
        n if n >= 4 => "IV".to_string() + &convert(number - 4),
        n if n >= 1 => "I".to_string() + &convert(number - 1),
        _ => "".to_string(),
    }
}
