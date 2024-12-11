defmodule Problem4 do
  def run1(input) do
    grid = input_to_grid(input)
    Enum.map([:N, :NE, :E, :SE, :S, :SW, :W, :NW], fn direction ->
      Enum.map(grid, fn {location, _} -> search(grid, location, direction, ["X", "M", "A", "S"]) end)
      |> Enum.count(& &1)
    end)
    |> Enum.sum()
  end

  def run2(input) do
    grid = input_to_grid(input)
    Enum.map(grid, fn {location, _} -> is_x_mas(grid, location) end)
    |> Enum.count(& &1)
  end

  def input_to_grid(input) do
    input
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

  def search(_grid, _location, _direction, []) do
    true
  end

  def search(grid, location, direction, [stack_head | stack_tail]) do
    case Map.get(grid, location) do
      nil -> false
      ^stack_head -> search(grid, next_position(location, direction), direction, stack_tail)
      _ -> false
    end
  end

  def next_position({x, y}, direction) do
    case direction do
      :N -> {x, y - 1}
      :NE -> {x + 1, y - 1}
      :E -> {x + 1, y}
      :SE -> {x + 1, y + 1}
      :S -> {x, y + 1}
      :SW -> {x - 1, y + 1}
      :W -> {x - 1, y}
      :NW -> {x - 1, y - 1}
      _ -> raise "Invalid direction: #{inspect(direction)}"
    end
  end

  def is_x_mas(grid, location) do
    case Map.get(grid, location) do
      "A" -> check_corners(grid, location)
      _ -> false
    end

  end

  def check_corners(grid, location) do
    corner_values = Enum.map(cross_locations(location), fn loc -> Map.get(grid, loc, '_') end)
    |> Enum.join()
    Enum.member?(["MMSS", "SSMM", "SMMS", "MSSM"], corner_values)
  end

  def cross_locations({x,y}) do
    [{x - 1, y - 1}, {x - 1, y + 1}, {x + 1, y + 1}, {x + 1, y - 1}]
  end

end
