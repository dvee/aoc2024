defmodule Problem7Test do
  use ExUnit.Case

  test "parses input" do
    {:ok, input} = File.read("lib/problem7/input7_test.txt")
    parsed = Problem7.parse_input(input)
    assert Enum.at(parsed, 0) == %Problem7.Equation{lhs: 190, rhs: [10, 19]}
  end

  test "determines if possibly true" do
    assert Problem7.possibly_true?(%Problem7.Equation{lhs: 190, rhs: [10, 19]}) == true
    assert Problem7.possibly_true?(%Problem7.Equation{lhs: 3267, rhs: [81, 40, 27]}) == true
    assert Problem7.possibly_true?(%Problem7.Equation{lhs: 7290, rhs: [6, 8, 6, 15]}) == false
  end

  test "runs part 1 on test data" do
    {:ok, input} = File.read("lib/problem7/input7_test.txt")
    assert Problem7.run1(input) == 3749
  end

  test "outputs part1 " do
    {:ok, input} = File.read("lib/problem7/input7.txt")
    IO.puts output = Problem7.run1(input)
    assert output == 1260333054159
  end

  test "runs part 2 on test data" do
    {:ok, input} = File.read("lib/problem7/input7_test.txt")
    assert Problem7.run2(input) == 11387
  end

  test "outputs part2 " do
    {:ok, input} = File.read("lib/problem7/input7.txt")
    IO.puts output = Problem7.run2(input)
    assert output == 162042343638683
  end
end
