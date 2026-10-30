defmodule ShopWeb.CatalogCharlieLiveTest do
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

  defp create_catalog_charlie(%{scope: scope}) do
    catalog_charlie = catalog_charlie_fixture(scope)

    %{catalog_charlie: catalog_charlie}
  end

  describe "Index" do
    setup [:create_catalog_charlie]

    test "lists all catalog_charlies", %{conn: conn, catalog_charlie: catalog_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/catalog_charlies")

      assert html =~ "Listing Catalog charlies"
      assert html =~ catalog_charlie.title
    end

    test "saves new catalog_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Catalog charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_charlies/new")

      assert render(form_live) =~ "New Catalog charlie"

      assert form_live
             |> form("#catalog_charlie-form", catalog_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_charlie-form", catalog_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_charlies")

      html = render(index_live)
      assert html =~ "Catalog charlie created successfully"
      assert html =~ "some title"
    end

    test "updates catalog_charlie in listing", %{conn: conn, catalog_charlie: catalog_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#catalog_charlies-#{catalog_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_charlies/#{catalog_charlie}/edit")

      assert render(form_live) =~ "Edit Catalog charlie"

      assert form_live
             |> form("#catalog_charlie-form", catalog_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_charlie-form", catalog_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_charlies")

      html = render(index_live)
      assert html =~ "Catalog charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes catalog_charlie in listing", %{conn: conn, catalog_charlie: catalog_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_charlies")

      assert index_live
             |> element("#catalog_charlies-#{catalog_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#catalog_charlies-#{catalog_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_catalog_charlie]

    test "displays catalog_charlie", %{conn: conn, catalog_charlie: catalog_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/catalog_charlies/#{catalog_charlie}")

      assert html =~ "Show Catalog charlie"
      assert html =~ catalog_charlie.title
    end

    test "updates catalog_charlie and returns to show", %{
      conn: conn,
      catalog_charlie: catalog_charlie
    } do
      {:ok, show_live, _html} = live(conn, ~p"/catalog_charlies/#{catalog_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/catalog_charlies/#{catalog_charlie}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Catalog charlie"

      assert form_live
             |> form("#catalog_charlie-form", catalog_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#catalog_charlie-form", catalog_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_charlies/#{catalog_charlie}")

      html = render(show_live)
      assert html =~ "Catalog charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
