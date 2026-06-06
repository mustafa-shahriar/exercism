defmodule Newsletter do
  def read_emails(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter([], _pid, _send_fun), do: :ok

  def send_newsletter([address | rest], pid, send_fun) do
    is_send? = send_fun.(address)

    if is_send? == :ok do
      log_sent_email(pid, address)
    end

    send_newsletter(rest, pid, send_fun)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log_file = open_log(log_path)

    emails_path
    |> read_emails()
    |> send_newsletter(log_file, send_fun)

    close_log(log_file)
  end
end
