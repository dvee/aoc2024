defmodule Problem1Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run/1 prints 'Hello, world!'" do
    {:ok, file_content} = File.read("lib/problem1/input1.txt")

    assert capture_io(fn -> Problem1.run(file_content) end) ==
             "Hello, world!" <> file_content <> "\n"
  end

  test "prints the result" do
    {:ok, file_content} = File.read("lib/problem1/input1.txt")
    IO.puts(Problem1.run(file_content))
    assert true
  end

  test "parses input" do
    {:ok, file_content} = File.read("lib/problem1/input1_test.txt")
    parsed = Problem1.parse_input(file_content)
    assert parsed == [{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]
  end

  test "runs part 1 on test data" do
    {:ok, file_content} = File.read("lib/problem1/input1_test.txt")
    assert Problem1.run1(file_content) == 11
  end

  test "outputs part 1" do
    {:ok, file_content} = File.read("lib/problem1/input1.txt")
    IO.puts(Problem1.run1(file_content))
    assert true
  end

  test "runs part 2 on test data" do
    {:ok, file_content} = File.read("lib/problem1/input1_test.txt")
    assert Problem1.run2(file_content) == 31
  end

  test "outputs part 2" do
    {:ok, file_content} = File.read("lib/problem1/input1.txt")
    IO.puts(Problem1.run2(file_content))
    assert true
  end
end
