defmodule Problem13Test do
  use ExUnit.Case

  test "parses test input" do
    {:ok, input} = File.read('lib/problem13/input13_test.txt')
    parsed = Problem13.parse_input(input)
    assert length(parsed) == 4
  end

  test "calculates part 1 on test input" do
    {:ok, input} = File.read('lib/problem13/input13_test.txt')
    result = Problem13.run1(input)
    assert result == 480
  end

  test "outputs part 1" do
    {:ok, input} = File.read('lib/problem13/input13.txt')
    IO.inspect(result = Problem13.run1(input))
    assert result == 25751
  end

  test "outputs part 2" do
    {:ok, input} = File.read('lib/problem13/input13.txt')
    IO.inspect(result = Problem13.run2(input))
    assert result == 108528956728655
  end
end
