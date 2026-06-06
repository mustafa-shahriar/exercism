defmodule TopSecret do
  def to_ast(string) do
    {:ok, macro} = Code.string_to_quoted(string)
    macro
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {isDef, _, [{:when, _, [{name, _, arity}, _]}, _]} ->
        if isDef == :defp or isDef == :def do
          case arity do
            nil -> {ast, ["" | acc]}
            _ -> {ast, [Atom.to_string(name) |> String.slice(0, length(arity)) | acc]}
          end
        else
          {ast, acc}
        end

      {isDef, _, [{name, _, arity}, _]} ->
        if isDef == :defp or isDef == :def do
          case arity do
            nil -> {ast, ["" | acc]}
            _ -> {ast, [Atom.to_string(name) |> String.slice(0, length(arity)) | acc]}
          end
        else
          {ast, acc}
        end

      _ ->
        {ast, acc}
    end
  end

  def decode_secret_message(string) do
    {_, acc} =
      string
      |> to_ast()
      |> Macro.prewalk([], fn node, acc ->
        decode_secret_message_part(node, acc)
      end)

    acc
    |> Enum.reverse()
    |> Enum.join()
  end
end
