defmodule ShopWeb.EventsDeltaLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.EventsFixtures

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

  defp create_events_delta(%{scope: scope}) do
    events_delta = events_delta_fixture(scope)

    %{events_delta: events_delta}
  end

  describe "Index" do
    setup [:create_events_delta]

    test "lists all events_deltas", %{conn: conn, events_delta: events_delta} do
      {:ok, _index_live, html} = live(conn, ~p"/events_deltas")

      assert html =~ "Listing Events deltas"
      assert html =~ events_delta.title
    end

    test "saves new events_delta", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/events_deltas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Events delta")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_deltas/new")

      assert render(form_live) =~ "New Events delta"

      assert form_live
             |> form("#events_delta-form", events_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_delta-form", events_delta: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_deltas")

      html = render(index_live)
      assert html =~ "Events delta created successfully"
      assert html =~ "some title"
    end

    test "updates events_delta in listing", %{conn: conn, events_delta: events_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/events_deltas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#events_deltas-#{events_delta.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_deltas/#{events_delta}/edit")

      assert render(form_live) =~ "Edit Events delta"

      assert form_live
             |> form("#events_delta-form", events_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_delta-form", events_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_deltas")

      html = render(index_live)
      assert html =~ "Events delta updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes events_delta in listing", %{conn: conn, events_delta: events_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/events_deltas")

      assert index_live
             |> element("#events_deltas-#{events_delta.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#events_deltas-#{events_delta.id}")
    end
  end

  describe "Show" do
    setup [:create_events_delta]

    test "displays events_delta", %{conn: conn, events_delta: events_delta} do
      {:ok, _show_live, html} = live(conn, ~p"/events_deltas/#{events_delta}")

      assert html =~ "Show Events delta"
      assert html =~ events_delta.title
    end

    test "updates events_delta and returns to show", %{conn: conn, events_delta: events_delta} do
      {:ok, show_live, _html} = live(conn, ~p"/events_deltas/#{events_delta}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_deltas/#{events_delta}/edit?return_to=show")

      assert render(form_live) =~ "Edit Events delta"

      assert form_live
             |> form("#events_delta-form", events_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#events_delta-form", events_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_deltas/#{events_delta}")

      html = render(show_live)
      assert html =~ "Events delta updated successfully"
      assert html =~ "some updated title"
    end
  end
end
