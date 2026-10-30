defmodule Shop.BillingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Billing` context.
  """

  @doc """
  Generate a billing_alpha.
  """
  def billing_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, billing_alpha} = Shop.Billing.create_billing_alpha(scope, attrs)
    billing_alpha
  end

  @doc """
  Generate a billing_bravo.
  """
  def billing_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, billing_bravo} = Shop.Billing.create_billing_bravo(scope, attrs)
    billing_bravo
  end

  @doc """
  Generate a billing_charlie.
  """
  def billing_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, billing_charlie} = Shop.Billing.create_billing_charlie(scope, attrs)
    billing_charlie
  end

  @doc """
  Generate a billing_delta.
  """
  def billing_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, billing_delta} = Shop.Billing.create_billing_delta(scope, attrs)
    billing_delta
  end

  @doc """
  Generate a billing_echo.
  """
  def billing_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, billing_echo} = Shop.Billing.create_billing_echo(scope, attrs)
    billing_echo
  end
end
