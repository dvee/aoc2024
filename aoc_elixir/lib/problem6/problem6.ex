defmodule Problem6 do
  alias Utils.Grid2D
  alias GuardState

  def run1(input) do
    grid = Grid2D.to_map(input)
    {start_position, _} = Enum.find(grid, fn {_, v} -> v == "^" end)

    visited =
      MapSet.new()
      |> MapSet.put(start_position)

    state = %GuardState{position: start_position, direction: :N}
    step1(grid, state, visited)
  end

  def run2(input) do
    grid = Grid2D.to_map(input)
    {start_position, _} = Enum.find(grid, fn {_, v} -> v == "^" end)
    state = %GuardState{position: start_position, direction: :N}

    visited =
      MapSet.new()
      |> MapSet.put(state)

    new_obs = step2(grid, state, visited, MapSet.new(), state)

    existing_obs =
      Enum.filter(grid, fn {_pos, value} -> value == "#" end)
      |> Enum.map(fn {pos, _} -> pos end)
      |> MapSet.new()

    new_obs = MapSet.difference(new_obs, existing_obs) |> MapSet.delete(start_position)
    IO.inspect(new_obs)
    x_max = Enum.map(grid, fn {{x, _}, _} -> x end) |> Enum.max()
    y_max = Enum.map(grid, fn {{_, y}, _} -> y end) |> Enum.max()

    Enum.filter(new_obs, fn {x, y} -> x >= 0 and x <= x_max and y >= 0 and y <= y_max end)
    |> Enum.count()
  end

  def states_with_same_position(visited, state) do
    Enum.filter(visited, fn s -> s.position == state.position end)
  end


  def forms_loop_start(grid, start_state, test_position) do
    forms_loop?(Map.put(grid, test_position, "#"), start_state, MapSet.new())
  end
  def forms_loop?(grid, state, visited) do
    if MapSet.member?(visited, state) do
      true
    else
      case next_state(grid, state) do
        ^state ->
          false

        new_state ->
          forms_loop?(grid, new_state, MapSet.put(visited, state))
      end
    end
  end

  def step1(grid, state, visited) do
    case next_state(grid, state) do
      ^state -> MapSet.size(visited)
      new_state -> step1(grid, new_state, MapSet.put(visited, new_state.position))
    end
  end

  def step2(grid, state, visited, new_obs, start_state) do
    IO.puts("Visited length: #{MapSet.size(visited)}")

    case next_state(grid, state) do
      ^state ->
        new_obs

      new_state ->
        potential_obstacle = next_position(new_state)
        updated_obs =
          if forms_loop_start(grid, start_state, potential_obstacle) do
            MapSet.put(new_obs, potential_obstacle)
          else
            new_obs
          end

        step2(grid, new_state, MapSet.put(visited, new_state), updated_obs, start_state)
    end
  end

  def next_state(grid, state) do
    case Map.get(grid, next_position(state)) do
      nil -> state
      "#" -> turn_right(state)
      _ -> %GuardState{state | position: next_position(state)}
    end
  end

  @spec next_position(GuardState.t()) :: GuardState.position()
  def next_position(%GuardState{position: {x, y}, direction: direction}) do
    case direction do
      :N -> {x, y - 1}
      :E -> {x + 1, y}
      :S -> {x, y + 1}
      :W -> {x - 1, y}
      _ -> raise "Invalid direction: #{inspect(direction)}"
    end
  end

  def turn_right(state) do
    case state.direction do
      :N -> %GuardState{state | direction: :E}
      :E -> %GuardState{state | direction: :S}
      :S -> %GuardState{state | direction: :W}
      :W -> %GuardState{state | direction: :N}
    end
  end
end
