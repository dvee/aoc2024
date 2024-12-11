defmodule Utils.Grid2D do
  def to_map(string) do
    string
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, j}, acc ->
        Map.put(acc, {j, i}, char)
      end)
    end)
  end
end
