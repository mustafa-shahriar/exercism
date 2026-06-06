import gleam/list
import gleam/string

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let sorted_base =
    word
    |> string.lowercase()
    |> string.to_graphemes()
    |> list.sort(by: string.compare)
    |> string.join("")
  candidates
  |> list.filter(fn(candidate) {
    let sorted_candidate =
      candidate
      |> string.lowercase()
      |> string.to_graphemes()
      |> list.sort(by: string.compare)
      |> string.join("")

    sorted_candidate == sorted_base
    && string.lowercase(candidate) != string.lowercase(word)
  })
}
