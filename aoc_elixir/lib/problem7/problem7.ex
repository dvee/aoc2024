defmodule Problem7 do
  alias Problem7.Equation

  def run1(input) do
    parse_input(input)
    |> Enum.filter(&possibly_true?(&1))
    |> Enum.map(& &1.lhs)
    |> Enum.sum()
  end

  def run2(input) do
    parse_input(input)
    |> Enum.filter(&possibly_true?(&1, [:+, :*, :||]))
    |> Enum.map(& &1.lhs)
    |> Enum.sum()
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line ->
      [l, r] = String.split(line, ":")

      %Equation{
        lhs: String.to_integer(l),
        rhs: String.split(r, " ", trim: true) |> Enum.map(&String.to_integer/1)
      }
    end)
  end

  def possibly_true?(equation) do
    possibly_true?(equation, [:+, :*])
  end

  def possibly_true?(equation, operators) do
    possibly_true?(equation, 0, operators)
  end

  def possibly_true?(%Equation{lhs: lhs, rhs: [rhs_head | []]}, acc, operators) do
    Enum.any?(operators, fn op -> apply_operator(op, acc, rhs_head) == lhs end)
  end

  def possibly_true?(%Equation{lhs: lhs, rhs: [rhs_head | rhs_tail]}, acc, operators) do
    Enum.any?(operators, fn op ->
      acc_new = apply_operator(op, acc, rhs_head)

      if acc_new > lhs do
        false
      else
        possibly_true?(%Equation{lhs: lhs, rhs: rhs_tail}, acc_new, operators)
      end
    end)
  end

  def apply_operator(op, x, y) do
    case op do
      :+ -> x + y
      :* -> x * y
      :|| -> (Integer.to_string(x) <> Integer.to_string(y)) |> String.to_integer()
    end
  end
end
