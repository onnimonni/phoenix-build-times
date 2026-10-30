defmodule ShopWeb.ContentDeltaLiveTest do
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

  defp create_content_delta(%{scope: scope}) do
    content_delta = content_delta_fixture(scope)

    %{content_delta: content_delta}
  end

  describe "Index" do
    setup [:create_content_delta]

    test "lists all content_deltas", %{conn: conn, content_delta: content_delta} do
      {:ok, _index_live, html} = live(conn, ~p"/content_deltas")

      assert html =~ "Listing Content deltas"
      assert html =~ content_delta.title
    end

    test "saves new content_delta", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/content_deltas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Content delta")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_deltas/new")

      assert render(form_live) =~ "New Content delta"

      assert form_live
             |> form("#content_delta-form", content_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_delta-form", content_delta: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_deltas")

      html = render(index_live)
      assert html =~ "Content delta created successfully"
      assert html =~ "some title"
    end

    test "updates content_delta in listing", %{conn: conn, content_delta: content_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/content_deltas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#content_deltas-#{content_delta.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_deltas/#{content_delta}/edit")

      assert render(form_live) =~ "Edit Content delta"

      assert form_live
             |> form("#content_delta-form", content_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_delta-form", content_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_deltas")

      html = render(index_live)
      assert html =~ "Content delta updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes content_delta in listing", %{conn: conn, content_delta: content_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/content_deltas")

      assert index_live
             |> element("#content_deltas-#{content_delta.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#content_deltas-#{content_delta.id}")
    end
  end

  describe "Show" do
    setup [:create_content_delta]

    test "displays content_delta", %{conn: conn, content_delta: content_delta} do
      {:ok, _show_live, html} = live(conn, ~p"/content_deltas/#{content_delta}")

      assert html =~ "Show Content delta"
      assert html =~ content_delta.title
    end

    test "updates content_delta and returns to show", %{conn: conn, content_delta: content_delta} do
      {:ok, show_live, _html} = live(conn, ~p"/content_deltas/#{content_delta}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_deltas/#{content_delta}/edit?return_to=show")

      assert render(form_live) =~ "Edit Content delta"

      assert form_live
             |> form("#content_delta-form", content_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#content_delta-form", content_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_deltas/#{content_delta}")

      html = render(show_live)
      assert html =~ "Content delta updated successfully"
      assert html =~ "some updated title"
    end
  end
end
