defmodule Problem8 do
  alias Utils.Grid2D

  def run1(input) do
    grid = Grid2D.to_map(input)

    Map.keys(grid)
    |> Enum.filter(fn p -> is_antenna?(grid, p) end)
    |> combinations_of_two()
    |> Enum.reduce(MapSet.new(), fn {p1, p2}, acc ->
      if(same_frequency?(grid, p1, p2)) do
        MapSet.union(acc, MapSet.new(antinodes_for_positions(p1, p2)))
      else
        acc
      end
    end)
    |> MapSet.to_list()
    |> Enum.filter(fn p -> in_grid?(grid, p) end)
    |> Enum.count()
  end

  def run2(input) do
    grid = Grid2D.to_map(input)
    x_max = grid |> Map.keys() |> Enum.map(fn {x, _} -> x end) |> Enum.max()
    y_max = grid |> Map.keys() |> Enum.map(fn {_, y} -> y end) |> Enum.max()

    Map.keys(grid)
    |> Enum.filter(fn p -> is_antenna?(grid, p) end)
    |> combinations_of_two()
    |> Enum.reduce(MapSet.new(), fn {p1, p2}, acc ->
      if(same_frequency?(grid, p1, p2)) do
        MapSet.union(acc, MapSet.new(harmonic_antinodes_for_positions({x_max, y_max}, p1, p2)))
      else
        acc
      end
    end)
    |> MapSet.to_list()
    |> Enum.filter(fn p -> in_grid?(grid, p) end)
    |> Enum.count()
  end

  def antinodes_for_positions({x1, y1}, {x2, y2}) do
    yd = y2 - y1
    xd = x2 - x1

    if(yd != 0 or xd != 0) do
      [{x1 - xd, y1 - yd}, {x2 + xd, y2 + yd}]
    else
      []
    end
  end

  def harmonic_antinodes_for_positions({x_max, y_max}, {x1, y1}, {x2, y2}) do
    if(x1 == x2 and y1 == y2) do
      []
    else
      harmonic_antinodes_for_positions({x_max, y_max}, {x1, y1}, {x2, y2}, 0)
    end
  end

  def harmonic_antinodes_for_positions({x_max, y_max}, {x1, y1}, {x2, y2}, n) do
    yd = n * (y2 - y1)
    xd = n * (x2 - x1)

    candidates = [{x1 - xd, y1 - yd}, {x2 + xd, y2 + yd}]

    if Enum.any?(candidates, fn pos -> in_grid?({x_max, y_max}, pos) end) do
      Enum.concat(candidates, harmonic_antinodes_for_positions({x_max, y_max}, {x1, y1}, {x2, y2}, n + 1))
    else
      []
    end
  end

  def same_frequency?(grid, {x1, y1}, {x2, y2}) do
    v1 = Map.get(grid, {x1, y1})
    v2 = Map.get(grid, {x2, y2})
    v1 == v2
  end

  def combinations_of_two(list) do
    Enum.flat_map(list, fn x ->
      Enum.map(list, fn y ->
        {x, y}
      end)
    end)
    |> Enum.filter(fn {x, y} -> x != y end)
  end

  def is_antenna?(grid, {x, y}) do
    Map.get(grid, {x, y}) != "."
  end


  def in_grid?({x_max, y_max}, {px, py}) do
    px >= 0 and px <= x_max and py >= 0 and py <= y_max
  end

  def in_grid?(grid, {px, py}) do
    x_max = grid |> Map.keys() |> Enum.map(fn {x, _} -> x end) |> Enum.max()
    y_max = grid |> Map.keys() |> Enum.map(fn {_, y} -> y end) |> Enum.max()
    px >= 0 and px <= x_max and py >= 0 and py <= y_max
  end


end
