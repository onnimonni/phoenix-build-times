defmodule Shop.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Content` context.
  """

  @doc """
  Generate a content_alpha.
  """
  def content_alpha_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, content_alpha} = Shop.Content.create_content_alpha(scope, attrs)
    content_alpha
  end

  @doc """
  Generate a content_bravo.
  """
  def content_bravo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, content_bravo} = Shop.Content.create_content_bravo(scope, attrs)
    content_bravo
  end

  @doc """
  Generate a content_charlie.
  """
  def content_charlie_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, content_charlie} = Shop.Content.create_content_charlie(scope, attrs)
    content_charlie
  end

  @doc """
  Generate a content_delta.
  """
  def content_delta_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, content_delta} = Shop.Content.create_content_delta(scope, attrs)
    content_delta
  end

  @doc """
  Generate a content_echo.
  """
  def content_echo_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        active: true,
        body: "some body",
        due_on: ~D[2026-10-29],
        price: "120.5",
        quantity: 42,
        title: "some title"
      })

    {:ok, content_echo} = Shop.Content.create_content_echo(scope, attrs)
    content_echo
  end
end
