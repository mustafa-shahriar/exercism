defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    result =
      [3, 5, 7]
      |> Enum.reduce("", fn divisor, acc ->
        if rem(number, divisor) == 0 do
          case divisor do
            3 -> acc <> "Pling"
            5 -> acc <> "Plang"
            7 -> acc <> "Plong"
          end
        else
          acc
        end
      end)

    case result do
      "" -> Integer.to_string(number)
      _ -> result
    end
  end
end
