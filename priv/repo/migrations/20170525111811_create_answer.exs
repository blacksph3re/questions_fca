defmodule QuestionsFca.Repo.Migrations.CreateAnswer do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :text, :string
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end
    create index(:answers, [:question_id])

  end
end
