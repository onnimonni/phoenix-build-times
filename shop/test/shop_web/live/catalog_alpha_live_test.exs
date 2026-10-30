defmodule ShopWeb.CatalogAlphaLiveTest do
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

  defp create_catalog_alpha(%{scope: scope}) do
    catalog_alpha = catalog_alpha_fixture(scope)

    %{catalog_alpha: catalog_alpha}
  end

  describe "Index" do
    setup [:create_catalog_alpha]

    test "lists all catalog_alphas", %{conn: conn, catalog_alpha: catalog_alpha} do
      {:ok, _index_live, html} = live(conn, ~p"/catalog_alphas")

      assert html =~ "Listing Catalog alphas"
      assert html =~ catalog_alpha.title
    end

    test "saves new catalog_alpha", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_alphas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Catalog alpha")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_alphas/new")

      assert render(form_live) =~ "New Catalog alpha"

      assert form_live
             |> form("#catalog_alpha-form", catalog_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_alpha-form", catalog_alpha: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_alphas")

      html = render(index_live)
      assert html =~ "Catalog alpha created successfully"
      assert html =~ "some title"
    end

    test "updates catalog_alpha in listing", %{conn: conn, catalog_alpha: catalog_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_alphas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#catalog_alphas-#{catalog_alpha.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_alphas/#{catalog_alpha}/edit")

      assert render(form_live) =~ "Edit Catalog alpha"

      assert form_live
             |> form("#catalog_alpha-form", catalog_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#catalog_alpha-form", catalog_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_alphas")

      html = render(index_live)
      assert html =~ "Catalog alpha updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes catalog_alpha in listing", %{conn: conn, catalog_alpha: catalog_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/catalog_alphas")

      assert index_live
             |> element("#catalog_alphas-#{catalog_alpha.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#catalog_alphas-#{catalog_alpha.id}")
    end
  end

  describe "Show" do
    setup [:create_catalog_alpha]

    test "displays catalog_alpha", %{conn: conn, catalog_alpha: catalog_alpha} do
      {:ok, _show_live, html} = live(conn, ~p"/catalog_alphas/#{catalog_alpha}")

      assert html =~ "Show Catalog alpha"
      assert html =~ catalog_alpha.title
    end

    test "updates catalog_alpha and returns to show", %{conn: conn, catalog_alpha: catalog_alpha} do
      {:ok, show_live, _html} = live(conn, ~p"/catalog_alphas/#{catalog_alpha}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/catalog_alphas/#{catalog_alpha}/edit?return_to=show")

      assert render(form_live) =~ "Edit Catalog alpha"

      assert form_live
             |> form("#catalog_alpha-form", catalog_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#catalog_alpha-form", catalog_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/catalog_alphas/#{catalog_alpha}")

      html = render(show_live)
      assert html =~ "Catalog alpha updated successfully"
      assert html =~ "some updated title"
    end
  end
end
