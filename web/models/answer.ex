defmodule QuestionsFca.Answer do
  use QuestionsFca.Web, :model

  schema "answers" do
    field :text, :string
    belongs_to :question, QuestionsFca.Question

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :question_id])
    |> cast_assoc(:question)
    |> validate_required([:text])
  end
end
