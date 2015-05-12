defmodule FansWebsocket.RoomChannel do
  use Phoenix.Channel
  alias FansWebsocket.Repo
  alias FansWebsocket.AccessToken
  import Ecto.Query

  import Logger
  def join("rooms:lobby", %{"token" => token}, socket) do
    #Logger.info token
    query = from at in AccessToken, where: at.token == ^token, select: at
    result = Repo.all(query)
    at = List.first(result)
    cond do
      is_nil(at) ->
        :ignore
      at.active == true ->
        {:ok, socket}
      true ->
        :ignore
    end
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    :ignore
  end

  def handle_in("new_msg", %{"data" => data}, socket) do
    broadcast! socket, "new_msg", %{data: data}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

end
