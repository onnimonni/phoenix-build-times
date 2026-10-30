defmodule ShopWeb.CatalogBravoLiveTest do
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

  defp create_catalog_bravo(%{scope: scope}) do
    catalog_bravo = catalog_bravo_fixture(scope)

    %{catalog_bravo: catalog_bravo}
  end

  describe "Index" do
    setup [:create_catalog_bravo]

    test "lists all catalog_bravos", %{conn: conn, catalog_bravo: catalog_bravo} do
      {:ok, _index_live, html} = live(conn, ~p"/catalog_bravos")

      assert html =~ "Listing Catalog bravos"
      assert html =~ catalog_bravo.title
    end

    test "saves new catalog_bravo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_bravos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Catalog bravo")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_bravos/new")

      assert render(form_live) =~ "New Catalog bravo"

      assert form_live
             |> form("#catalog_bravo-form", catalog_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_bravo-form", catalog_bravo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_bravos")

      html = render(index_live)
      assert html =~ "Catalog bravo created successfully"
      assert html =~ "some title"
    end

    test "updates catalog_bravo in listing", %{conn: conn, catalog_bravo: catalog_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_bravos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#catalog_bravos-#{catalog_bravo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_bravos/#{catalog_bravo}/edit")

      assert render(form_live) =~ "Edit Catalog bravo"

      assert form_live
             |> form("#catalog_bravo-form", catalog_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_bravo-form", catalog_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_bravos")

      html = render(index_live)
      assert html =~ "Catalog bravo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes catalog_bravo in listing", %{conn: conn, catalog_bravo: catalog_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_bravos")

      assert index_live
             |> element("#catalog_bravos-#{catalog_bravo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#catalog_bravos-#{catalog_bravo.id}")
    end
  end

  describe "Show" do
    setup [:create_catalog_bravo]

    test "displays catalog_bravo", %{conn: conn, catalog_bravo: catalog_bravo} do
      {:ok, _show_live, html} = live(conn, ~p"/catalog_bravos/#{catalog_bravo}")

      assert html =~ "Show Catalog bravo"
      assert html =~ catalog_bravo.title
    end

    test "updates catalog_bravo and returns to show", %{conn: conn, catalog_bravo: catalog_bravo} do
      {:ok, show_live, _html} = live(conn, ~p"/catalog_bravos/#{catalog_bravo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_bravos/#{catalog_bravo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Catalog bravo"

      assert form_live
             |> form("#catalog_bravo-form", catalog_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#catalog_bravo-form", catalog_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_bravos/#{catalog_bravo}")

      html = render(show_live)
      assert html =~ "Catalog bravo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
