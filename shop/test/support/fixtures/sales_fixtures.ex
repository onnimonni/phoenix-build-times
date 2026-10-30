defmodule Shop.SalesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Sales` context.
  """

  @doc """
  Generate a sales_alpha.
  """
  def sales_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, sales_alpha} = Shop.Sales.create_sales_alpha(scope, attrs)
    sales_alpha
  end

  @doc """
  Generate a sales_bravo.
  """
  def sales_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, sales_bravo} = Shop.Sales.create_sales_bravo(scope, attrs)
    sales_bravo
  end

  @doc """
  Generate a sales_charlie.
  """
  def sales_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, sales_charlie} = Shop.Sales.create_sales_charlie(scope, attrs)
    sales_charlie
  end

  @doc """
  Generate a sales_delta.
  """
  def sales_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, sales_delta} = Shop.Sales.create_sales_delta(scope, attrs)
    sales_delta
  end

  @doc """
  Generate a sales_echo.
  """
  def sales_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, sales_echo} = Shop.Sales.create_sales_echo(scope, attrs)
    sales_echo
  end
end
