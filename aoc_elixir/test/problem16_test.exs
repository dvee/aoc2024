defmodule Problem16Test do
  alias Problem16.DeerState
  alias Utils.Grid2D
  use ExUnit.Case

  test "calculates possible moves" do
    input = """
    #####
    #.@.#
    #####
    """

    grid = Grid2D.to_map(input)
    state = %DeerState{pos: {2, 1}, dir: :n}
    possible_moves = Problem16.possible_moves(state, grid)

    assert possible_moves == [
             %{action: :left, new_state: %DeerState{pos: {1, 1}, dir: :w}},
             %{action: :right, new_state: %DeerState{dir: :e, pos: {3, 1}}}
           ]
  end

  test "it runs part 1 on test input" do
    {:ok, input} = File.read("lib/problem16/input16_test.txt")
    assert Problem16.run1(input) == 7036
  end

  test "it outputs part 1" do
    {:ok, input} = File.read("lib/problem16/input16.txt")
    IO.inspect result = Problem16.run1(input)
    assert result == 94444
  end

  test "it outputs part 2 on test input" do
    {:ok, input} = File.read("lib/problem16/input16_test.txt")
    assert Problem16.run2(input) == 45
  end

  test "it outputs part 2" do
    {:ok, input} = File.read("lib/problem16/input16.txt")
    IO.inspect result = Problem16.run2(input)
    assert result == 502
  end

end
