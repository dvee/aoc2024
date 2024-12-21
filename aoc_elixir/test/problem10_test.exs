defmodule Problem10Test do
  use ExUnit.Case

  test "runs on test input" do
    {:ok , input} = File.read('lib/problem10/input10_test.txt')
    assert Problem10.run1(input) == 36
  end

  test "calculates terminii for starting points on test input" do
    {:ok, input} = File.read('lib/problem10/input10_test.txt')
    grid = Utils.Grid2D.to_map(input)
    test_positions = [{2, 0}, {4, 0 }, {4, 2}, {6 ,4}, {2,5}, {5,5}, {0,6}, {6,6}, {1,7}]
    #validate input points
    assert Enum.all?(test_positions, fn {x, y} -> Map.get(grid, {x,y}) == "0" end)
    counts = Enum.map(test_positions, fn {x, y} -> MapSet.size(Problem10.get_termini(grid, {x, y})) end)
    assert counts == [5, 6, 5, 3, 1, 3, 5, 3, 5]
  end

  test "outputs part 1" do
    {:ok, input} = File.read('lib/problem10/input10.txt')
    IO.inspect result = Problem10.run1(input)
    assert result = 778
  end

  test "it runs part 2 on test input" do
    {:ok, input} = File.read('lib/problem10/input10_test.txt')
    assert Problem10.run2(input) == 81
  end

  test "it outputs part 2" do
    {:ok, input} = File.read('lib/problem10/input10.txt')
    IO.inspect result = Problem10.run2(input)
    assert result = 1925
  end
end
