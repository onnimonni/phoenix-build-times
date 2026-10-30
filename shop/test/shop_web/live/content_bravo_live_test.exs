defmodule ShopWeb.ContentBravoLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.ContentFixtures

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

  defp create_content_bravo(%{scope: scope}) do
    content_bravo = content_bravo_fixture(scope)

    %{content_bravo: content_bravo}
  end

  describe "Index" do
    setup [:create_content_bravo]

    test "lists all content_bravos", %{conn: conn, content_bravo: content_bravo} do
      {:ok, _index_live, html} = live(conn, ~p"/content_bravos")

      assert html =~ "Listing Content bravos"
      assert html =~ content_bravo.title
    end

    test "saves new content_bravo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/content_bravos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Content bravo")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_bravos/new")

      assert render(form_live) =~ "New Content bravo"

      assert form_live
             |> form("#content_bravo-form", content_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_bravo-form", content_bravo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_bravos")

      html = render(index_live)
      assert html =~ "Content bravo created successfully"
      assert html =~ "some title"
    end

    test "updates content_bravo in listing", %{conn: conn, content_bravo: content_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/content_bravos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#content_bravos-#{content_bravo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_bravos/#{content_bravo}/edit")

      assert render(form_live) =~ "Edit Content bravo"

      assert form_live
             |> form("#content_bravo-form", content_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_bravo-form", content_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_bravos")

      html = render(index_live)
      assert html =~ "Content bravo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes content_bravo in listing", %{conn: conn, content_bravo: content_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/content_bravos")

      assert index_live
             |> element("#content_bravos-#{content_bravo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#content_bravos-#{content_bravo.id}")
    end
  end

  describe "Show" do
    setup [:create_content_bravo]

    test "displays content_bravo", %{conn: conn, content_bravo: content_bravo} do
      {:ok, _show_live, html} = live(conn, ~p"/content_bravos/#{content_bravo}")

      assert html =~ "Show Content bravo"
      assert html =~ content_bravo.title
    end

    test "updates content_bravo and returns to show", %{conn: conn, content_bravo: content_bravo} do
      {:ok, show_live, _html} = live(conn, ~p"/content_bravos/#{content_bravo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_bravos/#{content_bravo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Content bravo"

      assert form_live
             |> form("#content_bravo-form", content_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#content_bravo-form", content_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_bravos/#{content_bravo}")

      html = render(show_live)
      assert html =~ "Content bravo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
