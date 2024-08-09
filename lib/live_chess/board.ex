defmodule LiveChess.Board do
  @moduledoc """
  Board representation and operations.

  https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation
  """

  defstruct(
    pieces: [],
    turn: :white,
    allowed_castling: 0,
    en_passant_square: nil,
    half_move_clock: 0,
    move_number: 0
  )
end
