defmodule Problem3 do
  def run1(input) do
    regex = ~r/mul\((\d{1,3}),(\d{1,3})\)/
    Regex.scan(regex, input)
    |> Enum.map(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.sum()
  end

  def run2(input) do
    active(input, 0)
  end

  def active(s, acc) do
    # find the contents of s upto the first occurence of "don't()"
    regex = ~r/(.*?)don't\(\)/s
    case Regex.run(regex, s) do
      nil -> acc + run1(s)
      [all, match] ->
        new_acc = acc + run1(match)
        remainder = String.replace_prefix(s, all, "")
        inactive(remainder, new_acc)
    end
  end

  def inactive(s, acc) do
    # find the contents of s upto the first occurence of "do()"
    regex = ~r/(.*?)do\(\)/s
    case Regex.run(regex, s) do
      nil -> acc
      [all, _match] ->
        remainder = String.replace_prefix(s, all, "")
        active(remainder, acc)
    end
  end
end
