defmodule Problem12 do
  alias Utils.Grid2D

  def run1(input) do
    grid = parse_input(input)

    regions(grid)
    |> Enum.map(&price/1)
    |> Enum.sum()
  end

  def run2(input) do
    grid = parse_input(input)

    regions(grid)
    |> Enum.map(&price2/1)
    |> Enum.sum()
  end

  def parse_input(input) do
    Grid2D.to_map(input)
  end

  def regions(grid) do
    Enum.reduce(Map.keys(grid), [], fn {x, y}, acc ->
      if Enum.any?(acc, fn region -> MapSet.member?(region, {x, y}) end) do
        acc
      else
        [region({x, y}, grid) | acc]
      end
    end)
  end

  def region({x, y}, grid) do
    region({x, y}, grid, MapSet.new())
  end

  def region({x, y}, grid, current_region) do
    current_region = MapSet.put(current_region, {x, y})
    current_value = Map.get(grid, {x, y})

    Enum.reduce(neighbours({x, y}), current_region, fn {nx, ny}, acc ->
      if MapSet.member?(acc, {nx, ny}) do
        acc
      else
        if Map.get(grid, {nx, ny}) == current_value do
          region({nx, ny}, grid, acc)
        else
          acc
        end
      end
    end)
  end

  def perimeter(region) do
    region_list = region |> MapSet.to_list()

    Enum.map(region_list, fn {x, y} ->
      Enum.filter(neighbours({x, y}), fn {nx, ny} ->
        not MapSet.member?(region, {nx, ny})
      end)
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  def price(region) do
    perimeter(region) * MapSet.size(region)
  end

  def price2(region) do
    sides(region) * MapSet.size(region)
  end

  def neighbours({x, y}) do
    [
      {x - 1, y},
      {x + 1, y},
      {x, y - 1},
      {x, y + 1}
    ]
  end

  def sides(region) do
    Enum.reduce(
      MapSet.to_list(region),
      MapSet.new(),
      fn {x, y}, acc ->
        new_corners = MapSet.new(corners(region, {x, y}))
        MapSet.union(acc, new_corners)
      end
    )
    |> MapSet.size()
  end

  def corners(region, {x, y}) do
    convex_corners =
      Enum.filter([{:n, :e}, {:n, :w}, {:s, :e}, {:s, :w}], fn {d1, d2} ->
        not MapSet.member?(region, compass_neighbours({x, y})[d1]) and
          not MapSet.member?(region, compass_neighbours({x, y})[d2])
      end)
      |> Enum.map(fn {d1, d2} ->
        case {d1, d2} do
          {:n, :e} -> {x + 1, y}
          {:n, :w} -> {x, y}
          {:s, :e} -> {x + 1, y + 1}
          {:s, :w} -> {x, y + 1}
        end
      end)

    concave_corners =
      Enum.filter([{:n, :e, :ne}, {:n, :w, :nw}, {:s, :e, :se}, {:s, :w, :sw}], fn {d1, d2,
                                                                                    d_corner} ->
        MapSet.member?(region, compass_neighbours({x, y})[d1]) and
          MapSet.member?(region, compass_neighbours({x, y})[d2]) and
          not MapSet.member?(region, compass_neighbours({x, y})[d_corner])
      end)
      |> Enum.map(fn {_, _, d_corner} ->
        case d_corner do
          :ne -> {x + 1, y}
          :nw -> {x, y}
          :se -> {x + 1, y + 1}
          :sw -> {x, y + 1}
        end
      end)

    z_corners =
      Enum.filter([{:n, :e, :ne}, {:n, :w, :nw}, {:s, :e, :se}, {:s, :w, :sw}], fn {d1, d2,
                                                                                    d_corner} ->
        not MapSet.member?(region, compass_neighbours({x, y})[d1]) and
          not MapSet.member?(region, compass_neighbours({x, y})[d2]) and
          MapSet.member?(region, compass_neighbours({x, y})[d_corner])
      end)
      |> Enum.map(fn {_, _, d_corner} ->
        case d_corner do
          :ne -> {x + 1, y, :z}
          :nw -> {x, y, :z}
          :se -> {x + 1, y + 1, :z}
          :sw -> {x, y + 1, :z}
        end
      end)

    concave_corners ++ convex_corners ++ z_corners
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
end
