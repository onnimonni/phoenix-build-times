defmodule ShopWeb.InventoryBravoLiveTest do
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

  defp create_inventory_bravo(%{scope: scope}) do
    inventory_bravo = inventory_bravo_fixture(scope)

    %{inventory_bravo: inventory_bravo}
  end

  describe "Index" do
    setup [:create_inventory_bravo]

    test "lists all inventory_bravos", %{conn: conn, inventory_bravo: inventory_bravo} do
      {:ok, _index_live, html} = live(conn, ~p"/inventory_bravos")

      assert html =~ "Listing Inventory bravos"
      assert html =~ inventory_bravo.title
    end

    test "saves new inventory_bravo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_bravos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Inventory bravo")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_bravos/new")

      assert render(form_live) =~ "New Inventory bravo"

      assert form_live
             |> form("#inventory_bravo-form", inventory_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_bravo-form", inventory_bravo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_bravos")

      html = render(index_live)
      assert html =~ "Inventory bravo created successfully"
      assert html =~ "some title"
    end

    test "updates inventory_bravo in listing", %{conn: conn, inventory_bravo: inventory_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_bravos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#inventory_bravos-#{inventory_bravo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_bravos/#{inventory_bravo}/edit")

      assert render(form_live) =~ "Edit Inventory bravo"

      assert form_live
             |> form("#inventory_bravo-form", inventory_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_bravo-form", inventory_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_bravos")

      html = render(index_live)
      assert html =~ "Inventory bravo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes inventory_bravo in listing", %{conn: conn, inventory_bravo: inventory_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_bravos")

      assert index_live
             |> element("#inventory_bravos-#{inventory_bravo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#inventory_bravos-#{inventory_bravo.id}")
    end
  end

  describe "Show" do
    setup [:create_inventory_bravo]

    test "displays inventory_bravo", %{conn: conn, inventory_bravo: inventory_bravo} do
      {:ok, _show_live, html} = live(conn, ~p"/inventory_bravos/#{inventory_bravo}")

      assert html =~ "Show Inventory bravo"
      assert html =~ inventory_bravo.title
    end

    test "updates inventory_bravo and returns to show", %{
      conn: conn,
      inventory_bravo: inventory_bravo
    } do
      {:ok, show_live, _html} = live(conn, ~p"/inventory_bravos/#{inventory_bravo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/inventory_bravos/#{inventory_bravo}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Inventory bravo"

      assert form_live
             |> form("#inventory_bravo-form", inventory_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#inventory_bravo-form", inventory_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_bravos/#{inventory_bravo}")

      html = render(show_live)
      assert html =~ "Inventory bravo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
