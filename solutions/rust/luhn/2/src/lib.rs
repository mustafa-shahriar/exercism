/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let chars: Vec<char> = code.chars().filter(|c| !c.is_whitespace()).collect();
    if chars.len() <= 1 {
        return false;
    }

    let mut sum = 0;

    let mut i: isize = chars.len() as isize - 2;
    while i >= 0 {
        match chars[i as usize].to_digit(10) {
            None => return false,
            Some(n) => {
                let n = n * 2;
                if n > 9 { sum += n - 9 } else { sum += n }
            }
        }
        i -= 2;
    }

    let mut i: isize = chars.len() as isize - 1;
    while i >= 0 {
        match chars[i as usize].to_digit(10) {
            None => return false,
            Some(n) => sum += n,
        }
        i -= 2;
    }

    sum % 10 == 0
}
