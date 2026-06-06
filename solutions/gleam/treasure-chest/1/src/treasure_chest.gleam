pub type TreasureChest(t) {
  TreasureChest(password: String, treasure: t)
}

// Please define the UnlockResult generic custom type
pub type UnlockResult(t) {
  Unlocked(t)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest {
    TreasureChest(pass, treasure) if pass == password -> Unlocked(treasure)
    _ -> WrongPassword
  }
}
