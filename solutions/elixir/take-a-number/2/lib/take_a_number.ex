defmodule TakeANumber do
  defp receiver(state \\ 0) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        receiver(state)

      {:take_a_number, sender_pid} ->
        send(sender_pid, state + 1)
        receiver(state + 1)

      :stop ->
        :ok

      _ ->
        receiver(state)
    end
  end

  def start() do
    spawn(&receiver/0)
  end
end
