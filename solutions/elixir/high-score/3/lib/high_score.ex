defmodule HighScore do
  @default_score 0
  def new, do: %{}

  def add_player(scores, name, score\\@default_score) do
    %{name => score} |> Map.merge(scores)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) when is_binary(name) do
    if Map.has_key?(scores, name) do
      Map.replace(scores, name, @default_score)
    else
      add_player(scores, name)
    end
  end

  def reset_score(scores, []), do: scores

  def reset_score(scores, [name| rest])  do
    if Map.has_key?(scores, name) do
      Map.replace(scores, name, @default_score) |> reset_score(rest)
    else
      add_player(scores, name)
    end
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, fn previous_score -> previous_score + score end)
  end

  def get_players(scores) do
    Map.to_list(scores)
    |> Enum.map(fn {name, _} -> name end)
  end
end
