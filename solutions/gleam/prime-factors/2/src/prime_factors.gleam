import gleam/list

pub fn factors(value: Int) -> List(Int) {
  case Nil {
    _ if value < 2 -> []
    _ -> get_factors(value, 2, [])
  }
}

fn get_factors(divident: Int, divisor: Int, factors: List(Int)) -> List(Int) {
  case divisor == divident {
    True -> [divisor, ..factors] |> list.reverse()
    False ->
      case divident % divisor == 0 {
        True -> get_factors(divident / divisor, divisor, [divisor, ..factors])
        False -> get_factors(divident, divisor + 1, factors)
      }
  }
}
