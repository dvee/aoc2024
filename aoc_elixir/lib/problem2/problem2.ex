defmodule Problem2 do
  def parse_input(input) do
    String.split(input, "\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> Enum.map( fn record -> Enum.map(record, fn s -> String.to_integer(s) end) end)
  end

  def run1(input) do
    parse_input(input)
      |> Enum.map(fn record -> all_increasing(record) or all_decreasing(record) end)
      |> Enum.map(fn x -> if x, do: 1, else: 0 end)
      |> Enum.sum()
  end

  def run2(input) do
    parse_input(input)
      |> Enum.map(fn record -> safe(record) end)
      |> Enum.map(fn x -> if x, do: 1, else: 0 end)
      |> Enum.sum()
  end

  def all_increasing([_head]) do
    true
  end

  def all_increasing ([head | tail]) do
    # check if the first element in tail is 1 to 3 greater than head
    if Enum.at(tail, 0) - head >= 1 and Enum.at(tail, 0) - head <= 3 do
      all_increasing(tail)
    else
      false
    end

  end


  def all_decreasing([_head]) do
    true
  end

  def all_decreasing([head | tail]) do
    # check if the first element in tail is 1 to 3 less than head
    if head - Enum.at(tail, 0) >= 1 and head - Enum.at(tail, 0) <= 3 do
      all_decreasing(tail)
    else
      false
    end
  end

  def safe_increasing([_a, _b]) do
    true
  end
  def safe_increasing([head, a, b | tail]) do
    cond do
      a - head < 1 or a - head > 3 ->
        all_increasing([head, b | tail]) or all_increasing([a, b | tail])
      b - a >= 1 and b - a <= 3 ->
        safe_increasing([a, b | tail])
      true ->
        all_increasing([head, a | tail]) or all_increasing([head, b | tail])
    end
  end

  def safe_decreasing([_a, _b]) do
    true
  end
  def safe_decreasing([head, a, b | tail]) do
    cond do
      head - a > 3 or head - a < 1 ->
        all_decreasing([head, b | tail]) or all_decreasing([a, b | tail])
      a - b >= 1 and a - b <= 3 ->
      safe_decreasing([a, b | tail])
      true ->
        all_decreasing([head, a | tail]) or all_decreasing([head, b | tail])
    end
  end

  def safe (list) do
    safe_increasing(list) or safe_decreasing(list)
  end

end
