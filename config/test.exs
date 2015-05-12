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
  adapter: Ecto.Adapters.MySQL,
  username: "admin",
  password: "admin",
  database: "fans_server_test",
  hostname: "localhost",
  size: 1,
  max_overflow: 0
