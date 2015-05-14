defmodule FansWebsocket.GroupChannel do
  use Phoenix.Channel
  alias FansWebsocket.Repo
  alias FansWebsocket.AccessToken
  alias FansWebsocket.ChatMessage
  import Ecto.Query

  import Logger
  def join("groups:" <> group_id, %{"token" => token}, socket) do
    #Logger.info token
    query = from at in AccessToken, where: at.token == ^token, select: at
    result = Repo.all(query)
    at = List.first(result)
    cond do
      is_nil(at) ->
        :ignore
      at.active == true ->
        socket = assign(socket, :token, token)
        socket = assign(socket, :user_id, at.user_id)
        IO.puts socket.assigns[:token]
        IO.puts socket.assigns[:user_id]
        {:ok, socket}
      true ->
        :ignore
    end
  end

  #def join("groups:" <> _private_group_id, _auth_msg, socket) do
  #  :ignore
  #end

  def handle_in("new_msg", %{"data" => data}, socket) do
    IO.puts socket.assigns[:token]
    IO.puts socket.assigns[:user_id]
    content = data["content"]
    IO.puts content
    kind = data["kind"]
    IO.puts kind
    group_id = data["group_id"]
    IO.puts group_id
    # user_id = data["user_info"]["user_id"]
    user_id = socket.assigns[:user_id]
    IO.puts user_id
    IO.puts data["user_info"]["nickname"]
    IO.puts data["user_info"]["avatar_url"]

    message_params = %{
      chat_group_id: group_id,
      user_id: user_id,
      kind: 0,
      content: content,
      deleted: false
    }
    changeset = ChatMessage.changeset(%ChatMessage{}, message_params)
    #socket.assigns[:user_id] == data["user_info"]["user_id"] ->

    cond do
      changeset.valid? ->
        Repo.insert(changeset)
        broadcast! socket, "new_msg", %{data: data}
        {:noreply, socket}
      true ->
        {:noreply, socket}
    end
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

end
