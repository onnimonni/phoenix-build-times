defmodule ShopWeb.InventoryAlphaLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.InventoryFixtures

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

  defp create_inventory_alpha(%{scope: scope}) do
    inventory_alpha = inventory_alpha_fixture(scope)

    %{inventory_alpha: inventory_alpha}
  end

  describe "Index" do
    setup [:create_inventory_alpha]

    test "lists all inventory_alphas", %{conn: conn, inventory_alpha: inventory_alpha} do
      {:ok, _index_live, html} = live(conn, ~p"/inventory_alphas")

      assert html =~ "Listing Inventory alphas"
      assert html =~ inventory_alpha.title
    end

    test "saves new inventory_alpha", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_alphas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Inventory alpha")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_alphas/new")

      assert render(form_live) =~ "New Inventory alpha"

      assert form_live
             |> form("#inventory_alpha-form", inventory_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_alpha-form", inventory_alpha: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_alphas")

      html = render(index_live)
      assert html =~ "Inventory alpha created successfully"
      assert html =~ "some title"
    end

    test "updates inventory_alpha in listing", %{conn: conn, inventory_alpha: inventory_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_alphas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#inventory_alphas-#{inventory_alpha.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_alphas/#{inventory_alpha}/edit")

      assert render(form_live) =~ "Edit Inventory alpha"

      assert form_live
             |> form("#inventory_alpha-form", inventory_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_alpha-form", inventory_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_alphas")

      html = render(index_live)
      assert html =~ "Inventory alpha updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes inventory_alpha in listing", %{conn: conn, inventory_alpha: inventory_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_alphas")

      assert index_live
             |> element("#inventory_alphas-#{inventory_alpha.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#inventory_alphas-#{inventory_alpha.id}")
    end
  end

  describe "Show" do
    setup [:create_inventory_alpha]

    test "displays inventory_alpha", %{conn: conn, inventory_alpha: inventory_alpha} do
      {:ok, _show_live, html} = live(conn, ~p"/inventory_alphas/#{inventory_alpha}")

      assert html =~ "Show Inventory alpha"
      assert html =~ inventory_alpha.title
    end

    test "updates inventory_alpha and returns to show", %{
      conn: conn,
      inventory_alpha: inventory_alpha
    } do
      {:ok, show_live, _html} = live(conn, ~p"/inventory_alphas/#{inventory_alpha}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/inventory_alphas/#{inventory_alpha}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Inventory alpha"

      assert form_live
             |> form("#inventory_alpha-form", inventory_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#inventory_alpha-form", inventory_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_alphas/#{inventory_alpha}")

      html = render(show_live)
      assert html =~ "Inventory alpha updated successfully"
      assert html =~ "some updated title"
    end
  end
end
