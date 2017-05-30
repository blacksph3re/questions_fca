defmodule QuestionsFca.PageController do
  use QuestionsFca.Web, :controller

  alias QuestionsFca.Question  
  alias QuestionsFca.Answer
  alias QuestionsFca.Object
  alias QuestionsFca.Attribute
  alias QuestionsFca.Link

  def index(conn, _params) do
    render conn, "index.html"
  end

  def question(conn, %{"category" => category}) do
  	question = Question.defaultquestions()
  		|> Enum.filter(fn(x) -> 
  			{tmp, _} = Integer.parse(category)
  			tmp == x.category
  		end)
  		|> Enum.random
  		|> parsequestion
  		|> savequestion

  	answer = Answer.changeset(%Answer{question_id: question.id})

  	render(conn, "question.html", question: question, answer: answer)
  end

  def submitanswer(conn, %{"answer" => answer_params}) do
    changeset = Answer.changeset(%Answer{}, answer_params)

    case Repo.insert(changeset) do
      {:ok, answer} ->
      	answer
      	|> Repo.preload(:question)
      	|> Map.update!(:question, &preload_question_assoc(&1))
      	|> store_fca

        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Something went wrong :/")
        |> redirect(to: page_path(conn, :index))
    end
  end

  defp randobj do
  	Repo.all(Object)
  	|> Enum.random
  	|> Map.get(:name)
  end

  defp randattr do
  	Repo.all(Attribute)
  	|> Enum.random
  	|> Map.get(:name)
  end

  defp randimpl do
  	%{a: "asdasd", b: "asdasdasd"}
  end

  defp modifyquestion(question, param) do
  	case param do
  		{:obj, obj} ->
  			%{question | text: String.replace(question.text, "{randobj}", obj)}
  			|> Map.put(:obj, obj)
  		{:attr, attr} ->
  	  		%{question | text: String.replace(question.text, "{randattr}", attr)}
  	  		|> Map.put(:attr, attr)
  	  	{:impl, impl} ->
  	  		%{question | text: 
  	  			question.text 
  	  				|> String.replace("{randimpl_a}", impl.a)
  	  				|> String.replace("{randimpl_b}", impl.b)}
  	  		|> Map.put(:impl_a, impl.a)
  	  		|> Map.put(:impl_b, impl.b)
  	end
  end

  # Will add objects, attributes and implications to the question if they are requested in the question text
  # Will both replace the text and add it to the map
  defp parsequestion(question) do
  	cond do
  		String.contains? question.text, "{randobj}" ->
  			question |> modifyquestion({:obj, randobj()}) |> parsequestion
  		String.contains? question.text, "{randattr}" ->
  			question |> modifyquestion({:attr, randattr()}) |> parsequestion
  		String.contains?(question.text, "{randimpl_a}") && String.contains?(question.text, "{randimpl_b}") ->
  			question |> modifyquestion({:impl, randimpl()}) |> parsequestion
  		true ->
  			question
  	end
  end

  # Will store the question into db for further reference and add the id to the map
  defp savequestion(question) do
  	changeset = Question.changeset(%Question{}, question)

    case Repo.insert(changeset) do
      {:ok, question} ->
        question
      {:error, _changeset} ->
        raise "Could not save question"
    end
  end

  defp preload_question_assoc_obj(question) do
  	if question.obj do
  		query = from u in QuestionsFca.Object,
  			where: u.name == ^question.obj

  		%{question | obj: (Repo.all(query) |> Enum.at(0))}
  	else
  		question
  	end
  end

  defp preload_question_assoc_attr(question) do
  	if question.attr do
  		query = from u in QuestionsFca.Attribute,
  			where: u.name == ^question.attr

  		%{question | attr: (Repo.all(query) |> Enum.at(0))}
  	else
  		question
  	end
  end

  # Loads all associations for a question
  defp preload_question_assoc(question) do
  	question
  	|> preload_question_assoc_obj
  	|> preload_question_assoc_attr
  end

  # Store an answer with a fulfilled question
  defp store_assoc(answer, newvalue \\ true) do
  	if answer.question.obj && answer.question.attr do
  		query = from u in Link,
  			where: u.object_id == ^answer.question.obj.id and u.attribute_id == ^answer.question.attr.id
  		tmp = Repo.one(query)
  		if tmp == nil do
  			Repo.insert!(%Link{object_id: answer.question.obj.id, attribute_id: answer.question.attr.id, value: newvalue})
  		else
  			tmp 
  			|> Ecto.Changeset.change(value: newvalue)
  			|> Repo.update
  		end
  	end

  	answer
  end

  # Will store the answer in a fca way
  defp store_fca(answer) do
  	case answer.question.category do
  		0 ->
  			%{answer | question: %{answer.question | obj: Repo.insert!(%Object{name: answer.text})}} |> store_assoc
  		1 ->
  			%{answer | question: %{answer.question | attr: Repo.insert!(%Attribute{name: answer.text})}} |> store_assoc
  		2 ->
  			answer |> store_assoc(answer.text == "yes")
  		_ ->
  			answer |> IO.inspect
  	end
  end
end
