defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    {_, count} =
      sentence
      |> String.downcase()
      |> String.to_charlist()
      |> Stream.filter(fn letter -> letter in ?a..?z end)
      |> Enum.reduce({%{}, 0}, fn letter, {map, count} ->
        case Map.has_key?(map, letter) do
          true -> {map, count}
          false -> {Map.put(map, letter, 1), count + 1}
        end
      end)

    count == 26
  end
end
