defmodule QuestionsFca.Link do
  use QuestionsFca.Web, :model

  schema "links" do
    field :value, :boolean, default: false
    field :text, :string
    belongs_to :object, QuestionsFca.Object
    belongs_to :attribute, QuestionsFca.Attribute

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:value, :text, :object_id, :attribute_id])
    |> cast_assoc([:object, :attribute])
    |> validate_required([:value, :object, :attribute])
  end
end
