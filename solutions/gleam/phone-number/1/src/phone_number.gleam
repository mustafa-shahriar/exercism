import gleam/int
import gleam/list
import gleam/string

pub fn clean(input: String) -> Result(String, String) {
  let has_letter = contains_letter(input)
  let has_punctuations = contains_punctuations(input)
  let input = clear_input(input)
  let input_len = string.length(input)
  case input {
    _ if has_letter -> Error("letters not permitted")
    _ if has_punctuations -> Error("punctuations not permitted")
    _ if input_len > 11 -> Error("must not be greater than 11 digits")
    _ if input_len < 10 -> Error("must not be fewer than 10 digits")
    _ if input_len == 11 ->
      case string.first(input) {
        Ok("1") -> string.drop_left(input, 1) |> validate_ten_digits()
        _ -> Error("11 digits must start with 1")
      }
    _ -> validate_ten_digits(input)
  }
}

fn validate_ten_digits(input: String) -> Result(String, String) {
  case string.first(input) {
    Ok("0") -> Error("area code cannot start with zero")
    Ok("1") -> Error("area code cannot start with one")
    _ ->
      case string.drop_left(input, 3) |> string.first {
        Ok("0") -> Error("exchange code cannot start with zero")
        Ok("1") -> Error("exchange code cannot start with one")
        _ -> Ok(input)
      }
  }
}

fn clear_input(input: String) -> String {
  input
  |> string.to_graphemes()
  |> list.filter(fn(digit) {
    case int.parse(digit) {
      Ok(_) -> True
      _ -> False
    }
  })
  |> string.join("")
}

fn contains_punctuations(input: String) -> Bool {
  input
  |> string.lowercase()
  |> string.to_graphemes()
  |> list.any(fn(digit) {
    "@#$%^&*"
    |> string.to_graphemes()
    |> list.any(fn(letter) { letter == digit })
  })
}

fn contains_letter(input: String) -> Bool {
  input
  |> string.lowercase()
  |> string.to_graphemes()
  |> list.any(fn(digit) {
    "abcdefghigklmnopqrstuvwxyz"
    |> string.to_graphemes()
    |> list.any(fn(letter) { letter == digit })
  })
}
