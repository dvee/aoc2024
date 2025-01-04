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

  def find(map, value) do
    map
    |> Enum.find(fn {_, v} -> v == value end)
    |> case do
      {k, _} -> k
      nil -> nil
    end
  end

  def print(grid) do
    y_max = Enum.max(Enum.map(Map.keys(grid), &elem(&1, 1))) + 1
    x_max = Enum.max(Enum.map(Map.keys(grid), &elem(&1, 0))) + 1
    output = for _y <- 0..y_max - 1, do: for _x <- 0..x_max - 1, do: "."

    Enum.reduce(Map.keys(grid), output, fn {x, y}, acc ->
      List.replace_at(acc, y, List.replace_at(Enum.at(acc, y), x, Map.get(grid, {x, y})))
    end)
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join("\n")
    |> IO.puts()
  end

  def compass_neighbours({x, y}) do
    %{
      n: {x, y - 1},
      s: {x, y + 1},
      e: {x + 1, y},
      w: {x - 1, y},
      ne: {x + 1, y - 1},
      nw: {x - 1, y - 1},
      se: {x + 1, y + 1},
      sw: {x - 1, y + 1}
    }
  end

  def get(grid, {x, y}) do
    Map.get(grid, {x, y})
  end
end
