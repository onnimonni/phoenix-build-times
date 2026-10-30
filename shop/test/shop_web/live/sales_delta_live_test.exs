defmodule ShopWeb.SalesDeltaLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.SalesFixtures

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

  defp create_sales_delta(%{scope: scope}) do
    sales_delta = sales_delta_fixture(scope)

    %{sales_delta: sales_delta}
  end

  describe "Index" do
    setup [:create_sales_delta]

    test "lists all sales_deltas", %{conn: conn, sales_delta: sales_delta} do
      {:ok, _index_live, html} = live(conn, ~p"/sales_deltas")

      assert html =~ "Listing Sales deltas"
      assert html =~ sales_delta.title
    end

    test "saves new sales_delta", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_deltas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Sales delta")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_deltas/new")

      assert render(form_live) =~ "New Sales delta"

      assert form_live
             |> form("#sales_delta-form", sales_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#sales_delta-form", sales_delta: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_deltas")

      html = render(index_live)
      assert html =~ "Sales delta created successfully"
      assert html =~ "some title"
    end

    test "updates sales_delta in listing", %{conn: conn, sales_delta: sales_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_deltas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#sales_deltas-#{sales_delta.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_deltas/#{sales_delta}/edit")

      assert render(form_live) =~ "Edit Sales delta"

      assert form_live
             |> form("#sales_delta-form", sales_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#sales_delta-form", sales_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_deltas")

      html = render(index_live)
      assert html =~ "Sales delta updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes sales_delta in listing", %{conn: conn, sales_delta: sales_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_deltas")

      assert index_live
             |> element("#sales_deltas-#{sales_delta.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#sales_deltas-#{sales_delta.id}")
    end
  end

  describe "Show" do
    setup [:create_sales_delta]

    test "displays sales_delta", %{conn: conn, sales_delta: sales_delta} do
      {:ok, _show_live, html} = live(conn, ~p"/sales_deltas/#{sales_delta}")

      assert html =~ "Show Sales delta"
      assert html =~ sales_delta.title
    end

    test "updates sales_delta and returns to show", %{conn: conn, sales_delta: sales_delta} do
      {:ok, show_live, _html} = live(conn, ~p"/sales_deltas/#{sales_delta}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_deltas/#{sales_delta}/edit?return_to=show")

      assert render(form_live) =~ "Edit Sales delta"

      assert form_live
             |> form("#sales_delta-form", sales_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#sales_delta-form", sales_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_deltas/#{sales_delta}")

      html = render(show_live)
      assert html =~ "Sales delta updated successfully"
      assert html =~ "some updated title"
    end
  end
end
