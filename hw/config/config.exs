# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hw,
  ecto_repos: [Hw.Repo]

# Configures the endpoint
config :hw, Hw.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aXGnFSpJOegMVctbku3pJMcDKpAtEAYPmkE5V2UEKR4EKixgtuSvEeDW4Tzy0n4g",
  render_errors: [view: Hw.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hw.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
