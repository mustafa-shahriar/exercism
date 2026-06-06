defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    nth_prime(2, 1, count)
  end

  defp nth_prime(current, target, target), do: current

  defp nth_prime(current, count, target) do
    (current + 1)
    |> next_prime()
    |> nth_prime(count + 1, target)
  end

  defp next_prime(number) do
    if is_prime?(number) do
      number
    else
      next_prime(number + 1)
    end
  end

  defp is_prime?(2), do: true
  defp is_prime?(number) when number <= 1, do: false

  defp is_prime?(number) do
    not Enum.any?(2..(:math.sqrt(number) |> ceil()), fn x -> rem(number, x) == 0 end)
  end
end
