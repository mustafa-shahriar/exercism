defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number.
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    len = length(digits)

    digits
    |> Enum.reduce(0, fn digit, acc -> acc + power(digit, len) end) == number
  end

  defp power(_, 0), do: 1

  defp power(x, n) do
    x * power(x, n - 1)
  end
end
