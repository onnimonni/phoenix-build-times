defmodule ShopWeb.SalesAlphaLiveTest do
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

  defp create_sales_alpha(%{scope: scope}) do
    sales_alpha = sales_alpha_fixture(scope)

    %{sales_alpha: sales_alpha}
  end

  describe "Index" do
    setup [:create_sales_alpha]

    test "lists all sales_alphas", %{conn: conn, sales_alpha: sales_alpha} do
      {:ok, _index_live, html} = live(conn, ~p"/sales_alphas")

      assert html =~ "Listing Sales alphas"
      assert html =~ sales_alpha.title
    end

    test "saves new sales_alpha", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_alphas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Sales alpha")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_alphas/new")

      assert render(form_live) =~ "New Sales alpha"

      assert form_live
             |> form("#sales_alpha-form", sales_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#sales_alpha-form", sales_alpha: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_alphas")

      html = render(index_live)
      assert html =~ "Sales alpha created successfully"
      assert html =~ "some title"
    end

    test "updates sales_alpha in listing", %{conn: conn, sales_alpha: sales_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_alphas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#sales_alphas-#{sales_alpha.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_alphas/#{sales_alpha}/edit")

      assert render(form_live) =~ "Edit Sales alpha"

      assert form_live
             |> form("#sales_alpha-form", sales_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#sales_alpha-form", sales_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_alphas")

      html = render(index_live)
      assert html =~ "Sales alpha updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes sales_alpha in listing", %{conn: conn, sales_alpha: sales_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/sales_alphas")

      assert index_live
             |> element("#sales_alphas-#{sales_alpha.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#sales_alphas-#{sales_alpha.id}")
    end
  end

  describe "Show" do
    setup [:create_sales_alpha]

    test "displays sales_alpha", %{conn: conn, sales_alpha: sales_alpha} do
      {:ok, _show_live, html} = live(conn, ~p"/sales_alphas/#{sales_alpha}")

      assert html =~ "Show Sales alpha"
      assert html =~ sales_alpha.title
    end

    test "updates sales_alpha and returns to show", %{conn: conn, sales_alpha: sales_alpha} do
      {:ok, show_live, _html} = live(conn, ~p"/sales_alphas/#{sales_alpha}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/sales_alphas/#{sales_alpha}/edit?return_to=show")

      assert render(form_live) =~ "Edit Sales alpha"

      assert form_live
             |> form("#sales_alpha-form", sales_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#sales_alpha-form", sales_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/sales_alphas/#{sales_alpha}")

      html = render(show_live)
      assert html =~ "Sales alpha updated successfully"
      assert html =~ "some updated title"
    end
  end
end
