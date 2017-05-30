defmodule QuestionsFca.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :value, :boolean, default: false, null: false
      add :text, :string
      add :object_id, references(:objects, on_delete: :nothing)
      add :attribute_id, references(:attributes, on_delete: :nothing)

      timestamps()
    end
    create index(:links, [:object_id])
    create index(:links, [:attribute_id])

  end
end
