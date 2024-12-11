defmodule Problem1 do
  def run1(input) do
    parse_input(input)
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> a - b end)
    |> Enum.map(&abs/1)
    |> Enum.sum()
  end

  def run2(input) do
    {left, right} = parse_input(input)
    |> Enum.unzip()
    occurences = Enum.reduce(right, %{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
    Enum.reduce(left, 0, fn x, acc -> Map.get(occurences, x, 0) * x + acc end)
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      case Regex.scan(~r/(\d+)\s+(\d+)/, s) do
        [[_, a, b]] -> {String.to_integer(a), String.to_integer(b)}
        _ -> raise "invalid input"
      end
    end)
  end
end
