defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      Regex.match?(~r/^(?:[aeiou]|xr|yt)\w*/, word) ->
        "#{word}ay"

      Regex.match?(~r/^([^aeiou]*qu)/, word) ->
        Regex.replace(~r/^([^aeiou]*qu)(.*)/, word, fn _, qu_part, rest ->
          "#{rest}#{qu_part}ay"
        end)

      Regex.match?(~r/^([^aeiou]+)y/, word) ->
        Regex.replace(~r/^([^aeiou]+)(y.*)/, word, fn _, consonants, rest ->
          "#{rest}#{consonants}ay"
        end)

      Regex.match?(~r/^[^aeiou]+/, word) ->
        Regex.replace(~r/^([^aeiou]*)(.*)/, word, fn _, consonants, rest ->
          "#{rest}#{consonants}ay"
        end)

      true ->
        word
    end
  end
end
