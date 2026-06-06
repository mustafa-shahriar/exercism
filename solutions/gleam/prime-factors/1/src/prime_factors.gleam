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
        False -> get_factors(divident, next_prime(divisor + 1), factors)
      }
  }
}

fn next_prime(n: Int) -> Int {
  case is_prime(n) {
    True -> n
    False -> next_prime(n + 1)
  }
}

fn is_prime(n: Int) -> Bool {
  case n {
    2 -> True
    _ -> calc_is_prime(n, 2)
  }
}

fn calc_is_prime(n: Int, divider: Int) -> Bool {
  case divider * divider > n {
    True -> True
    False -> n % divider != 0 && calc_is_prime(n, divider + 1)
  }
}
