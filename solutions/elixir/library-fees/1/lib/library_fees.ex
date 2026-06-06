defmodule LibraryFees do
  def datetime_from_string(string) do
    {_, time} = NaiveDateTime.from_iso8601(string)
    time
  end

  def before_noon?(datetime) do
    %NaiveDateTime{hour: hour} = datetime
    hour < 12
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)

    if Date.compare(planned_return_date, actual_return_date) == :gt do
      0
    else
      actual_return_date
      |> Date.range(planned_return_date)
      |> Enum.count()
      |> (&(&1 - 1)).()
    end
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> (&(&1 == 1)).()
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)
    last_return_date = return_date(checkout_datetime)

    late_days = days_late(last_return_date, return_datetime)

    if monday?(return_datetime) do
      (late_days * rate / 2) |> floor()
    else
      late_days * rate
    end
  end
end
