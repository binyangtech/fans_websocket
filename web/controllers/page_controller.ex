defmodule FansWebsocket.PageController do
  use FansWebsocket.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
