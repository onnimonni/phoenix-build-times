defmodule Shop.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Catalog` context.
  """

  @doc """
  Generate a catalog_alpha.
  """
  def catalog_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, catalog_alpha} = Shop.Catalog.create_catalog_alpha(scope, attrs)
    catalog_alpha
  end

  @doc """
  Generate a catalog_bravo.
  """
  def catalog_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, catalog_bravo} = Shop.Catalog.create_catalog_bravo(scope, attrs)
    catalog_bravo
  end

  @doc """
  Generate a catalog_charlie.
  """
  def catalog_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, catalog_charlie} = Shop.Catalog.create_catalog_charlie(scope, attrs)
    catalog_charlie
  end

  @doc """
  Generate a catalog_delta.
  """
  def catalog_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, catalog_delta} = Shop.Catalog.create_catalog_delta(scope, attrs)
    catalog_delta
  end

  @doc """
  Generate a catalog_echo.
  """
  def catalog_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, catalog_echo} = Shop.Catalog.create_catalog_echo(scope, attrs)
    catalog_echo
  end
end
