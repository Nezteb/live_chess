defmodule LiveChess.Chess.Player do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "players" do
    field :lichess_id, :string
    field :lichess_username, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:lichess_id, :lichess_username])
    |> validate_required([:lichess_id, :lichess_username])
  end
end
