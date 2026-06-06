defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    prefix = "NCC-"
    rand_int = :rand.uniform(9000) - 1 + 1000
    "#{prefix}#{rand_int}"
  end

  def random_stardate() do
    :rand.uniform() * 1000.0 + 41000.0
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> List.to_string()
  end
end
