defmodule ShopWeb.EventsEchoLiveTest do
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

  defp create_events_echo(%{scope: scope}) do
    events_echo = events_echo_fixture(scope)

    %{events_echo: events_echo}
  end

  describe "Index" do
    setup [:create_events_echo]

    test "lists all events_echos", %{conn: conn, events_echo: events_echo} do
      {:ok, _index_live, html} = live(conn, ~p"/events_echos")

      assert html =~ "Listing Events echos"
      assert html =~ events_echo.title
    end

    test "saves new events_echo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/events_echos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Events echo")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_echos/new")

      assert render(form_live) =~ "New Events echo"

      assert form_live
             |> form("#events_echo-form", events_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_echo-form", events_echo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_echos")

      html = render(index_live)
      assert html =~ "Events echo created successfully"
      assert html =~ "some title"
    end

    test "updates events_echo in listing", %{conn: conn, events_echo: events_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/events_echos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#events_echos-#{events_echo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_echos/#{events_echo}/edit")

      assert render(form_live) =~ "Edit Events echo"

      assert form_live
             |> form("#events_echo-form", events_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_echo-form", events_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_echos")

      html = render(index_live)
      assert html =~ "Events echo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes events_echo in listing", %{conn: conn, events_echo: events_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/events_echos")

      assert index_live
             |> element("#events_echos-#{events_echo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#events_echos-#{events_echo.id}")
    end
  end

  describe "Show" do
    setup [:create_events_echo]

    test "displays events_echo", %{conn: conn, events_echo: events_echo} do
      {:ok, _show_live, html} = live(conn, ~p"/events_echos/#{events_echo}")

      assert html =~ "Show Events echo"
      assert html =~ events_echo.title
    end

    test "updates events_echo and returns to show", %{conn: conn, events_echo: events_echo} do
      {:ok, show_live, _html} = live(conn, ~p"/events_echos/#{events_echo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_echos/#{events_echo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Events echo"

      assert form_live
             |> form("#events_echo-form", events_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#events_echo-form", events_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_echos/#{events_echo}")

      html = render(show_live)
      assert html =~ "Events echo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
