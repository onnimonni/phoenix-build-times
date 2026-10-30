defmodule ShopWeb.InventoryCharlieLiveTest do
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

  defp create_inventory_charlie(%{scope: scope}) do
    inventory_charlie = inventory_charlie_fixture(scope)

    %{inventory_charlie: inventory_charlie}
  end

  describe "Index" do
    setup [:create_inventory_charlie]

    test "lists all inventory_charlies", %{conn: conn, inventory_charlie: inventory_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/inventory_charlies")

      assert html =~ "Listing Inventory charlies"
      assert html =~ inventory_charlie.title
    end

    test "saves new inventory_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Inventory charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_charlies/new")

      assert render(form_live) =~ "New Inventory charlie"

      assert form_live
             |> form("#inventory_charlie-form", inventory_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_charlie-form", inventory_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_charlies")

      html = render(index_live)
      assert html =~ "Inventory charlie created successfully"
      assert html =~ "some title"
    end

    test "updates inventory_charlie in listing", %{
      conn: conn,
      inventory_charlie: inventory_charlie
    } do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#inventory_charlies-#{inventory_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_charlies/#{inventory_charlie}/edit")

      assert render(form_live) =~ "Edit Inventory charlie"

      assert form_live
             |> form("#inventory_charlie-form", inventory_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_charlie-form", inventory_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_charlies")

      html = render(index_live)
      assert html =~ "Inventory charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes inventory_charlie in listing", %{
      conn: conn,
      inventory_charlie: inventory_charlie
    } do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_charlies")

      assert index_live
             |> element("#inventory_charlies-#{inventory_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#inventory_charlies-#{inventory_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_inventory_charlie]

    test "displays inventory_charlie", %{conn: conn, inventory_charlie: inventory_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/inventory_charlies/#{inventory_charlie}")

      assert html =~ "Show Inventory charlie"
      assert html =~ inventory_charlie.title
    end

    test "updates inventory_charlie and returns to show", %{
      conn: conn,
      inventory_charlie: inventory_charlie
    } do
      {:ok, show_live, _html} = live(conn, ~p"/inventory_charlies/#{inventory_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/inventory_charlies/#{inventory_charlie}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Inventory charlie"

      assert form_live
             |> form("#inventory_charlie-form", inventory_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#inventory_charlie-form", inventory_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_charlies/#{inventory_charlie}")

      html = render(show_live)
      assert html =~ "Inventory charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
