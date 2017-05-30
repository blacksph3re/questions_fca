defmodule QuestionsFca.AttributeTest do
  use QuestionsFca.ModelCase

  alias QuestionsFca.Attribute

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Attribute.changeset(%Attribute{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Attribute.changeset(%Attribute{}, @invalid_attrs)
    refute changeset.valid?
  end
end
