defmodule Shop.Repo.Migrations.CreateSupportAlphas do
  use Ecto.Migration

  def change do
    create table(:support_alphas) do
      add(:title, :string)
      add(:body, :text)
      add(:price, :decimal)
      add(:quantity, :integer)
      add(:active, :boolean, default: false, null: false)
      add(:due_on, :date)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:support_alphas, [:user_id]))
  end
end
