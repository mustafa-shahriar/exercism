defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1[:price])
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1[:price] == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      if String.contains?(item[:name], old_word) do
        Map.put(item, :name, String.replace(item[:name], old_word, new_word))
      else
        item
      end
    end)
  end

  def increase_quantity(item, count) do
    quantity = item[:quantity_by_size] |> Map.new(fn {key, value} -> {key, value + count} end)
    Map.put(item, :quantity_by_size, quantity)
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_, value}, acc -> value + acc end)
  end
end
