import gleam/list

pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [day, ..] -> day
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [day, ..days] -> [day + 1, ..days]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  list.any(days, fn(day) { day == 0 })
}

pub fn total(days: List(Int)) -> Int {
  case list.reduce(days, fn(acc, day) { acc + day }) {
    Ok(result) -> result
    _ -> 0
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  list.count(days, fn(day) { day > 4 })
}
