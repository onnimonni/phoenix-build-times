defmodule ShopWeb.EventsAlphaLiveTest do
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

  defp create_events_alpha(%{scope: scope}) do
    events_alpha = events_alpha_fixture(scope)

    %{events_alpha: events_alpha}
  end

  describe "Index" do
    setup [:create_events_alpha]

    test "lists all events_alphas", %{conn: conn, events_alpha: events_alpha} do
      {:ok, _index_live, html} = live(conn, ~p"/events_alphas")

      assert html =~ "Listing Events alphas"
      assert html =~ events_alpha.title
    end

    test "saves new events_alpha", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/events_alphas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Events alpha")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_alphas/new")

      assert render(form_live) =~ "New Events alpha"

      assert form_live
             |> form("#events_alpha-form", events_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_alpha-form", events_alpha: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_alphas")

      html = render(index_live)
      assert html =~ "Events alpha created successfully"
      assert html =~ "some title"
    end

    test "updates events_alpha in listing", %{conn: conn, events_alpha: events_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/events_alphas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#events_alphas-#{events_alpha.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_alphas/#{events_alpha}/edit")

      assert render(form_live) =~ "Edit Events alpha"

      assert form_live
             |> form("#events_alpha-form", events_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#events_alpha-form", events_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_alphas")

      html = render(index_live)
      assert html =~ "Events alpha updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes events_alpha in listing", %{conn: conn, events_alpha: events_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/events_alphas")

      assert index_live
             |> element("#events_alphas-#{events_alpha.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#events_alphas-#{events_alpha.id}")
    end
  end

  describe "Show" do
    setup [:create_events_alpha]

    test "displays events_alpha", %{conn: conn, events_alpha: events_alpha} do
      {:ok, _show_live, html} = live(conn, ~p"/events_alphas/#{events_alpha}")

      assert html =~ "Show Events alpha"
      assert html =~ events_alpha.title
    end

    test "updates events_alpha and returns to show", %{conn: conn, events_alpha: events_alpha} do
      {:ok, show_live, _html} = live(conn, ~p"/events_alphas/#{events_alpha}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/events_alphas/#{events_alpha}/edit?return_to=show")

      assert render(form_live) =~ "Edit Events alpha"

      assert form_live
             |> form("#events_alpha-form", events_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#events_alpha-form", events_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/events_alphas/#{events_alpha}")

      html = render(show_live)
      assert html =~ "Events alpha updated successfully"
      assert html =~ "some updated title"
    end
  end
end
