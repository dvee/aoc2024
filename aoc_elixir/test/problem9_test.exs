defmodule Problem9Test do
  use ExUnit.Case

  test "parses input" do
    {:ok, input} = File.read("lib/problem9/input9_test.txt")
    parsed = Problem9.input_to_queue(input)
    assert Enum.join(:queue.to_list(parsed)) == "00...111...2...333.44.5555.6666.777.888899"
  end

  test "it compresses test input" do
    {:ok, input} = File.read("lib/problem9/input9_test.txt")
    parsed = Problem9.input_to_queue(input)
    compressed = Problem9.compress(parsed, :queue.new())
    compressed_list = :queue.to_list(compressed)
    assert Enum.join(:queue.to_list(compressed)) == "0099811188827773336446555566"
  end

  test "it calculates checksum on test input" do
    {:ok, input} = File.read("lib/problem9/input9_test.txt")
    output = Problem9.run1(input)
    assert output == 1928
  end

  test "it outputs part 1" do
    {:ok, input} = File.read("lib/problem9/input9.txt")
    output = Problem9.run1(input)
    IO.inspect(output)
    assert output == 6385338159127
  end

  test "it extracts free blocks" do
    {:ok, input} = File.read("lib/problem9/input9_test.txt")
    blocks = Problem9.free_blocks(Problem9.input_to_list(input))
    assert Enum.at(blocks, 0) == %{block_size: 3, start_index: 2}
  end

  test "it moves blocks" do
    {:ok, input} = File.read("lib/problem9/input9_test.txt")
    parsed = Problem9.input_to_list(input)
    moved = Problem9.move_block(parsed, {40, 2}, 2)
    assert Enum.join(moved) == "0099.111...2...333.44.5555.6666.777.8888.."
  end

  test "it moves blocks according to part 2 rules" do
    {:ok, input} = File.read("lib/problem9/input9_test.txt")
    parsed = Problem9.input_to_list(input)
    compressed = Problem9.compress2(parsed, 9)
    assert compressed |> Enum.join() == "0099.111...2...333.44.5555.6666.777.8888.."
  end

  test "it calculates part 2 on test input" do
    {:ok, input} = File.read("lib/problem9/input9_test.txt")
    output = Problem9.run2(input)
    assert output == 2858
  end

  @tag timeout: :infinity
  test "it calculates part 2" do
    {:ok, input} = File.read("lib/problem9/input9.txt")
    output = Problem9.run2(input)
    IO.inspect(output)
    assert output == 6415163624282
  end

  test "it runs the speed test" do
    {:ok, input} = File.read("lib/problem9/input9.txt")
    output = Problem9.speed_test(input)
    assert true
  end

end
