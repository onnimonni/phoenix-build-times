defmodule Shop.Repo.Migrations.CreateInventoryEchos do
  use Ecto.Migration

  def change do
    create table(:inventory_echos) do
      add(:title, :string)
      add(:body, :text)
      add(:price, :decimal)
      add(:quantity, :integer)
      add(:active, :boolean, default: false, null: false)
      add(:due_on, :date)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:inventory_echos, [:user_id]))
  end
end
