defmodule Problem15Test do
  use ExUnit.Case

  test "parses input" do
    {:ok, input} = File.read("lib/problem15/input15_test.txt")
    {grid, moves} = Problem15.parse_input(input)
    assert length(moves) == 700
  end

  test "it runs on test input" do
    {:ok, input} = File.read("lib/problem15/input15_test.txt")
    assert Problem15.run1(input) == 10092
  end

  test "it runs on part 1" do
    {:ok, input} = File.read("lib/problem15/input15.txt")
    IO.inspect(result = Problem15.run1(input))
    assert result == 1505963
  end

  test "it transforms the grid for part 2" do
    {:ok, input} = File.read("lib/problem15/input15_test.txt")
    [grid_string, moves_string] = String.split(input, "\n\n", trim: true)
    transformed_input = Problem15.part_2_transform(grid_string)
    assert transformed_input == "####################
##....[]....[]..[]##
##............[]..##
##..[][]....[]..[]##
##....[]@.....[]..##
##[]##....[]......##
##[]....[]....[]..##
##..[][]..[]..[][]##
##........[]......##
####################"
  end

  test "it outputs part 2 on test data" do
    {:ok, input} = File.read("lib/problem15/input15_test.txt")
    assert Problem15.run2(input) == 9021
  end

  test "it outputs part 2" do
    {:ok, input} = File.read("lib/problem15/input15.txt")
    IO.inspect(result = Problem15.run2(input))
    assert result == 1543141
  end
end
