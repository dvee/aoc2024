defmodule Problem12Test do
  use ExUnit.Case

  test "runs on test input" do

  end

  test "computes connected region" do
    {:ok, input} = File.read('lib/problem12/input12_test.txt')
    grid = Problem12.parse_input(input)
    region1 = Problem12.region({0, 0}, grid)
    assert MapSet.size(region1) == 12
  end

  test "computes all regions" do
    {:ok, input} = File.read('lib/problem12/input12_test.txt')
    grid = Problem12.parse_input(input)
    regions = Problem12.regions(grid)
    assert length(regions) == 11
  end

  test "computes the permieter of a region" do
    {:ok, input} = File.read('lib/problem12/input12_test.txt')
    grid = Problem12.parse_input(input)
    regions = Problem12.regions(grid)
    region1 = List.last(regions)
    assert Problem12.perimeter(region1) == 18
  end

  test "computes the price of a region" do
    {:ok, input} = File.read('lib/problem12/input12_test.txt')
    grid = Problem12.parse_input(input)
    regions = Problem12.regions(grid)
    region1 = List.last(regions)
    assert Problem12.price(region1) == 234
  end

  test "computes total price on test input" do
    {:ok, input} = File.read('lib/problem12/input12_test.txt')
    assert Problem12.run1(input) == 1930
  end

  test "outputs part 1" do
    {:ok, input} = File.read('lib/problem12/input12.txt')
    IO.inspect result = Problem12.run1(input)
    assert result == 1464678
  end

  test "calculates number of sides of a region" do
    {:ok, input} = File.read('lib/problem12/input12_test.txt')
    grid = Problem12.parse_input(input)
    regions = Problem12.regions(grid)
    region1 = List.last(regions)
    assert Problem12.sides(region1) == 8
  end
end
