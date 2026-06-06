defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:battery_percentage, :distance_driven_in_meters, :nickname]

  def new() do
    %RemoteControlCar{battery_percentage: 100, distance_driven_in_meters: 0, nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{battery_percentage: 100, distance_driven_in_meters: 0, nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance_driven_in_meters}) do
    "#{distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery_percentage}) do
    case battery_percentage do
      0 -> "Battery empty"
      _ -> "Battery at #{battery_percentage}%"
    end
  end

  def drive(remote_car)
      when is_struct(remote_car, RemoteControlCar) and remote_car.battery_percentage == 0 do
    remote_car
  end

  def drive(remote_car) when is_struct(remote_car, RemoteControlCar) do
    case remote_car.battery_percentage do
      0 ->
        remote_car

      _ ->
        %{
          remote_car
          | battery_percentage: remote_car.battery_percentage - 1,
            distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
        }
    end
  end
end
