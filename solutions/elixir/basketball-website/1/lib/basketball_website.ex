defmodule BasketballWebsite do
  def extract(data, []), do: data

  def extract(data, [key | rest]) do
    extracted_data = data[key]

    if extracted_data == nil do
      nil
    end

    extract(extracted_data, rest)
  end

  def extract_from_path(data, path) do
    extract(data, String.split(path, "."))
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
