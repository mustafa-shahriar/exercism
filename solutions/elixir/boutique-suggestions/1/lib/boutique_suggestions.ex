defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100)

    for top <- tops,
        bottom <- bottoms,
        Map.get(top, :base_color, "a") != Map.get(bottom, :base_color, "b"),
        Map.get(top, :price, 0) + Map.get(bottom, :price, 0) <= max_price do
      {top, bottom}
    end
  end
end
