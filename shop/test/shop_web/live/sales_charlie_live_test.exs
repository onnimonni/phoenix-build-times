defmodule ShopWeb.SalesCharlieLiveTest do
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

  defp create_sales_charlie(%{scope: scope}) do
    sales_charlie = sales_charlie_fixture(scope)

    %{sales_charlie: sales_charlie}
  end

  describe "Index" do
    setup [:create_sales_charlie]

    test "lists all sales_charlies", %{conn: conn, sales_charlie: sales_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/sales_charlies")

      assert html =~ "Listing Sales charlies"
      assert html =~ sales_charlie.title
    end

    test "saves new sales_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Sales charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_charlies/new")

      assert render(form_live) =~ "New Sales charlie"

      assert form_live
             |> form("#sales_charlie-form", sales_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#sales_charlie-form", sales_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_charlies")

      html = render(index_live)
      assert html =~ "Sales charlie created successfully"
      assert html =~ "some title"
    end

    test "updates sales_charlie in listing", %{conn: conn, sales_charlie: sales_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#sales_charlies-#{sales_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_charlies/#{sales_charlie}/edit")

      assert render(form_live) =~ "Edit Sales charlie"

      assert form_live
             |> form("#sales_charlie-form", sales_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#sales_charlie-form", sales_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_charlies")

      html = render(index_live)
      assert html =~ "Sales charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes sales_charlie in listing", %{conn: conn, sales_charlie: sales_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_charlies")

      assert index_live
             |> element("#sales_charlies-#{sales_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#sales_charlies-#{sales_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_sales_charlie]

    test "displays sales_charlie", %{conn: conn, sales_charlie: sales_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/sales_charlies/#{sales_charlie}")

      assert html =~ "Show Sales charlie"
      assert html =~ sales_charlie.title
    end

    test "updates sales_charlie and returns to show", %{conn: conn, sales_charlie: sales_charlie} do
      {:ok, show_live, _html} = live(conn, ~p"/sales_charlies/#{sales_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_charlies/#{sales_charlie}/edit?return_to=show")

      assert render(form_live) =~ "Edit Sales charlie"

      assert form_live
             |> form("#sales_charlie-form", sales_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#sales_charlie-form", sales_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_charlies/#{sales_charlie}")

      html = render(show_live)
      assert html =~ "Sales charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
