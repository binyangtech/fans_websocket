defmodule FansWebsocket.GroupChannel do
  use Phoenix.Channel
  alias FansWebsocket.Repo
  alias FansWebsocket.AccessToken
  alias FansWebsocket.ChatMessage
  alias FansWebsocket.User
  import Ecto.Query

  import Logger
  def join("groups:" <> group_id, %{"token" => token}, socket) do
    #Logger.info token
    query = from at in AccessToken, where: at.token == ^token, select: at
    result = Repo.all(query)
    at = List.first(result)
    cond do
      is_nil(at) ->
        reply = %{"error_message" => "Authentication Failed"}
        # :ignore
        {:error, reply}
      at.active == true ->
        user = Repo.get(User, at.user_id)
        IO.puts user.nickname
        IO.puts user.avatar_url
        socket = assign(socket, :token, token)
        socket = assign(socket, :user_id, at.user_id)
        socket = assign(socket, :nickname, user.nickname)
        socket = assign(socket, :avatar_url, user.avatar_url)
        send(self, :after_join)
        IO.puts socket.assigns[:token]
        IO.puts socket.assigns[:user_id]


        {:ok, socket}
      true ->
        # :ignore
        reply = %{"error_message" => "Authentication Failed"}
        {:error, reply}
    end
  end

  def handle_info(:after_join, socket) do
    # chat_messages = from(cm in ChatMessage, join: u in User, on: cm.user_id == u.id, select: [cm.inserted_at, cm.kind, cm.content, u.nickname, u.avatar_url], limit: 10, order_by: [desc: cm.inserted_at]) |> Repo.all()
    chat_messages = from(cm in ChatMessage, join: u in User, on: cm.user_id == u.id, select: %{user_id: u.id, nickname: u.nickname, avatar_url: u.avatar_url, kind: cm.kind, inserted_at: cm.inserted_at, content: cm.content}, limit: 10, order_by: [desc: cm.inserted_at]) |> Repo.all()
    push socket, "msg_feed", %{history_chat_messages: chat_messages}
    broadcast! socket, "user:joined", %{user_id: socket.assigns[:user_id], nickname: socket.assigns[:nickname], avatar_url: socket.assigns[:avatar_url]}
    {:noreply, socket}
  end

  def handle_in("phx_join", _, socket) do
    {:noreply, socket}
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

  def handle_out("user:joined", msg, socket) do
    push socket, "user:joined", msg
    {:noreply, socket}
  end

end
