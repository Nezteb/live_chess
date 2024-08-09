defmodule LiveChess.Game do
  @moduledoc """
  API for managing game state and turns.
  """

  defstruct(
    current_position: nil,
    history: [],
    status: :started,
    winner: nil,
    result: nil
  )
end
