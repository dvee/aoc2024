defmodule Problem14Test do
  use ExUnit.Case

  test "calculates updated positions" do
    robot = Problem14.parse_line("p=2,4 v=2,-3")
    dims = {11, 7}
    assert Problem14.position_after_seconds(robot, 1, dims) == {4, 1}
    assert Problem14.position_after_seconds(robot, 2, dims) == {6, 5}
    assert Problem14.position_after_seconds(robot, 3, dims) == {8, 2}
    assert Problem14.position_after_seconds(robot, 4, dims) == {10, 6}
    assert Problem14.position_after_seconds(robot, 5, dims) == {1, 3}
  end

  test "calculates part 1 on test input" do
    {:ok, input} = File.read("lib/problem14/input14_test.txt")
    assert Problem14.run1(input, 100, {11, 7}) == 12
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem14/input14.txt")
    IO.puts result = Problem14.run1(input, 100, {101, 103})
    assert result == 218965032
  end

  test "outputs part 2" do
    # run interactively in iex:
    # {:ok, input} = File.read("lib/problem14/input14.txt")
    # IO.puts result = Problem14.run2(input, {101, 103})
  end
end
