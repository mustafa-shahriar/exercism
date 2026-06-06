defmodule GuessingGame do
  def compare(secret_number, guess \\ :no_guess)
  def compare(secret_number, guess) when secret_number == guess do
    "Correct"
  end
  def compare(secret_number, guess) when guess - secret_number >= 2 do
    "Too high"
  end
  def compare(secret_number, guess) when guess - secret_number <= -2 do
    "Too low"
  end
  def compare(secret_number, guess) when guess - secret_number |> abs() == 1 do
    "So close"
  end
  def compare(_secret_number, :no_guess) do
    "Make a guess"
  end
end
