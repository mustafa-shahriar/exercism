import gleam/string

pub opaque type TreasureChest(a) {
  TreasureChest(password: String, treasure: a)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case string.length(password) {
    len if len < 8 -> Error("Password must be at least 8 characters long")
    _ -> TreasureChest(password, contents) |> Ok()
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case chest.password == password {
    True -> chest.treasure |> Ok()
    False -> Error("Incorrect password")
  }
}
