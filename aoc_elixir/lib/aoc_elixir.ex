defmodule AocElixir do
  use Application

  def start(_type, _args) do
    IO.puts("starting")
    Supervisor.start_link([], strategy: :one_for_one)
  end
  def hello do
    IO.puts("1234")
    :world
  end
end
