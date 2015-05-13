defmodule FansWebsocket.Router do
  use FansWebsocket.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FansWebsocket do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
  socket "/ws", FansWebsocket do
    channel "groups:*", GroupChannel #, via: [WebSocket]
    channel "news:*", NewsChannel #, via: [WebSocket]
  end
  # Other scopes may use custom stacks.
  # scope "/api", FansWebsocket do
  #   pipe_through :api
  # end
end
