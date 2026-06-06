defmodule NameBadge do
  def print(id, name, department) do
    cond do
      id == nil and department == nil -> "#{name} - OWNER"
      department == nil -> "[#{id}] - #{name} - OWNER"
      id == nil -> "#{name} - #{String.upcase(department)}"
      true -> "[#{id}] - #{name} - #{String.upcase(department)}"
    end
  end
end
