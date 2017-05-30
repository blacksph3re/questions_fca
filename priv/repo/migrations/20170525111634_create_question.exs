defmodule QuestionsFca.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :text, :string
      add :header, :string
      add :category, :integer
      add :attr, :string
      add :obj, :string
      add :impl_a, :string
      add :impl_b, :string

      timestamps()
    end

  end
end
