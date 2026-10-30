defmodule ShopWeb.ContentCharlieLiveTest do
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

  defp create_content_charlie(%{scope: scope}) do
    content_charlie = content_charlie_fixture(scope)

    %{content_charlie: content_charlie}
  end

  describe "Index" do
    setup [:create_content_charlie]

    test "lists all content_charlies", %{conn: conn, content_charlie: content_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/content_charlies")

      assert html =~ "Listing Content charlies"
      assert html =~ content_charlie.title
    end

    test "saves new content_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/content_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Content charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_charlies/new")

      assert render(form_live) =~ "New Content charlie"

      assert form_live
             |> form("#content_charlie-form", content_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_charlie-form", content_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_charlies")

      html = render(index_live)
      assert html =~ "Content charlie created successfully"
      assert html =~ "some title"
    end

    test "updates content_charlie in listing", %{conn: conn, content_charlie: content_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/content_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#content_charlies-#{content_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_charlies/#{content_charlie}/edit")

      assert render(form_live) =~ "Edit Content charlie"

      assert form_live
             |> form("#content_charlie-form", content_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_charlie-form", content_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_charlies")

      html = render(index_live)
      assert html =~ "Content charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes content_charlie in listing", %{conn: conn, content_charlie: content_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/content_charlies")

      assert index_live
             |> element("#content_charlies-#{content_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#content_charlies-#{content_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_content_charlie]

    test "displays content_charlie", %{conn: conn, content_charlie: content_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/content_charlies/#{content_charlie}")

      assert html =~ "Show Content charlie"
      assert html =~ content_charlie.title
    end

    test "updates content_charlie and returns to show", %{
      conn: conn,
      content_charlie: content_charlie
    } do
      {:ok, show_live, _html} = live(conn, ~p"/content_charlies/#{content_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/content_charlies/#{content_charlie}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Content charlie"

      assert form_live
             |> form("#content_charlie-form", content_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#content_charlie-form", content_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_charlies/#{content_charlie}")

      html = render(show_live)
      assert html =~ "Content charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
