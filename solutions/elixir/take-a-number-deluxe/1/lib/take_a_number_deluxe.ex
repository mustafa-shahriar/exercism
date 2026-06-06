defmodule TakeANumberDeluxe do
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  @impl GenServer
  def init(init_arg) do
    with min_number <- Keyword.get(init_arg, :min_number),
         max_number <- Keyword.get(init_arg, :max_number),
         shutdown <- Keyword.get(init_arg, :auto_shutdown_timeout, :infinity),
         {:ok, state} <- TakeANumberDeluxe.State.new(min_number, max_number, shutdown) do
      {:ok, state, shutdown}
    else
      _ -> {:stop, :invalid_configuration}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  def handle_call(:queue_new_number, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    case TakeANumberDeluxe.State.new(
           state.min_number,
           state.max_number,
           state.auto_shutdown_timeout
         ) do
      {:ok, new_state} -> {:noreply, new_state, state.auto_shutdown_timeout}
      error -> {:noreply, error, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_info(:timeout, _state) do
    exit(:normal)
  end

  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
