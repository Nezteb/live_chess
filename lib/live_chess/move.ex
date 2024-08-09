defmodule LiveChess.Move do
  @moduledoc """
  Move representations and operations.
  """

  defstruct(
    from: nil,
    to: nil,
    new_position: nil,
    castling: false,
    taken: false
  )
end
