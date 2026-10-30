defmodule ShopWeb.SupportDeltaLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.SupportFixtures

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

  defp create_support_delta(%{scope: scope}) do
    support_delta = support_delta_fixture(scope)

    %{support_delta: support_delta}
  end

  describe "Index" do
    setup [:create_support_delta]

    test "lists all support_deltas", %{conn: conn, support_delta: support_delta} do
      {:ok, _index_live, html} = live(conn, ~p"/support_deltas")

      assert html =~ "Listing Support deltas"
      assert html =~ support_delta.title
    end

    test "saves new support_delta", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/support_deltas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Support delta")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_deltas/new")

      assert render(form_live) =~ "New Support delta"

      assert form_live
             |> form("#support_delta-form", support_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_delta-form", support_delta: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_deltas")

      html = render(index_live)
      assert html =~ "Support delta created successfully"
      assert html =~ "some title"
    end

    test "updates support_delta in listing", %{conn: conn, support_delta: support_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/support_deltas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#support_deltas-#{support_delta.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_deltas/#{support_delta}/edit")

      assert render(form_live) =~ "Edit Support delta"

      assert form_live
             |> form("#support_delta-form", support_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_delta-form", support_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_deltas")

      html = render(index_live)
      assert html =~ "Support delta updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes support_delta in listing", %{conn: conn, support_delta: support_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/support_deltas")

      assert index_live
             |> element("#support_deltas-#{support_delta.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#support_deltas-#{support_delta.id}")
    end
  end

  describe "Show" do
    setup [:create_support_delta]

    test "displays support_delta", %{conn: conn, support_delta: support_delta} do
      {:ok, _show_live, html} = live(conn, ~p"/support_deltas/#{support_delta}")

      assert html =~ "Show Support delta"
      assert html =~ support_delta.title
    end

    test "updates support_delta and returns to show", %{conn: conn, support_delta: support_delta} do
      {:ok, show_live, _html} = live(conn, ~p"/support_deltas/#{support_delta}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_deltas/#{support_delta}/edit?return_to=show")

      assert render(form_live) =~ "Edit Support delta"

      assert form_live
             |> form("#support_delta-form", support_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#support_delta-form", support_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_deltas/#{support_delta}")

      html = render(show_live)
      assert html =~ "Support delta updated successfully"
      assert html =~ "some updated title"
    end
  end
end
