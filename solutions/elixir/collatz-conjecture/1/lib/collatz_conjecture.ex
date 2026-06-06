defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input, step \\ 0)

  def calc(1, step) do
    step
  end

  def calc(input, step) when is_integer(input) and input > 1 and rem(input, 2) == 0 do
    calc((input / 2) |> floor(), step + 1)
  end

  def calc(input, step) when is_integer(input) and input > 1 do
    calc((3 * input + 1) |> floor(), step + 1)
  end
end
