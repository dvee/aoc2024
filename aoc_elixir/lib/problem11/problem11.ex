defmodule Problem11 do
  def parse_input(input) do
    String.split(input, " ", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def run1(input, blinks) do
    stones = parse_input(input)
    sum_stones(stones, blinks)
  end

  def sum_stones([stone], blinks) do
    if blinks == 0 do
      1
    else
      sum_stones(mutate(stone), blinks - 1)
    end
  end

  def sum_stones([head | tail], blinks) do
    sum_stones([head], blinks) + sum_stones(tail, blinks)
  end

  def mutate(stone) do
    number_of_digits = Integer.digits(stone) |> Enum.count()
    cond do
      stone == 0 -> [1]
      rem(number_of_digits, 2) == 0 -> split_stone(stone)
      true -> [stone * 2024]
    end
  end

  def split_stone(stone) do
    number_of_digits = Integer.digits(stone) |> Enum.count()
    half = div(number_of_digits, 2)
    {left, right} = Integer.digits(stone) |> Enum.split(half)
    [Enum.join(left), Enum.join(right)] |> Enum.map(&String.to_integer/1)
  end
end
