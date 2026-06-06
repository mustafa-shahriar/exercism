defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    calc_distance(strand1, strand2, 0)
  end

  defp calc_distance([], [], distance), do: {:ok, distance}
  defp calc_distance([], _, _), do: {:error, "strands must be of equal length"}
  defp calc_distance(_, [], _), do: {:error, "strands must be of equal length"}

  defp calc_distance([a | strand1], [b | strand2], distance) do
    if a == b do
      calc_distance(strand1, strand2, distance)
    else
      calc_distance(strand1, strand2, distance + 1)
    end
  end
end
