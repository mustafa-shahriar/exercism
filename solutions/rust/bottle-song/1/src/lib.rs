pub fn recite(start_bottles: u32, take_down: u32) -> String {
    let mut s = String::new();
    let mut start = start_bottles;
    for _ in 0..take_down {
        s += "\n\n";
        s += nth(start).as_ref();
        start -= 1;
    }
    s
}

fn nth(n: u32) -> String {
    let first = number_word(n);
    let second = number_word(n - 1).to_lowercase();
    let b1 = if n > 1 { "bottles" } else { "bottle" };
    let b2 = if n - 1 == 1 { "bottle" } else { "bottles" };
    format!(
        "{first} green {b1} hanging on the wall,\n\
         {first} green {b1} hanging on the wall,\n\
         And if one green bottle should accidentally fall,\n\
         There'll be {second} green {b2} hanging on the wall.",
    )
}

fn number_word(n: u32) -> String {
    let s = match n {
        10 => "Ten",
        9 => "Nine",
        8 => "Eight",
        7 => "Seven",
        6 => "Six",
        5 => "Five",
        4 => "Four",
        3 => "Three",
        2 => "Two",
        1 => "One",
        0 => "No",
        _ => "",
    };
    s.to_string()
}
