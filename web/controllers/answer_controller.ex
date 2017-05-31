defmodule QuestionsFca.AnswerController do
  use QuestionsFca.Web, :controller

  alias QuestionsFca.Answer

  def index(conn, _params) do
    answers = Repo.all(Answer)
    render(conn, "index.html", answers: answers)
  end

  def show(conn, %{"id" => id}) do
    answer = Repo.get!(Answer, id)
    render(conn, "show.html", answer: answer)
  end

  def delete(conn, %{"id" => id}) do
    answer = Repo.get!(Answer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: answer_path(conn, :index))
  end
end
