defmodule LiveChess.Chess.Match do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "matches" do
    field :fen, :string
    field :black_player, :binary_id
    field :white_player, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:fen])
    |> validate_required([:fen])
  end
end
