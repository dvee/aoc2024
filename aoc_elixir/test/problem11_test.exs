defmodule Problem11Test do
  use ExUnit.Case

  test "parses input" do
    {:ok, input} = File.read("lib/problem11/input11_test.txt")
    parsed = Problem11.parse_input(input)
    assert parsed == [125, 17]
  end

  test "it splits stones" do
    assert Problem11.split_stone(1234) == [12, 34]
    assert Problem11.split_stone(1000) == [10, 0]
  end

  test "it mutates stones" do
    # 0 -> [1], 1-> [1024], 10 -> [1,0], 99 -> [9,9], 999 -> [2021976]
    assert Problem11.mutate(0) == [1]
    assert Problem11.mutate(1) == [2024]
    assert Problem11.mutate(10) == [1, 0]
    assert Problem11.mutate(99) == [9, 9]
    assert Problem11.mutate(999) == [2021976]
  end


  test "runs on test input" do
    {:ok, input} = File.read("lib/problem11/input11_test.txt")
    assert Problem11.run1(input, 6) == 22
    assert Problem11.run1(input, 25) == 55312
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem11/input11.txt")
    IO.inspect output = Problem11.run1(input, 25)
    assert output == 207683
  end

  test "runs on test input using ets for memoization / dp" do
    {:ok, input} = File.read("lib/problem11/input11_test.txt")
    {:ok, _pid} = Problem11b.start_link(nil)
    assert Problem11b.run1(input, 6) == 22
    assert Problem11b.run1(input, 25) == 55312
  end

  test "outputs part 2" do
    {:ok, input} = File.read("lib/problem11/input11.txt")
    {:ok, _pid} = Problem11b.start_link(nil)
    IO.inspect output = Problem11b.run1(input, 75)
    assert output == 244782991106220
  end

end
