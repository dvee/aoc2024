defmodule DirectedGraphTest do
  alias Utils.DirectedGraph
  alias Utils.DirectedGraph
  use ExUnit.Case

  test "can search dfs for children" do
    graph = DirectedGraph.new()
    |> DirectedGraph.add_edge(1, 2)
    |> DirectedGraph.add_edge(2, 3)
    |> DirectedGraph.add_edge(4, 5)
    assert DirectedGraph.has_descendant?(graph, 1, 3) == true
    assert DirectedGraph.has_descendant?(graph, 1, 5) == false
  end

  test "can search dfs for ancestors" do
    graph = DirectedGraph.new()
    |> DirectedGraph.add_edge(1, 2)
    |> DirectedGraph.add_edge(2, 3)
    |> DirectedGraph.add_edge(4, 5)
    assert DirectedGraph.has_ancestor?(graph, 3, 1) == true
    assert DirectedGraph.has_ancestor?(graph, 5, 1) == false
  end
end
