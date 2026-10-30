defmodule ShopWeb.EventsBravoLiveTest do
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

  defp create_events_bravo(%{scope: scope}) do
    events_bravo = events_bravo_fixture(scope)

    %{events_bravo: events_bravo}
  end

  describe "Index" do
    setup [:create_events_bravo]

    test "lists all events_bravos", %{conn: conn, events_bravo: events_bravo} do
      {:ok, _index_live, html} = live(conn, ~p"/events_bravos")

      assert html =~ "Listing Events bravos"
      assert html =~ events_bravo.title
    end

    test "saves new events_bravo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/events_bravos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Events bravo")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_bravos/new")

      assert render(form_live) =~ "New Events bravo"

      assert form_live
             |> form("#events_bravo-form", events_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_bravo-form", events_bravo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_bravos")

      html = render(index_live)
      assert html =~ "Events bravo created successfully"
      assert html =~ "some title"
    end

    test "updates events_bravo in listing", %{conn: conn, events_bravo: events_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/events_bravos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#events_bravos-#{events_bravo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_bravos/#{events_bravo}/edit")

      assert render(form_live) =~ "Edit Events bravo"

      assert form_live
             |> form("#events_bravo-form", events_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_bravo-form", events_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_bravos")

      html = render(index_live)
      assert html =~ "Events bravo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes events_bravo in listing", %{conn: conn, events_bravo: events_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/events_bravos")

      assert index_live
             |> element("#events_bravos-#{events_bravo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#events_bravos-#{events_bravo.id}")
    end
  end

  describe "Show" do
    setup [:create_events_bravo]

    test "displays events_bravo", %{conn: conn, events_bravo: events_bravo} do
      {:ok, _show_live, html} = live(conn, ~p"/events_bravos/#{events_bravo}")

      assert html =~ "Show Events bravo"
      assert html =~ events_bravo.title
    end

    test "updates events_bravo and returns to show", %{conn: conn, events_bravo: events_bravo} do
      {:ok, show_live, _html} = live(conn, ~p"/events_bravos/#{events_bravo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_bravos/#{events_bravo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Events bravo"

      assert form_live
             |> form("#events_bravo-form", events_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#events_bravo-form", events_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_bravos/#{events_bravo}")

      html = render(show_live)
      assert html =~ "Events bravo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
