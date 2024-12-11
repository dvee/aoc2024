defmodule Utils.DirectedGraph do
  def new() do
    %{}
  end

  def add_edge(graph, from, to) do
    Map.update(graph, from, [to], fn adj -> [to | adj] end)
  end

  def children(graph, node) do
    Map.get(graph, node, [])
  end

  @spec has_child?(map(), any(), any()) :: boolean()
  def has_child?(graph, node, child) do
    children(graph, node)
    |> Enum.member?(child)
  end

  def has_descendant?(graph, node, target) do
    has_descendant?(graph, node, target, MapSet.new())
  end

  defp has_descendant?(graph, node, target, visited) do
    if MapSet.member?(visited, node) do
      false
    else
      if node == target do
        true
      else
        children(graph, node)
        |> Enum.any?(fn child -> has_descendant?(graph, child, target, MapSet.put(visited, node)) end)
      end
    end
  end

  def has_ancestor?(graph, node, target) do
    has_ancestor?(graph, node, target, MapSet.new())
  end

  defp has_ancestor?(graph, node, target, visited) do
    if MapSet.member?(visited, node) do
      false
    else
      graph
      |> Enum.any?(fn {parent, children} ->
        if Enum.member?(children, node) do
          parent == target or has_ancestor?(graph, parent, target, MapSet.put(visited, node))
        else
          false
        end
      end)
    end
  end
end
