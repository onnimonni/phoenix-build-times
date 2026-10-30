defmodule Shop.Crm.CrmDelta do
  use Ecto.Schema
  import Ecto.Changeset

  schema "crm_deltas" do
    field(:title, :string)
    field(:body, :string)
    field(:price, :decimal)
    field(:quantity, :integer)
    field(:active, :boolean, default: false)
    field(:due_on, :date)
    field(:user_id, :id)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(crm_delta, attrs, user_scope) do
    crm_delta
    |> cast(attrs, [:title, :body, :price, :quantity, :active, :due_on])
    |> validate_required([:title, :body, :price, :quantity, :active, :due_on])
    |> put_change(:user_id, user_scope.user.id)
  end
end
