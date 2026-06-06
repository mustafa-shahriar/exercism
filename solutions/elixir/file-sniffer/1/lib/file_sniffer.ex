defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(file_binary) when byte_size(file_binary) >= 2 and is_binary(file_binary) do
    <<signature::binary-size(2), _::binary>> = file_binary

    cond do
      signature == <<0x7F, 0x45>> and byte_size(file_binary) >= 4 -> "application/octet-stream"
      signature == <<0x42, 0x4D>> and byte_size(file_binary) >= 2 -> "image/bmp"
      signature == <<0x89, 0x50>> and byte_size(file_binary) >= 8 -> "image/png"
      signature == <<0xFF, 0xD8>> and byte_size(file_binary) >= 4 -> "image/jpg"
      signature == <<0x47, 0x49>> and byte_size(file_binary) >= 4 -> "image/gif"
      true -> nil
    end
  end

  def type_from_binary(_file_binary) do
    nil
  end

  defp extension_from_type(type) do
    case type do
      "application/octet-stream" -> "exe"
      "image/bmp" -> "bmp"
      "image/png" -> "png"
      "image/jpg" -> "jpg"
      "image/gif" -> "gif"
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    type = file_binary |> type_from_binary()
    ext = extension_from_type(type)

    if ext == extension do
      {:ok, type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
