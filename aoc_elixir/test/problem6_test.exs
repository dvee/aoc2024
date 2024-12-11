defmodule Problem6Test do
  use ExUnit.Case
  alias Utils.Grid2D

  test "runs on test input" do
    {:ok, input} = File.read("lib/problem6/input6_test.txt");
    assert Problem6.run1(input) == 41
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem6/input6.txt");
    IO.inspect Problem6.run1(input);
    assert true
  end

  test "forms_loop_start works on test data" do
    {:ok, input} = File.read("lib/problem6/input6_test.txt");
    grid = Utils.Grid2D.to_map(input)
    {start_position, _} = Enum.find(grid, fn {_, v} -> v == "^" end)
    state = %GuardState{position: start_position, direction: :N}
    assert Problem6.forms_loop_start(grid, state, {3, 6}) == true
  end

  test "it runs part 2 on test input" do
    {:ok, input} = File.read("lib/problem6/input6_test.txt");
    assert Problem6.run2(input) == 6
  end

  test "is outputs part 2" do
    {:ok, input} = File.read("lib/problem6/input6.txt");
    IO.inspect Problem6.run2(input);
    assert true
  end
end
