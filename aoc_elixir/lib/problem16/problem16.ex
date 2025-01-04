defmodule Problem16 do
  alias Utils.Grid2D
  alias Problem16.DeerState

  defmodule DeerState do
    defstruct pos: {0, 0}, dir: :n
  end

  def run1(input) do
    grid = parse_input(input)
    start = Grid2D.find(grid, "S")
    target = Grid2D.find(grid, "E")
    shortest_path(grid, start, target).dist
  end

  def run2(input) do
    grid = parse_input(input)
    start = Grid2D.find(grid, "S")
    target = Grid2D.find(grid, "E")
    %{prev: prev} = shortest_path(grid, start, target)
    num_nodes = Enum.map([%DeerState{pos: target, dir: :n}, %DeerState{pos: target, dir: :e}, %DeerState{pos: target, dir: :s}, %DeerState{pos: target, dir: :w}], fn x -> prev_paths(prev, x) end)
    |> Enum.reduce(MapSet.new(), fn x, acc -> MapSet.union(x, acc) end)
    |> Enum.count()
    num_nodes + 1
  end


  def parse_input(input) do
    Grid2D.to_map(input)
  end

  def possible_moves(state, grid) do
    neighbours = Grid2D.compass_neighbours(state.pos)

    candidates =
      case state.dir do
        :n ->
          [
            %{action: :left, new_state: %DeerState{pos: neighbours.w, dir: :w}},
            %{action: :right, new_state: %DeerState{pos: neighbours.e, dir: :e}},
            %{action: :forwards, new_state: %DeerState{pos: neighbours.n, dir: :n}}
          ]

        :e ->
          [
            %{action: :left, new_state: %DeerState{pos: neighbours.n, dir: :n}},
            %{action: :right, new_state: %DeerState{pos: neighbours.s, dir: :s}},
            %{action: :forwards, new_state: %DeerState{pos: neighbours.e, dir: :e}}
          ]

        :s ->
          [
            %{action: :left, new_state: %DeerState{pos: neighbours.e, dir: :e}},
            %{action: :right, new_state: %DeerState{pos: neighbours.w, dir: :w}},
            %{action: :forwards, new_state: %DeerState{pos: neighbours.s, dir: :s}}
          ]

        :w ->
          [
            %{action: :left, new_state: %DeerState{pos: neighbours.s, dir: :s}},
            %{action: :right, new_state: %DeerState{pos: neighbours.n, dir: :n}},
            %{action: :forwards, new_state: %DeerState{pos: neighbours.w, dir: :w}}
          ]
      end

    candidates
    |> Enum.filter(fn c -> Grid2D.get(grid, c.new_state.pos) != "#" end)
  end

  def shortest_path(grid, start, target) do
    loop(grid, %{%DeerState{pos: start, dir: :e} => 0}, %{}, MapSet.new(), target)
  end

  def loop(grid, dist, prev, visited, target) do
    queue = Enum.filter(dist, fn {k, _} -> not MapSet.member?(visited, k) end)
    # find the node with minimum value in queue
    {node, _} = Enum.min_by(queue, fn {_, d} -> d end)

    new_visted = MapSet.put(visited, node)

    {new_dist, new_prev} =
      Enum.reduce(possible_moves(node, grid), {dist, prev}, fn move, {dist_acc, prev_acc} ->
        alt = Map.get(dist_acc, node) + move_cost(move)

        {dist_acc, prev_acc} =
          cond do
            Map.get(dist_acc, move.new_state) == nil ->
              {Map.put(dist_acc, move.new_state, alt), Map.put(prev_acc, move.new_state, [node])}

            alt < Map.get(dist, move.new_state) ->
              {Map.put(dist_acc, move.new_state, alt), Map.put(prev_acc, move.new_state, [node])}

            alt == Map.get(dist, move.new_state) -> {dist_acc, Map.update(prev_acc, move.new_state, [node], &List.insert_at(&1, 0, node))}
            true ->
              {dist_acc, prev_acc}
          end

        {dist_acc, prev_acc}
      end)

    if target_state =
         Enum.find(
           [
             %DeerState{pos: target, dir: :n},
             %DeerState{pos: target, dir: :e},
             %DeerState{pos: target, dir: :s},
             %DeerState{pos: target, dir: :w}
           ],
           fn x -> MapSet.member?(new_visted, x) end
         ) do
      %{dist: Map.get(new_dist, target_state), prev: new_prev}
    else
      loop(grid, new_dist, new_prev, new_visted, target)
    end
  end

  def prev_paths(prev, state) do
    prev_paths(prev, [state], MapSet.new())
  end

  def prev_paths(prev, [state], current_path) do
    case Map.get(prev, state) do
      nil -> current_path
      prev_state ->
        prev_paths(prev, prev_state, MapSet.put(current_path, state.pos))
    end
  end

  def prev_paths(prev, [state | other_states], current_path) do
    case Map.get(prev, state) do
      nil -> prev_paths(prev, other_states, current_path)
      prev_state ->
        prev_paths(prev, prev_state, MapSet.put(current_path, state.pos))
        |> MapSet.union(prev_paths(prev, other_states, current_path))
    end
  end

  def move_cost(move) do
    case move.action do
      :forwards -> 1
      :left -> 1001
      :right -> 1001
    end
  end
end
