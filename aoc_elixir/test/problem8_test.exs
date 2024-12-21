defmodule Problem8Test do
  use ExUnit.Case

  test "calculates antinode positions" do
    assert Problem8.antinodes_for_positions({4, 3}, {5, 5}) == [{3, 1}, {6, 7}]
    assert Problem8.antinodes_for_positions({1, 1}, {1, 1}) == []
  end

  test "runs on test input" do
    {:ok, input} = File.read("lib/problem8/input8_test.txt")
    assert Problem8.run1(input) == 14
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem8/input8.txt")
    IO.inspect output = Problem8.run1(input)
    assert output == 291
  end

  test "runs part 2 on test input" do
    {:ok, input} = File.read("lib/problem8/input8_test.txt")
    assert Problem8.run2(input) == 34
  end

  test "outputs part 2" do
    {:ok, input} = File.read("lib/problem8/input8.txt")
    IO.inspect output = Problem8.run2(input)
    assert output == 1015
  end
end
