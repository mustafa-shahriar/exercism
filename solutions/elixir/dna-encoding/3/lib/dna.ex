defmodule DNA do
  def encode_nucleotide(code_point) do
    cond do
      code_point == ?A -> 0b0001
      code_point == ?C -> 0b0010
      code_point == ?G -> 0b0100
      code_point == ?T -> 0b1000
      code_point == 32 -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    cond do
      encoded_code == 0b0001 -> ?A
      encoded_code == 0b0010 -> ?C
      encoded_code == 0b0100 -> ?G
      encoded_code == 0b1000 -> ?T
      encoded_code == 0b0000 -> 32
    end
  end

  def encode(dna, encoded_dna \\ <<>>)

  def encode([], encoded_dna), do: encoded_dna

  def encode([dna | rest], encoded_dna) do
    encode(rest, <<encoded_dna::bitstring, encode_nucleotide(dna)::4>>)
  end

  defp reverse(list, result \\ [])

  defp reverse([], result), do: result

  defp reverse([head | tail], result) do
    reverse(tail, [head | result])
  end

  def decode(dna, decoded_dna \\ [])

  def decode(<<>>, decoded_dna), do: reverse(decoded_dna)

  def decode(<<dna::4, rest::bitstring>>, decoded_dna) do
    decode(rest, [decode_nucleotide(dna) | decoded_dna])
  end
end
