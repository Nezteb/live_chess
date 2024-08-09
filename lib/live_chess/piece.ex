defmodule LiveChess.Piece do
  @moduledoc """
  Logic for all piece-related operations.

  https://en.wikipedia.org/wiki/Algebraic_notation_(chess)
  """

  defstruct(
    color: nil,
    type: nil,
    square: nil
  )
end
