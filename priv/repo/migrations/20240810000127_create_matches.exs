defmodule LiveChess.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :fen, :string
      add :black_player, references(:players, on_delete: :nothing, type: :binary_id)
      add :white_player, references(:players, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:matches, [:black_player])
    create index(:matches, [:white_player])
  end
end
