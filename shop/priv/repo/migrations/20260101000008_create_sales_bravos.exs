defmodule Shop.Repo.Migrations.CreateSalesBravos do
  use Ecto.Migration

  def change do
    create table(:sales_bravos) do
      add(:title, :string)
      add(:body, :text)
      add(:price, :decimal)
      add(:quantity, :integer)
      add(:active, :boolean, default: false, null: false)
      add(:due_on, :date)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:sales_bravos, [:user_id]))
  end
end
