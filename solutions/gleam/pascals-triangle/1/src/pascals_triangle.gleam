import gleam/list

const first = [1]

const second = [1, 1]

pub fn rows(n: Int) -> List(List(Int)) {
  case n {
    0 -> []
    1 -> [first]
    2 -> [first, second]
    _ -> get_rows(3, n, [second, first])
  }
}

fn get_rows(start: Int, end: Int, rows: List(List(Int))) -> List(List(Int)) {
  let assert [previous_row, ..rest] = rows
  let row = [nex_row(previous_row), previous_row, ..rest]
  case start == end {
    True -> row |> list.reverse()
    False -> get_rows(start + 1, end, row)
  }
}

fn nex_row(previous_row: List(Int)) -> List(Int) {
  let #(_, row) =
    previous_row
    |> list.fold(#(0, []), fn(acc, number) {
      #(number, [acc.0 + number, ..acc.1])
    })
  [1, ..row]
}
