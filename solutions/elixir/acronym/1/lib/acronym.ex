defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) when is_binary(string) do
    ~r/[ _-]+/
    |> Regex.split(string)
    |> Stream.map(fn item -> String.first(item) |> String.upcase() end)
    |> Enum.join()
  end
end
