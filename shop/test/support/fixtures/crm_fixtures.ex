defmodule Shop.CrmFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Crm` context.
  """

  @doc """
  Generate a crm_alpha.
  """
  def crm_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, crm_alpha} = Shop.Crm.create_crm_alpha(scope, attrs)
    crm_alpha
  end

  @doc """
  Generate a crm_bravo.
  """
  def crm_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, crm_bravo} = Shop.Crm.create_crm_bravo(scope, attrs)
    crm_bravo
  end

  @doc """
  Generate a crm_charlie.
  """
  def crm_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, crm_charlie} = Shop.Crm.create_crm_charlie(scope, attrs)
    crm_charlie
  end

  @doc """
  Generate a crm_delta.
  """
  def crm_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, crm_delta} = Shop.Crm.create_crm_delta(scope, attrs)
    crm_delta
  end

  @doc """
  Generate a crm_echo.
  """
  def crm_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, crm_echo} = Shop.Crm.create_crm_echo(scope, attrs)
    crm_echo
  end
end
