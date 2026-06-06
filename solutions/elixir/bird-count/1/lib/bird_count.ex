defmodule BirdCount do

  def today([]) do
    nil
  end
  def today([head | _]) do
    head
  end

  def increment_day_count([]) do
    [1]
  end
  def increment_day_count([head | rest]) do
    [ head + 1 | rest]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | rest]) do
    head == 0 or has_day_without_birds?(rest)
  end

  def total([]), do: 0
  def total([head | rest]) do
    head + total(rest)
  end

  def busy_days([]), do: 0
  def busy_days([head| rest]) when head >= 5 do
    1 + busy_days(rest)
  end
  def busy_days([head| rest]) when head < 5 do
    busy_days(rest)
  end
end
