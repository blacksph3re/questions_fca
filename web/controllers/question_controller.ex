defmodule QuestionsFca.QuestionController do
  use QuestionsFca.Web, :controller

  alias QuestionsFca.Question

  def index(conn, _params) do
    questions = Repo.all(Question)
    render(conn, "index.html", questions: questions)
  end

  def show(conn, %{"id" => id}) do
    question = Repo.get!(Question, id)
    render(conn, "show.html", question: question)
  end

  def delete(conn, %{"id" => id}) do
    question = Repo.get!(Question, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: question_path(conn, :index))
  end
end
