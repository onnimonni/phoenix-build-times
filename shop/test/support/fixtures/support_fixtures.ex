defmodule Shop.SupportFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Support` context.
  """

  @doc """
  Generate a support_alpha.
  """
  def support_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, support_alpha} = Shop.Support.create_support_alpha(scope, attrs)
    support_alpha
  end

  @doc """
  Generate a support_bravo.
  """
  def support_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, support_bravo} = Shop.Support.create_support_bravo(scope, attrs)
    support_bravo
  end

  @doc """
  Generate a support_charlie.
  """
  def support_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, support_charlie} = Shop.Support.create_support_charlie(scope, attrs)
    support_charlie
  end

  @doc """
  Generate a support_delta.
  """
  def support_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, support_delta} = Shop.Support.create_support_delta(scope, attrs)
    support_delta
  end

  @doc """
  Generate a support_echo.
  """
  def support_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, support_echo} = Shop.Support.create_support_echo(scope, attrs)
    support_echo
  end
end
