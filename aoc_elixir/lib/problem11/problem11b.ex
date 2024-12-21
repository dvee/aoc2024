defmodule Problem11b do
  use GenServer

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def parse_input(input) do
    String.split(input, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def run1(input, blinks) do
    stones = parse_input(input)
    GenServer.call(__MODULE__, {:sum_stones, stones, blinks})
  end

  # Server Callbacks

  def init(_) do
    :ets.new(:memo_table, [:named_table, :public, read_concurrency: true])
    {:ok, %{}}
  end

  def handle_call({:sum_stones, stones, blinks}, _from, state) do
    result = sum_stones(stones, blinks)
    {:reply, result, state}
  end

  defp sum_stones([stone], blinks) do
    case :ets.lookup(:memo_table, {stone, blinks}) do
      [{_, result}] -> result
      [] ->
        result = if blinks == 0 do
          1
        else
          sum_stones(Problem11.mutate(stone), blinks - 1)
        end
        :ets.insert(:memo_table, {{stone, blinks}, result})
        result
    end
  end

  defp sum_stones([head | tail], blinks) do
    sum_stones([head], blinks) + sum_stones(tail, blinks)
  end
end
