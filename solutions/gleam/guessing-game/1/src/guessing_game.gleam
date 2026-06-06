pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    41 -> "So close"
    43 -> "So close"
    guess if guess < 41 -> "Too low"
    _ -> "Too high"
  }
}
