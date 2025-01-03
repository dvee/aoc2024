defmodule Problem15 do
  alias Utils.Grid2D

  def parse_input(input) do
    [grid_string, moves_string] = String.split(input, "\n\n", trim: true)
    grid = Grid2D.to_map(grid_string)

    moves =
      String.split(moves_string, "\n", trim: true)
      |> Enum.flat_map(fn line -> String.graphemes(line) end)

    {grid, moves}
  end

  def parse_input2(input) do
    [grid_string, moves_string] = String.split(input, "\n\n", trim: true)
    transformed_grid = part_2_transform(grid_string)
    grid = Grid2D.to_map(transformed_grid)

    moves =
      String.split(moves_string, "\n", trim: true)
      |> Enum.flat_map(fn line -> String.graphemes(line) end)

    {grid, moves}
  end

  def run1(input) do
    {grid, moves} = parse_input(input)
    final_grid = Enum.reduce(moves, grid, fn move, acc -> move(acc, move) end)
    # find all keys in final grid that have "O" value
    Grid2D.print(final_grid)

    Map.keys(final_grid)
    |> Enum.filter(fn k -> Map.get(final_grid, k) == "O" end)
    |> Enum.map(fn {x, y} -> x + 100 * y end)
    |> Enum.sum()
  end

  def run2(input) do
    {grid, moves} = parse_input2(input)

    final_grid =
      Enum.reduce(moves, grid, fn move, acc ->
        move(acc, move)
      end)

    Grid2D.print(final_grid)

    Map.keys(final_grid)
    |> Enum.filter(fn k -> Map.get(final_grid, k) == "[" end)
    |> Enum.map(fn {x, y} -> x + 100 * y end)
    |> Enum.sum()
  end

  def move(grid, move) do
    {x_r, y_r} = Grid2D.find(grid, "@")

    next_pos =
      case move do
        "^" -> fn {x, y} -> {x, y - 1} end
        ">" -> fn {x, y} -> {x + 1, y} end
        "v" -> fn {x, y} -> {x, y + 1} end
        "<" -> fn {x, y} -> {x - 1, y} end
      end

    {_, new_grid} = move(grid, {x_r, y_r}, next_pos)
    new_grid
  end

  def move(grid, {x_r, y_r}, next_pos_fn) do
    {x, y} = next_pos_fn.({x_r, y_r})
    next_value = Map.get(grid, {x, y})

    case next_value do
      "#" ->
        {:blocked, grid}

      "." ->
        {:moved, update_grid_move(grid, {x_r, y_r}, {x, y})}

      "O" ->
        case move(grid, {x, y}, next_pos_fn) do
          {:blocked, _} ->
            {:blocked, grid}

          {:moved, updated_grid} ->
            {:moved, update_grid_move(updated_grid, {x_r, y_r}, {x, y})}
        end

      c when c in ["[", "]"] ->
        case move_box(grid, {x, y}, next_pos_fn) do
          {:blocked, _} ->
            {:blocked, grid}

          {:moved, updated_grid} ->
            {:moved, update_grid_move(updated_grid, {x_r, y_r}, {x, y})}
        end

      nil ->
        raise "something went wrong"
    end
  end

  # for e/w moves, the behvaiour is the same as for "O"
  # for n/s moves, we need to check whether both sides of the box
  # are blocked from moving
  def move_box(grid, {x_r, y_r}, next_pos_fn) do
    other_side =
      case Map.get(grid, {x_r, y_r}) do
        "[" -> {x_r + 1, y_r}
        "]" -> {x_r - 1, y_r}
      end

    [{x1, y1}, {x2, y2}] = Enum.map([{x_r, y_r}, other_side], next_pos_fn)

    if y1 == y_r do
      # e / w move
      case move(grid, {x1, y1}, next_pos_fn) do
        {:blocked, _} ->
          {:blocked, grid}

        {:moved, updated_grid} ->
          {:moved, update_grid_move(updated_grid, {x_r, y_r}, {x1, y1})}
      end
    else
      # n / s move
      case move(grid, {x_r, y_r}, next_pos_fn) do
        {:blocked, _} ->
          {:blocked, grid}

        {:moved, updated_grid} ->
          case move(updated_grid, other_side, next_pos_fn) do
            {:blocked, _} ->
              {:blocked, grid}

            {:moved, updated_grid2} ->
              {:moved, updated_grid2}
          end
      end
    end
  end

  def update_grid_move(grid, {x_from, y_from}, {x_to, y_to}) do
    current_value = Map.get(grid, {x_from, y_from})

    grid
    |> Map.put({x_from, y_from}, ".")
    |> Map.put({x_to, y_to}, current_value)
  end

  def part_2_transform(input_string) do
    input_string
    |> String.graphemes()
    |> Enum.map(fn c ->
      case c do
        "#" -> "##"
        "O" -> "[]"
        "." -> ".."
        "@" -> "@."
        _ -> c
      end
    end)
    |> Enum.join("")
  end
end
