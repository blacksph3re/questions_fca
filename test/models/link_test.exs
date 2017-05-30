defmodule QuestionsFca.LinkTest do
  use QuestionsFca.ModelCase

  alias QuestionsFca.Link

  @valid_attrs %{text: "some content", value: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Link.changeset(%Link{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Link.changeset(%Link{}, @invalid_attrs)
    refute changeset.valid?
  end
end
