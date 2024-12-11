defmodule Problem2Test do
  use ExUnit.Case

  test "parses input" do
    {:ok, input} = File.read("lib/problem2/input2_test.txt");
    parsed = Problem2.parse_input(input);

    # assert that parsed is a 6 x 5 array
    assert length(parsed) == 6;
    assert length(Enum.at(parsed, 0)) == 5;
  end

  test "runs part 1 on test data" do
    {:ok, input} = File.read("lib/problem2/input2_test.txt");
    assert Problem2.run1(input) == 2;
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem2/input2.txt");
    IO.puts(Problem2.run1(input));
    assert true;
  end

  test "safe" do
    assert Problem2.safe([7, 6, 4, 2, 1]) == true;
    assert Problem2.safe([1, 2, 7, 8, 9]) == false;
    assert Problem2.safe([9, 7, 6, 2, 1]) == false;
    assert Problem2.safe([1, 3, 2, 4, 5]) == true;
    assert Problem2.safe([8, 6, 4, 4, 1]) == true;
    assert Problem2.safe([1, 3, 6, 7, 9]) == true;
    assert Problem2.safe([9,5,4,3,2]) == true;
    assert Problem2.safe([1,2,3,4,9]) == true;
    assert Problem2.safe([9,2,3,4,9]) == false;
  end

  test "runs part 2 on test data" do
    {:ok, input} = File.read("lib/problem2/input2_test.txt");
    assert Problem2.run2(input) == 4;
  end

  test "outputs part 2" do
    {:ok, input} = File.read("lib/problem2/input2.txt");
    IO.puts(Problem2.run2(input));
    assert true;
  end

end
