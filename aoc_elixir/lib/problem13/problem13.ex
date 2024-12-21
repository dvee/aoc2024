defmodule Problem13 do
  # a [x1, y1]' + b [x2, y2]' = [c1 c2]
  # =>
  # D = (x1 * y2 - x2 * y1)
  # a = 1 / D * (y2 * c1 - x2 * c2)
  # b = 1/ D * ( -y1 * c1 + x1 * c2)

  def run1(input) do
    machines = parse_input(input)

    machines
    |> Enum.map(fn m ->
      case solve(m) do
        {:ok, {a, b}} -> 3 * a + b
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  def run2(input) do
    delta = 10_000_000_000_000

    machines =
      parse_input(input)
      |> Enum.map(fn {x1, y1, x2, y2, c1, c2} -> {x1, y1, x2, y2, c1 + delta, c2 + delta} end)

    machines
    |> Enum.map(fn m ->
      case solve(m) do
        {:ok, {a, b}} -> 3 * a + b
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  def parse_input(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_block(&1))
  end

  def parse_block(input) do
    regex =
      ~r/Button A: X\+(?<x1>\d+), Y\+(?<y1>\d+)\nButton B: X\+(?<x2>\d+), Y\+(?<y2>\d+)\nPrize: X=(?<c1>\d+), Y=(?<c2>\d+)/

    case Regex.named_captures(regex, input) do
      %{"x1" => x1, "y1" => y1, "x2" => x2, "y2" => y2, "c1" => c1, "c2" => c2} ->
        {String.to_integer(x1), String.to_integer(y1), String.to_integer(x2),
         String.to_integer(y2), String.to_integer(c1), String.to_integer(c2)}

      _ ->
        {:error, "Invalid input format"}
    end
  end

  def determinant({x1, y1, x2, y2, _, _}) do
    x1 * y2 - x2 * y1
  end

  def solve({x1, y1, x2, y2, c1, c2}) do
    d = determinant({x1, y1, x2, y2, c1, c2})
    n_a = y2 * c1 - x2 * c2
    n_b = -y1 * c1 + x1 * c2
    has_integer_solution = rem(n_a, d) == 0 and rem(n_b, d) == 0
    a = n_a / d
    b = n_b / d

    cond do
      has_integer_solution -> {:ok, {a, b}}
      d == 0 -> {:no_solution}
      true -> {:non_integer, {a, b}}
    end
  end
end
