defmodule PracLive.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def up do
    create table(:games) do
      add :name, :string

      timestamps()
    end
  end

  def down do
    drop table(:comments)
  end
end
