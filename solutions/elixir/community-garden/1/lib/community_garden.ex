# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{id: 1, plots: []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1.plots)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      plot = %Plot{plot_id: state.id, registered_to: register_to}
      new_state = %{id: state.id + 1, plots: [plot | state.plots]}
      {plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    plots = Agent.get(pid, & &1.plots)
    plots = Enum.filter(plots, &(&1.plot_id != plot_id))
    Agent.update(pid, fn state -> %{state | plots: plots} end)
  end

  def get_registration(pid, plot_id) do
    pid
    |> Agent.get(& &1.plots)
    |> Enum.find({:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
  end
end
