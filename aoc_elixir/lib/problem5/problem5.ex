defmodule Problem5 do
alias Utils.DirectedGraph

  def run1(input) do
    rules = read_rules(input)
    updates = read_updates(input)
    Enum.filter(updates, fn update -> valid_update(rules, update) end)
    |> Enum.map(fn update -> Enum.at(update, div(length(update), 2)) end)
    |> Enum.sum()
  end

  def run2(input) do
    rules = read_rules(input)
    updates = read_updates(input)
    Enum.filter(updates, fn update -> not valid_update(rules, update) end)
    |> Enum.map(fn update -> sort_by_rules(rules, update) end)
    |> Enum.map(fn update -> Enum.at(update, div(length(update), 2)) end)
    |> Enum.sum()
  end

  def read_rules(input) do
    regex = ~r/(\d+)\|(\d+)/
    matches = Regex.scan(regex, input)
    matches
    |> Enum.map(fn [_, a, b] -> {String.to_integer(a), String.to_integer(b)} end)
  end

  def read_updates(input) do
    input
    |> String.split("\n\n", trim: true)  # Split by double newlines to separate blocks
    |> List.last()                       # Get the last block (after the blank line)
    |> String.split("\n", trim: true)    # Split the block into lines
    |> Enum.map(&String.split(&1, ","))  # Split each line into an array of strings
    |> Enum.map(&Enum.map(&1, fn s -> String.to_integer(s)end))  # Convert each string to an integer
  end

  def valid_rule?({a, b}, update) do
    case { Enum.find_index(update, &(&1 == a)), Enum.find_index(update, &(&1 == b)) } do
      {nil, nil} -> true
      {nil, _} -> true
      {_, nil} -> true
      {i_a, i_b} -> i_a < i_b
    end
  end

  def valid_update(rules, update) do
    Enum.all?(rules, fn rule -> valid_rule?(rule, update) end)
  end

  def sort_by_rules(rules, update) do
    g = Enum.reduce(rules, DirectedGraph.new(), fn {a, b}, g -> DirectedGraph.add_edge(g, a, b) end)
    Enum.sort(update, fn a, b ->
        DirectedGraph.has_child?(g, a , b) || not DirectedGraph.has_child?(g, b, a)
      end
   )
  end
end
