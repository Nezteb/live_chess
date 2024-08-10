defmodule LiveChess.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :lichess_id, :string
      add :lichess_username, :string

      timestamps(type: :utc_datetime)
    end
  end
end
