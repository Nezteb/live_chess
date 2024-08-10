defmodule LiveChess.ChessTest do
  use LiveChess.DataCase

  alias LiveChess.Chess

  describe "players" do
    alias LiveChess.Chess.Player

    import LiveChess.ChessFixtures

    @invalid_attrs %{lichess_id: nil, lichess_username: nil}

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Chess.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Chess.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{lichess_id: "some lichess_id", lichess_username: "some lichess_username"}

      assert {:ok, %Player{} = player} = Chess.create_player(valid_attrs)
      assert player.lichess_id == "some lichess_id"
      assert player.lichess_username == "some lichess_username"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chess.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()

      update_attrs = %{
        lichess_id: "some updated lichess_id",
        lichess_username: "some updated lichess_username"
      }

      assert {:ok, %Player{} = player} = Chess.update_player(player, update_attrs)
      assert player.lichess_id == "some updated lichess_id"
      assert player.lichess_username == "some updated lichess_username"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Chess.update_player(player, @invalid_attrs)
      assert player == Chess.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Chess.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Chess.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Chess.change_player(player)
    end
  end

  describe "matches" do
    alias LiveChess.Chess.Match

    import LiveChess.ChessFixtures

    @invalid_attrs %{fen: nil}

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Chess.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Chess.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      valid_attrs = %{fen: "some fen"}

      assert {:ok, %Match{} = match} = Chess.create_match(valid_attrs)
      assert match.fen == "some fen"
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chess.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      update_attrs = %{fen: "some updated fen"}

      assert {:ok, %Match{} = match} = Chess.update_match(match, update_attrs)
      assert match.fen == "some updated fen"
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Chess.update_match(match, @invalid_attrs)
      assert match == Chess.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Chess.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Chess.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Chess.change_match(match)
    end
  end
end
