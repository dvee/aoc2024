defmodule Problem3Test do
  use ExUnit.Case

  test "runs on test input" do
    {:ok, input} = File.read("lib/problem3/input3_test.txt");
    assert Problem3.run1(input) == 161;
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem3/input3.txt");
    IO.inspect Problem3.run1(input);
  end

  test "runs part 2 on test input" do
    {:ok, input} = File.read("lib/problem3/input3a_test.txt");
    assert Problem3.run2(input) == 48;
  end

  test "outputs part 2" do
    {:ok, input} = File.read("lib/problem3/input3.txt");
    IO.inspect Problem3.run2(input);
  end
end
