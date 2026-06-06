defmodule KitchenCalculator do
  def get_volume({_, volume}), do: volume

  def to_milliliter({unit, volume}) do
    cond do
      unit == :cup -> {:milliliter, 240*volume}
      unit == :fluid_ounce -> {:milliliter, 30*volume }
      unit == :teaspoon -> {:milliliter, 5*volume }
      unit == :tablespoon -> {:milliliter, 15*volume }
      unit == :milliliter -> {:milliliter, volume }
      true -> {unit, volume}
    end
  end


  def from_milliliter({_, volume}, to) do
    cond do
      to == :cup -> {to, volume/240}
      to == :fluid_ounce -> {to, volume/30 }
      to == :teaspoon -> {to, volume/5 }
      to == :tablespoon -> {to, volume/15 }
      to == :milliliter -> {to, volume }
    end
  end

  def convert({from, volume}, to) do
    to_milliliter({from, volume}) |> from_milliliter(to)
  end
end
