import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  list.map(dna, encode_nucleotide)
  |> bitarray_from_list(<<>>)
}

fn bitarray_from_list(list: List(Int), bitarray: BitArray) -> BitArray {
  case list {
    [] -> bitarray
    [nucleotide, ..rest] ->
      bitarray_from_list(rest, <<bitarray:bits, nucleotide:2>>)
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  case list_from_bitarray([], dna) {
    Error(Nil) -> Error(Nil)
    Ok(bit_array_list) ->
      bit_array_list
      |> Ok()
  }
}

fn list_from_bitarray(
  nucleo_list: List(Nucleotide),
  bitarray: BitArray,
) -> Result(List(Nucleotide), Nil) {
  case bitarray {
    <<nucleotide:2>> ->
      [result.unwrap(decode_nucleotide(nucleotide), Adenine), ..nucleo_list]
      |> list.reverse()
      |> Ok()
    <<nucleotide:2, rest:bits>> ->
      [result.unwrap(decode_nucleotide(nucleotide), Adenine), ..nucleo_list]
      |> list_from_bitarray(rest)
    _ -> Error(Nil)
  }
}
