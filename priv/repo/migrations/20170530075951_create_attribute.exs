defmodule QuestionsFca.Repo.Migrations.CreateAttribute do
  use Ecto.Migration

  def change do
    create table(:attributes) do
      add :name, :string

      timestamps()
    end

  end
end
