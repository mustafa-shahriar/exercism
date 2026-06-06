import gleam/list
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let sentence = string.lowercase(sentence)
  "abcdefghijklmnopqrstuvwxyz"
  |> string.to_graphemes()
  |> list.fold(True, fn(a, b) { a && string.contains(sentence, b) })
}
