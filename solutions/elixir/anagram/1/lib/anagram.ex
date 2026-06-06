defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    sorted_base = base |> String.downcase() |> String.graphemes() |> Enum.sort() |> to_string()

    candidates
    |> Enum.filter(fn candidate ->
      sorted_candidate =
        candidate |> String.downcase() |> String.graphemes() |> Enum.sort() |> to_string()

      sorted_candidate == sorted_base and String.downcase(candidate) != String.downcase(base)
    end)
  end
end
