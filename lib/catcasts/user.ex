defmodule Catcasts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Catcasts.User


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :provider, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :provider])
    |> validate_required([:first_name, :last_name, :email, :provider])
  end
end
