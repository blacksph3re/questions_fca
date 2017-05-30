defmodule QuestionsFca.Question do
  use QuestionsFca.Web, :model

  schema "questions" do
    field :text, :string
    field :header, :string
    field :category, :integer
    field :attr, :string
    field :obj, :string
    field :impl_a, :string
    field :impl_b, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :header, :category, :attr, :obj, :impl_a, :impl_b])
    |> validate_required([:text, :header, :category])
  end

  def defaultquestions do
    [%{category: 0, header: "Object", text: "Name any object"},
     %{category: 0, header: "Object", text: "Name any object with the attribute {randattr}"},
     %{category: 1, header: "Attribute", text: "Name any attribute that you associate with the object {randobj}"},
     %{category: 2, header: "Relation", text: "Do you associate the attribute {randattr} with the object {randobj}? (yes/no)"},
     %{category: 3, header: "Implication", text: "Is it true that {randimpl_a} implies {randimpl_b}? If not, name an object that has the property {randimpl_a} but not {randimpl_b}."}]
  end
end
