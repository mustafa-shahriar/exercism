defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(wines, color, opts \\ [], result \\ [])

  def filter([], _color, _opts, result), do: Enum.reverse(result)

  def filter([{wine_color, wine} | rest], color, opts, result) do
    {_, wine_year, wine_country} = wine
    year = Keyword.get(opts, :year, wine_year)
    country = Keyword.get(opts, :country, wine_country)

    if wine_color == color and year == wine_year and country == wine_country do
      filter(rest, color, opts, [wine | result])
    else
      filter(rest, color, opts, result)
    end
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
