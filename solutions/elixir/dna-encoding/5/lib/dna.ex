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

  defp encode_dna([], encoded_dna), do: encoded_dna

  defp encode_dna([dna | rest], encoded_dna) do
    encode_dna(rest, <<encoded_dna::bitstring, encode_nucleotide(dna)::4>>)
  end

  def encode(dna) do
    encode_dna(dna, <<>>)
  end

  defp reverse_dna_list([], result), do: result

  defp reverse_dna_list([head | tail], result) do
    reverse_dna_list(tail, [head | result])
  end

  defp decode_dna(<<>>, decoded_dna), do: reverse_dna_list(decoded_dna, [])

  defp decode_dna(<<dna::4, rest::bitstring>>, decoded_dna) do
    decode_dna(rest, [decode_nucleotide(dna) | decoded_dna])
  end

  def decode(dna) do
    decode_dna(dna, [])
  end
end
