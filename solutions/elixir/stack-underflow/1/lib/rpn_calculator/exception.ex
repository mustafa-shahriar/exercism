defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      cond do
        is_binary(value) == true ->
          %StackUnderflowError{message: "stack underflow occurred, context: " <> value}

        true ->
          %StackUnderflowError{}
      end
    end
  end

  def divide([]) do
    raise StackUnderflowError, "when dividing"
  end

  def divide([_ | []]) do
    raise StackUnderflowError, "when dividing"
  end

  def divide([0 | _]) do
    raise DivisionByZeroError
  end

  def divide([divisor, dividend]) do
    dividend / divisor
  end
end
