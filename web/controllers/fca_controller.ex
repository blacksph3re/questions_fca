defmodule QuestionsFca.FcaController do
  use QuestionsFca.Web, :controller

  alias QuestionsFca.Object
  alias QuestionsFca.Attribute
  alias QuestionsFca.Link


  def index(conn, _params) do
    objects = Repo.all(Object)
    attributes = Repo.all(Attribute)
    links = Repo.all(Link)
    render(conn, "index.html", objects: objects, attributes: attributes, links: links)
  end

  def csv(conn, _params) do
    # TODO replace with join query
    links = Repo.all(Link)
    objects = Repo.all(Object)
    attributes = Repo.all(Attribute)

    csv_content = links
    |> Enum.filter(fn(x) -> x.value end)
    |> Enum.map(fn(x) -> [
      Enum.find(objects, fn(item) -> item.id == x.object_id end).name, 
      Enum.find(attributes, fn(item) -> item.id == x.attribute_id end).name
    ] end)
    |> CSV.encode
    |> Enum.to_list
    |> to_string

    text conn, csv_content
  end

end
