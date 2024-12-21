defmodule Problem10 do
  alias Utils.Grid2D

  def run1(input) do
    grid = Grid2D.to_map(input)

    grid
      |> Map.filter(fn {{_, _}, value} -> value == "0" end)
      |> Map.keys()
      |> Enum.map(fn {x, y} -> get_termini(grid, {x, y}) end)
      |> Enum.map(fn termini -> MapSet.size(termini) end)
      |> Enum.sum()
  end

  def run2(input) do
    grid = Grid2D.to_map(input)

    grid
    |> Map.filter(fn {{_, _}, value} -> value == "0" end)
    |> Map.keys()
    |> Enum.map(fn {x, y} -> get_rating(grid, {x, y}) end)
    |> Enum.map(fn termini -> length(termini) end)
    |> Enum.sum()
  end

  def get_termini(grid, {x_start, y_start}) do
    Enum.reduce([{-1, 0}, {1, 0}, {0, -1}, {0, 1}], MapSet.new(), fn {dx, dy}, acc ->
      x = x_start + dx
      y = y_start + dy

      next_pos_valid = valid_next_position?(grid, {x, y}, {x_start, y_start})
      cond do
        next_pos_valid && Map.get(grid, {x, y}) == "9" ->
          MapSet.put(acc, {x, y})

        next_pos_valid ->
          MapSet.union(acc, get_termini(grid, {x, y}))

        true -> acc
      end
    end)
  end

  def get_rating(grid, {x_start, y_start}) do
    Enum.reduce([{-1, 0}, {1, 0}, {0, -1}, {0, 1}],[], fn {dx, dy}, acc ->
      x = x_start + dx
      y = y_start + dy

      next_pos_valid = valid_next_position?(grid, {x, y}, {x_start, y_start})
      cond do
        next_pos_valid && Map.get(grid, {x, y}) == "9" ->
          [{x, y} | acc]

        next_pos_valid ->
           acc ++ get_rating(grid, {x, y})

        true -> acc
      end
    end)
  end

  def valid_next_position?(grid, {x_next, y_next}, {x_current, y_current}) do
    current_value = Map.get(grid, {x_current, y_current})
    next_value = Map.get(grid, {x_next, y_next}, nil)

    case next_value do
      nil -> false
      _ -> String.to_integer(next_value) - String.to_integer(current_value) == 1
    end
  end
end
