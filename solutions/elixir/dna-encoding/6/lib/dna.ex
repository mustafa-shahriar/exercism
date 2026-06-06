defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      ?\s -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> ?\s
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
