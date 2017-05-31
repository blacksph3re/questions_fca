defmodule QuestionsFca.FcaController do
  use QuestionsFca.Web, :controller

  alias QuestionsFca.Object
  alias QuestionsFca.Attribute
  alias QuestionsFca.Link


  def index(conn, _params) do
    objects = Repo.all(Object)
    attributes = Repo.all(Attribute)
    links = Repo.all(Link)
    implications = calc_implications()
    render(conn, "index.html", objects: objects, attributes: attributes, links: links, implications: implications)
  end

  defp csv_text() do
    # TODO replace with join
    links = Repo.all(Link)
    objects = Repo.all(Object)
    attributes = Repo.all(Attribute)

    links
    |> Enum.filter(fn(x) -> x.value end)
    |> Enum.map(fn(x) -> [
      Enum.find(objects, fn(item) -> item.id == x.object_id end).name, 
      Enum.find(attributes, fn(item) -> item.id == x.attribute_id end).name
    ] end)
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end

  # Fetch implications from the clojure server and parse the answer
  def calc_implications() do
    socket = Socket.connect! "ws://localhost:4001"
    socket |> Socket.Web.send!({ :text, csv_text() })
    {:text, retval} = socket |> Socket.Web.recv!()
    socket |> Socket.Web.close()

    retval 
    |> String.split(~r{(\(.*?\))*?}, include_captures: true, trim: true)     # Divide into implications by ()
    |> Enum.map(fn(x) -> 
      x 
      |> String.split(~r{(\{.*?\})*?}, include_captures: true, trim: true)   # Split the sides of the implications
      |> Enum.filter(fn(x) -> String.length(x) > 1 end)
      |> Enum.map(fn(x) -> 
        x 
        |> String.slice(1..-2)
        |> String.split(~r{(\".*?\")*?}, include_captures: true, trim: true) # Split into the single attributes on each implication side
        |> Enum.filter(fn(x) -> String.length(x) > 1 end)
        |> Enum.map(fn(x) -> 
          x 
          |> String.slice(1..-2) 
        end)
      end)
    end)
    |> Enum.map(fn(x) -> %{first: Enum.at(x, 0), second: Enum.at(x, 1)} end)
  end

  def csv(conn, _params) do
    text conn, csv_text()
  end

end
