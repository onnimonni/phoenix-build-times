defmodule ShopWeb.EventsCharlieLiveTest do
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

  defp create_events_charlie(%{scope: scope}) do
    events_charlie = events_charlie_fixture(scope)

    %{events_charlie: events_charlie}
  end

  describe "Index" do
    setup [:create_events_charlie]

    test "lists all events_charlies", %{conn: conn, events_charlie: events_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/events_charlies")

      assert html =~ "Listing Events charlies"
      assert html =~ events_charlie.title
    end

    test "saves new events_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/events_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Events charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_charlies/new")

      assert render(form_live) =~ "New Events charlie"

      assert form_live
             |> form("#events_charlie-form", events_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_charlie-form", events_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_charlies")

      html = render(index_live)
      assert html =~ "Events charlie created successfully"
      assert html =~ "some title"
    end

    test "updates events_charlie in listing", %{conn: conn, events_charlie: events_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/events_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#events_charlies-#{events_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_charlies/#{events_charlie}/edit")

      assert render(form_live) =~ "Edit Events charlie"

      assert form_live
             |> form("#events_charlie-form", events_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_charlie-form", events_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_charlies")

      html = render(index_live)
      assert html =~ "Events charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes events_charlie in listing", %{conn: conn, events_charlie: events_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/events_charlies")

      assert index_live
             |> element("#events_charlies-#{events_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#events_charlies-#{events_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_events_charlie]

    test "displays events_charlie", %{conn: conn, events_charlie: events_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/events_charlies/#{events_charlie}")

      assert html =~ "Show Events charlie"
      assert html =~ events_charlie.title
    end

    test "updates events_charlie and returns to show", %{
      conn: conn,
      events_charlie: events_charlie
    } do
      {:ok, show_live, _html} = live(conn, ~p"/events_charlies/#{events_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/events_charlies/#{events_charlie}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Events charlie"

      assert form_live
             |> form("#events_charlie-form", events_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#events_charlie-form", events_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_charlies/#{events_charlie}")

      html = render(show_live)
      assert html =~ "Events charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
