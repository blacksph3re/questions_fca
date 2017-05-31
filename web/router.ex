defmodule QuestionsFca.Router do
  use QuestionsFca.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuestionsFca do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/askme", PageController, :question
    post "/submitanswer", PageController, :submitanswer
    resources "/questions", QuestionController, only: [:index, :show, :delete]
    resources "/answers", AnswerController, only: [:index, :show, :delete]
    get "/fca", FcaController, :index
    get "/fca/table.csv", FcaController, :csv
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuestionsFca do
  #   pipe_through :api
  # end
end
