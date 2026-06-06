pub fn convert(number: Int) -> String {
  convert_number(number, "")
}

fn convert_number(number: Int, roman: String) -> String {
  case Nil {
    _ if number >= 1000 -> convert_number(number - 1000, roman <> "M")
    _ if number >= 900 -> convert_number(number - 900, roman <> "CM")
    _ if number >= 500 -> convert_number(number - 500, roman <> "D")
    _ if number >= 400 -> convert_number(number - 400, roman <> "CD")
    _ if number >= 100 -> convert_number(number - 100, roman <> "C")
    _ if number >= 90 -> convert_number(number - 90, roman <> "XC")
    _ if number >= 50 -> convert_number(number - 50, roman <> "L")
    _ if number >= 40 -> convert_number(number - 40, roman <> "XL")
    _ if number >= 10 -> convert_number(number - 10, roman <> "X")
    _ if number >= 9 -> convert_number(number - 9, roman <> "IX")
    _ if number >= 5 -> convert_number(number - 5, roman <> "V")
    _ if number >= 4 -> convert_number(number - 4, roman <> "IV")
    _ if number >= 1 -> convert_number(number - 1, roman <> "I")
    _ -> roman
  }
}
