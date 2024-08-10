defmodule LiveChess.ChessFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveChess.Chess` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        lichess_id: "some lichess_id",
        lichess_username: "some lichess_username"
      })
      |> LiveChess.Chess.create_player()

    player
  end

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        fen: "some fen"
      })
      |> LiveChess.Chess.create_match()

    match
  end
end
