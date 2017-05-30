# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :questions_fca,
  ecto_repos: [QuestionsFca.Repo]

# Configures the endpoint
config :questions_fca, QuestionsFca.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FCNtg8zT+ZWmeNgN/S9AVb32AC1bJWmXN30IE+iBIKp3/yGlgwHGi81yu6c2rJeV",
  render_errors: [view: QuestionsFca.ErrorView, accepts: ~w(html json)],
  pubsub: [name: QuestionsFca.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
