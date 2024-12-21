defmodule Problem14 do
  defmodule Robot do
    defstruct position: {0, 0}, velocity: {0, 0}
  end

  def run1(input, seconds, {board_width, board_height}) do
    robots = parse_input(input)

    positions =
      Enum.map(robots, &position_after_seconds(&1, seconds, {board_width, board_height}))

    groups = group_by_quadrant(positions, {board_width, board_height})
    safety_factor(groups)
  end

  def run2(input, {board_width, board_height}) do
    robots = parse_input(input)
    x_mas_tree(robots, {board_width, board_height})
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    regex = ~r/p=(?<px>-?\d+),(?<py>-?\d+) v=(?<vx>-?\d+),(?<vy>-?\d+)/

    case Regex.named_captures(regex, line) do
      %{"px" => px, "py" => py, "vx" => vx, "vy" => vy} ->
        %Robot{
          position: {String.to_integer(px), String.to_integer(py)},
          velocity: {String.to_integer(vx), String.to_integer(vy)}
        }

      _ ->
        {:error, "Invalid input format"}
    end
  end

  def position_after_seconds(
        %Robot{position: {px, py}, velocity: {vx, vy}},
        seconds,
        {board_width, board_height}
      ) do
    px_new = mod(px + vx * seconds, board_width)
    py_new = mod(py + vy * seconds, board_height)
    {px_new, py_new}
  end

  defp mod(x, y) do
    rem = rem(x, y)

    if rem < 0 do
      rem + y
    else
      rem
    end
  end

  def group_by_quadrant(positions, {board_width, board_height}) do
    mid_x = div(board_width, 2)
    mid_y = div(board_height, 2)

    groups =
      Enum.group_by(positions, fn {x, y} ->
        cond do
          x < mid_x and y < mid_y -> :top_left
          x > mid_x and y < mid_y -> :top_right
          x < mid_x and y > mid_y -> :bottom_left
          x > mid_x and y > mid_y -> :bottom_right
          true -> :center
        end
      end)

    [groups[:top_left], groups[:top_right], groups[:bottom_left], groups[:bottom_right]]
  end

  def safety_factor(groups) do
    groups
    |> Enum.map(&length/1)
    |> Enum.reduce(1, fn x, acc -> acc * x end)
  end

  def x_mas_tree(robots, {board_width, board_height}) do
    x_mas_tree(robots, 0, {board_width, board_height}, 218965032)
  end

  def x_mas_tree(robots, seconds, {board_width, board_height}, min_sf) do
    positions =
      Enum.map(robots, &position_after_seconds(&1, seconds, {board_width, board_height}))
      IO.inspect(seconds)
    groups = group_by_quadrant(positions, {board_width, board_height})
    sf = safety_factor(groups)
    new_min_sf = if sf < min_sf do
       sf
    else
      min_sf
    end
    IO.puts("Safety factor: #{sf}, max: #{min_sf}")
    case new_min_sf < min_sf do
      true ->
        IO.inspect(seconds)
        print_board(positions, {board_width, board_height})
        case get_user_input() do
          :yes -> x_mas_tree(robots, seconds + 1, {board_width, board_height}, new_min_sf)
          :no -> seconds
        end
        seconds
      false -> x_mas_tree(robots, seconds + 1, {board_width, board_height}, new_min_sf)
    end
  end

  def print_board(positions, {board_width, board_height}) do
    board = for _y <- 0..board_height - 1, do: for _x <- 0..board_width - 1, do: "."

    Enum.reduce(positions, board, fn {x, y}, acc ->
      List.replace_at(acc, y, List.replace_at(Enum.at(acc, y), x, "#"))
    end)
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join("\n")
    |> IO.puts()
  end

  def get_user_input do
    IO.write("Do you want to continue? (y/n): ")
    input = IO.gets("") |> String.trim()
    case input do
      "y" -> :yes
      "n" -> :no
      _ ->
        IO.puts("Invalid input. Please enter 'y' or 'n'.")
        get_user_input()
    end
  end
end
