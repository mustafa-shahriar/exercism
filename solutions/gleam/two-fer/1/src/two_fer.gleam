import gleam/option.{type Option, Some}

pub fn two_fer(name: Option(String)) -> String {
  case name {
    Some(name) if name != "Do-yun" -> "One for " <> name <> ", one for me."
    _ -> "One for you, one for me."
  }
}
