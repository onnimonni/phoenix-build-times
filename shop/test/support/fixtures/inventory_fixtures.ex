defmodule Shop.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Inventory` context.
  """

  @doc """
  Generate a inventory_alpha.
  """
  def inventory_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, inventory_alpha} = Shop.Inventory.create_inventory_alpha(scope, attrs)
    inventory_alpha
  end

  @doc """
  Generate a inventory_bravo.
  """
  def inventory_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, inventory_bravo} = Shop.Inventory.create_inventory_bravo(scope, attrs)
    inventory_bravo
  end

  @doc """
  Generate a inventory_charlie.
  """
  def inventory_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, inventory_charlie} = Shop.Inventory.create_inventory_charlie(scope, attrs)
    inventory_charlie
  end

  @doc """
  Generate a inventory_delta.
  """
  def inventory_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, inventory_delta} = Shop.Inventory.create_inventory_delta(scope, attrs)
    inventory_delta
  end

  @doc """
  Generate a inventory_echo.
  """
  def inventory_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, inventory_echo} = Shop.Inventory.create_inventory_echo(scope, attrs)
    inventory_echo
  end
end
