defmodule Problem9 do
  def run1(input) do
    input
    |> input_to_queue()
    |> compress(:queue.new())
    |> :queue.to_list()
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> x * i end)
    |> Enum.sum()
  end

  def run2(input) do
    l = input
    |> input_to_list()
    max_value = Enum.filter(l, &(&1 != '.')) |> Enum.max()

    l
    |> compress2(max_value)
    |> Enum.with_index()
    |> Enum.map(fn {x, i} ->
      if x == '.' do
        0
      else
        x * i
      end
    end)
    |> Enum.sum()
  end

  def speed_test(input) do
    l = input
    |> input_to_list()

    l
    |> compress2(100)
    |> Enum.with_index()
    |> Enum.map(fn {x, i} ->
      if x == '.' do
        0
      else
        x * i
      end
    end)
    |> Enum.sum()
  end

  def input_to_queue(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {x, i} ->
      case rem(i, 2) do
        0 -> List.duplicate(div(i, 2), x)
        1 -> List.duplicate('.', x)
      end
    end)
    |> :queue.from_list()
  end

  def input_to_list(input) do
    input_to_queue(input) |> :queue.to_list()
  end

  def compress(q_in, q_compressed) do
    case {:queue.peek(q_in), :queue.peek_r(q_in)} do
      {{:value, _l}, {:value, '.'}} -> compress(:queue.drop_r(q_in), q_compressed)
      {{:value, '.'}, {:value, r}} ->
        q_compressed = :queue.in(r, q_compressed)
        compress(q_in |> :queue.drop_r() |> :queue.drop(), q_compressed)
      {{:value, l}, {:value, _r}} ->
        q_compressed = :queue.in(l, q_compressed)
        compress(:queue.drop(q_in), q_compressed)
      {:empty, :empty} -> q_compressed
    end
  end

  def compress2(data, id) do
    # print the id to console
    IO.inspect(id)


    if id < 0 do
      data
    else
      block_index = Enum.find_index(data, &(&1 == id))
      block_size = Enum.count(data, &(&1 == id))

      free_block = free_blocks(data)
      |> Enum.find(fn x -> x[:block_size] >= block_size end)
      new_data = if free_block && free_block[:start_index] < block_index do
        move_block(data, {block_index, block_size}, free_block[:start_index])
      else
        data
      end
      compress2(new_data, id - 1)
    end
  end

  def free_blocks(data) do
    data
        |> Enum.with_index()
        |> Enum.chunk_while(
          nil,
          fn {x, i}, acc ->
            case {x, i, acc} do
              {'.', i, nil} -> {:cont, %{start_index: i, block_size: 1}}
              {'.', _i, acc} -> {:cont, Map.put(acc, :block_size, acc[:block_size] + 1)}
              {_, _i, nil} -> {:cont, nil}
              {_, _i, acc} -> {:cont, acc, nil}
            end
          end,
          fn acc -> {:cont, acc} end
        )
  end

  def move_block(data, {from_index, block_size}, to_index) do
    new_value = Enum.at(data, from_index)
    data
    |> Enum.with_index()
    |> Enum.map(fn {x, i} ->
      cond do
        i >= to_index and i < to_index + block_size -> new_value
        i >= from_index and i < from_index + block_size -> '.'
        true -> x
      end
    end)
  end
end
