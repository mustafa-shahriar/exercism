defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(fn char ->
      case char do
      char when char in ?a..?z or char == ?_ -> [char]
      ?ä -> ~c'ae'
      ?ö -> ~c'oe'
      ?ü -> ~c'ue'
      ?ß -> ~c'ss'
      _c -> []
      end
    end)
  end
end
