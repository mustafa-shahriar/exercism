defmodule Secrets do
  def secret_add(secret) do
    &(&1 + secret)
  end

  def secret_subtract(secret) do
    &(&1 - secret)
  end

  def secret_multiply(secret) do
    &(&1 * secret)
  end

  def secret_divide(secret) do
    fn number ->
      (number / secret) |> floor()
    end
  end

  def secret_and(secret) do
    fn number ->
      Bitwise.band(number, secret)
    end
  end

  def secret_xor(secret) do
    fn number ->
      Bitwise.bxor(number, secret)
    end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn number ->
      secret_function1.(number) |> secret_function2.()
    end
  end
end
