defmodule ShopWeb.InventoryEchoLiveTest do
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

  defp create_inventory_echo(%{scope: scope}) do
    inventory_echo = inventory_echo_fixture(scope)

    %{inventory_echo: inventory_echo}
  end

  describe "Index" do
    setup [:create_inventory_echo]

    test "lists all inventory_echos", %{conn: conn, inventory_echo: inventory_echo} do
      {:ok, _index_live, html} = live(conn, ~p"/inventory_echos")

      assert html =~ "Listing Inventory echos"
      assert html =~ inventory_echo.title
    end

    test "saves new inventory_echo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_echos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Inventory echo")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_echos/new")

      assert render(form_live) =~ "New Inventory echo"

      assert form_live
             |> form("#inventory_echo-form", inventory_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_echo-form", inventory_echo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_echos")

      html = render(index_live)
      assert html =~ "Inventory echo created successfully"
      assert html =~ "some title"
    end

    test "updates inventory_echo in listing", %{conn: conn, inventory_echo: inventory_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_echos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#inventory_echos-#{inventory_echo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/inventory_echos/#{inventory_echo}/edit")

      assert render(form_live) =~ "Edit Inventory echo"

      assert form_live
             |> form("#inventory_echo-form", inventory_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#inventory_echo-form", inventory_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_echos")

      html = render(index_live)
      assert html =~ "Inventory echo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes inventory_echo in listing", %{conn: conn, inventory_echo: inventory_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/inventory_echos")

      assert index_live
             |> element("#inventory_echos-#{inventory_echo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#inventory_echos-#{inventory_echo.id}")
    end
  end

  describe "Show" do
    setup [:create_inventory_echo]

    test "displays inventory_echo", %{conn: conn, inventory_echo: inventory_echo} do
      {:ok, _show_live, html} = live(conn, ~p"/inventory_echos/#{inventory_echo}")

      assert html =~ "Show Inventory echo"
      assert html =~ inventory_echo.title
    end

    test "updates inventory_echo and returns to show", %{
      conn: conn,
      inventory_echo: inventory_echo
    } do
      {:ok, show_live, _html} = live(conn, ~p"/inventory_echos/#{inventory_echo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/inventory_echos/#{inventory_echo}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Inventory echo"

      assert form_live
             |> form("#inventory_echo-form", inventory_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#inventory_echo-form", inventory_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/inventory_echos/#{inventory_echo}")

      html = render(show_live)
      assert html =~ "Inventory echo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
