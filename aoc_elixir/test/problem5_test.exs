defmodule Problem5Test do
  use ExUnit.Case

  test "reads rules" do
    {:ok, input} = File.read("lib/problem5/input5_test.txt");
    rules = Problem5.read_rules(input)
    assert List.first(rules) == {47, 53}
    assert List.last(rules) == {53, 13}
  end

  test "reads udpates" do
    {:ok, input} = File.read("lib/problem5/input5_test.txt");
    updates = Problem5.read_updates(input)
    assert List.first(updates) == [75,47,61,53,29]
    assert List.last(updates) == [97,13,75,29,47]
  end

  test "validates a rule against an update" do
    rule = {47, 53}
    update = [75,47,61,53,29]
    assert Problem5.valid_rule?(rule, update) == true
    assert Problem5.valid_rule?({53, 13}, update) == true
    assert Problem5.valid_rule?({53, 61}, update) == false
    assert Problem5.valid_rule?({3, 2}, update) == true
  end

  test "runs on test input" do
    {:ok, input} = File.read("lib/problem5/input5_test.txt");
    assert Problem5.run1(input) == 143;
  end

  test "outputs part 1" do
    {:ok, input} = File.read("lib/problem5/input5.txt");
    IO.inspect Problem5.run1(input);
    assert true
  end

  test "is sorts by rules" do
    rules = [{47, 53}, {53, 13}]
    update = [13, 53,47,61,53,29]
    x = Problem5.sort_by_rules(rules, update)
    assert Problem5.sort_by_rules(rules, update) == [47, 53, 13, 61, 53, 29]
  end

  test "runs part 2 on test input" do
    {:ok, input} = File.read("lib/problem5/input5_test.txt");
    x = Problem5.run2(input)
    assert x == 123;
  end

  test "runs part 2" do
    {:ok, input} = File.read("lib/problem5/input5.txt");
    IO.inspect Problem5.run2(input);
    assert true
  end
end
