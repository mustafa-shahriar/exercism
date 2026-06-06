defmodule LogParser do
  def valid_line?(line) do
    ~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\]/
    |> Regex.match?(line)
  end

  def split_line(line) do
    String.split(line, ~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    ~r/end-of-line\d+/i
    |> Regex.replace(line, "")
  end

  def tag_with_user_name(line) do
    regex = ~r/User\s+([^\s]+)/u

    case Regex.run(regex, line) do
      [_, user_name] -> "[USER] #{user_name} " <> line
      _ -> line
    end
  end
end
