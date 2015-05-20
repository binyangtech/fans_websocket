defmodule FansWebsocket.User do
  use FansWebsocket.Web, :model

  import Ecto.Query
  # create_table "users", force: :cascade do |t|
  #   t.string   "encrypted_password",     limit: 255, default: "",    null: false
  #   t.string   "password_salt",          limit: 255
  #   t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
  #   t.datetime "last_sign_in_at"
  #   t.string   "last_sign_in_ip",        limit: 255
  #   t.string   "nickname",               limit: 100,                 null: false
  #   t.string   "email",                  limit: 255
  #   t.string   "mobile",                 limit: 255,                 null: false
  #   t.string   "country_code",           limit: 255, default: "86",  null: false
  #   t.boolean  "admin",                  limit: 1,   default: false, null: false
  #   t.integer  "state",                  limit: 4,   default: 0
  #   t.string   "avatar_url",             limit: 255
  #   t.string   "reset_password_token",   limit: 255
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.datetime "current_sign_in_at"
  #   t.string   "current_sign_in_ip",     limit: 255
  #   t.integer  "app_id",                 limit: 4
  #   t.integer  "gender",                 limit: 4,   default: 0,     null: false
  #   t.string   "intro",                  limit: 255
  #   t.integer  "vip",                    limit: 4,   default: 0,     null: false
  #   t.integer  "status",                 limit: 4,   default: 1,     null: false
  #   t.string   "sid",                    limit: 255
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.boolean  "active",                 limit: 1
  #   t.string   "latitude",               limit: 255
  #   t.string   "longitude",              limit: 255
  #   t.integer  "city_id",                limit: 4
  #   t.string   "location",               limit: 255
  #   t.string   "wechat_location",        limit: 255
  #   t.integer  "display_id",             limit: 4
  # end
  schema "users" do
    field :nickname, :string
    field :avatar_url, :string

  end

  @required_fields ~w(nickname)
  @optional_fields ~w(avatar_url)

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
