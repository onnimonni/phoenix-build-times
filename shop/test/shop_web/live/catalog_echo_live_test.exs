defmodule ShopWeb.CatalogEchoLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.CatalogFixtures

  @create_attrs %{
    active: true,
    title: "some title",
    body: "some body",
    price: "120.5",
    quantity: 42,
    due_on: "2026-10-29"
  }
  @update_attrs %{
    active: false,
    title: "some updated title",
    body: "some updated body",
    price: "456.7",
    quantity: 43,
    due_on: "2026-10-30"
  }
  @invalid_attrs %{active: false, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

  setup :register_and_log_in_user

  defp create_catalog_echo(%{scope: scope}) do
    catalog_echo = catalog_echo_fixture(scope)

    %{catalog_echo: catalog_echo}
  end

  describe "Index" do
    setup [:create_catalog_echo]

    test "lists all catalog_echos", %{conn: conn, catalog_echo: catalog_echo} do
      {:ok, _index_live, html} = live(conn, ~p"/catalog_echos")

      assert html =~ "Listing Catalog echos"
      assert html =~ catalog_echo.title
    end

    test "saves new catalog_echo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_echos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Catalog echo")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_echos/new")

      assert render(form_live) =~ "New Catalog echo"

      assert form_live
             |> form("#catalog_echo-form", catalog_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_echo-form", catalog_echo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_echos")

      html = render(index_live)
      assert html =~ "Catalog echo created successfully"
      assert html =~ "some title"
    end

    test "updates catalog_echo in listing", %{conn: conn, catalog_echo: catalog_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_echos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#catalog_echos-#{catalog_echo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_echos/#{catalog_echo}/edit")

      assert render(form_live) =~ "Edit Catalog echo"

      assert form_live
             |> form("#catalog_echo-form", catalog_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_echo-form", catalog_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_echos")

      html = render(index_live)
      assert html =~ "Catalog echo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes catalog_echo in listing", %{conn: conn, catalog_echo: catalog_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_echos")

      assert index_live
             |> element("#catalog_echos-#{catalog_echo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#catalog_echos-#{catalog_echo.id}")
    end
  end

  describe "Show" do
    setup [:create_catalog_echo]

    test "displays catalog_echo", %{conn: conn, catalog_echo: catalog_echo} do
      {:ok, _show_live, html} = live(conn, ~p"/catalog_echos/#{catalog_echo}")

      assert html =~ "Show Catalog echo"
      assert html =~ catalog_echo.title
    end

    test "updates catalog_echo and returns to show", %{conn: conn, catalog_echo: catalog_echo} do
      {:ok, show_live, _html} = live(conn, ~p"/catalog_echos/#{catalog_echo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_echos/#{catalog_echo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Catalog echo"

      assert form_live
             |> form("#catalog_echo-form", catalog_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#catalog_echo-form", catalog_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_echos/#{catalog_echo}")

      html = render(show_live)
      assert html =~ "Catalog echo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
