use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fans_websocket, FansWebsocket.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :fans_websocket, FansWebsocket.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "fans_websocket_test",
  size: 1,
  max_overflow: 0
