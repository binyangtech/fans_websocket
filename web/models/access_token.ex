defmodule FansWebsocket.AccessToken do
  use FansWebsocket.Web, :model

  import Ecto.Query
  # create_table "access_tokens", force: :cascade do |t|
  #   t.integer  "user_id",    limit: 4
  #   t.string   "token",      limit: 255
  #   t.datetime "expired_at"
  #   t.boolean  "active",     limit: 1
  #   t.string   "creator_ip", limit: 255
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end
  schema "access_tokens" do
    field :user_id, :integer
    field :token, :string
    field :expired_at, :datetime
    field :active, :boolean 
    field :creator_ip, :string

  end

  @required_fields ~w(user_id token expired_at active)
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
