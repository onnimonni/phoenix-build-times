defmodule Shop.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Events` context.
  """

  @doc """
  Generate a events_alpha.
  """
  def events_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, events_alpha} = Shop.Events.create_events_alpha(scope, attrs)
    events_alpha
  end

  @doc """
  Generate a events_bravo.
  """
  def events_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, events_bravo} = Shop.Events.create_events_bravo(scope, attrs)
    events_bravo
  end

  @doc """
  Generate a events_charlie.
  """
  def events_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, events_charlie} = Shop.Events.create_events_charlie(scope, attrs)
    events_charlie
  end

  @doc """
  Generate a events_delta.
  """
  def events_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, events_delta} = Shop.Events.create_events_delta(scope, attrs)
    events_delta
  end

  @doc """
  Generate a events_echo.
  """
  def events_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, events_echo} = Shop.Events.create_events_echo(scope, attrs)
    events_echo
  end
end
