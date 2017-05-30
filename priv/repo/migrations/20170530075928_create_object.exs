defmodule QuestionsFca.Repo.Migrations.CreateObject do
  use Ecto.Migration

  def change do
    create table(:objects) do
      add :name, :string

      timestamps()
    end

  end
end
