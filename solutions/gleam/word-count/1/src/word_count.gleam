import gleam/dict.{type Dict}
import gleam/option.{type Option, None, Some}
import gleam/regex.{type Match}
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  let assert Ok(re) = regex.from_string("[a-z0-9]+('[a-z-9]+)?")
  input
  |> string.lowercase
  |> regex.scan(re, _)
  |> count(dict.new())
}

fn count(words: List(Match), word_count: Dict(String, Int)) -> Dict(String, Int) {
  case words {
    [] -> word_count
    [first, ..rest] ->
      dict.upsert(word_count, first.content, increment)
      |> count(rest, _)
  }
}

fn increment(n: Option(Int)) -> Int {
  case n {
    Some(n) -> n + 1
    None -> 1
  }
}
