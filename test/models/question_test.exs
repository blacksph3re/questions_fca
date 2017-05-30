defmodule QuestionsFca.QuestionTest do
  use QuestionsFca.ModelCase

  alias QuestionsFca.Question

  @valid_attrs %{category: 42, header: "some content", text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Question.changeset(%Question{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Question.changeset(%Question{}, @invalid_attrs)
    refute changeset.valid?
  end
end
