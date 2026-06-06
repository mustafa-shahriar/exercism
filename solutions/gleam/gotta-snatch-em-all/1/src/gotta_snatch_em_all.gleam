import gleam/list
import gleam/result
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  case set.contains(collection, card) {
    True -> #(True, collection)
    False -> #(False, set.insert(collection, card))
  }
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let possible = set.contains(collection, my_card)
  let worth = !set.contains(collection, their_card)
  #(
    possible && worth,
    collection |> set.delete(my_card) |> set.insert(their_card),
  )
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  collections
  |> list.reduce(fn(a, b) { set.intersection(a, b) })
  |> result.unwrap(set.new())
  |> set.to_list()
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  collections
  |> list.reduce(fn(a, b) { set.union(a, b) })
  |> result.unwrap(set.new())
  |> set.size()
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(collection, fn(card) { string.starts_with(card, "Shiny ") })
}
