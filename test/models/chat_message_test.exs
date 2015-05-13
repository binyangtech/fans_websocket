defmodule FansWebsocket.ChatMessageTest do
  use FansWebsocket.ModelCase

  alias FansWebsocket.ChatMessage

  @valid_attrs %{content: "some content", kind: 42, chat_group_id: 1, user_id: 2}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ChatMessage.changeset(%ChatMessage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ChatMessage.changeset(%ChatMessage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
