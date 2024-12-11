defmodule Problem4Test do
  use ExUnit.Case

  test "reads input into a map" do
    {:ok, input} = File.read("lib/problem4/input4_test.txt");
    map = Problem4.input_to_grid(input)
    assert Map.get(map, {0, 0}) == "M"
  end

  test "searches in a direction" do
    {:ok, input} = File.read("lib/problem4/input4_test.txt");
    map = Problem4.input_to_grid(input)
    assert Problem4.search(map, {5, 0}, :E, ["X", "M", "A", "S"]) == true
  end

  test "runs on test input" do
    {:ok, input} = File.read("lib/problem4/input4_test.txt");
  #  assert Problem4.run1(input) == 18;
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem4/input4.txt");
    IO.inspect Problem4.run1(input);
  end

  test "evaluate x-mas" do
    {:ok, input} = File.read("lib/problem4/input4_test.txt");
    map = Problem4.input_to_grid(input)
    assert Problem4.is_x_mas(map, {2, 1}) == true
  end

  test "runs part 2 on test input" do
    {:ok, input} = File.read("lib/problem4/input4_test.txt");
    assert Problem4.run2(input) == 9;
  end

  test "outputs part 2" do
    {:ok, input} = File.read("lib/problem4/input4.txt");
    IO.inspect Problem4.run2(input);
  end
end
