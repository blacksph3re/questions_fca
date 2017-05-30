defmodule QuestionsFca.ObjectTest do
  use QuestionsFca.ModelCase

  alias QuestionsFca.Object

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Object.changeset(%Object{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Object.changeset(%Object{}, @invalid_attrs)
    refute changeset.valid?
  end
end
