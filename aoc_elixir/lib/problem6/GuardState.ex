defmodule GuardState do
  @moduledoc """
  A struct representing the state of a guard.
  """

  @type direction :: :N | :E | :S | :W
  @type position :: {integer, integer}

  defstruct position: {0, 0}, direction: :N

  @type t :: %__MODULE__{
          position: position,
          direction: direction
        }
end
