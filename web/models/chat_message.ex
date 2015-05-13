defmodule FansWebsocket.ChatMessage do
  use FansWebsocket.Web, :model

  # create_table "chat_messages", force: :cascade do |t|
  #   t.integer  "chat_group_id", limit: 4
  #   t.integer  "user_id",       limit: 4
  #   t.integer  "kind",          limit: 4
  #   t.text     "content",       limit: 65535
  #   t.boolean  "deleted",       limit: 1
  #   t.datetime "inserted_at",                 null: false
  #   t.datetime "updated_at"
  # end
  schema "chat_messages" do
    field :chat_group_id, :integer
    field :user_id, :integer
    field :kind, :integer
    field :content, :string
    field :deleted, :boolean

    timestamps
  end

  @required_fields ~w(content kind chat_group_id user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
