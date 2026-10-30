defmodule ShopWeb.BillingDeltaLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.BillingFixtures

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

  defp create_billing_delta(%{scope: scope}) do
    billing_delta = billing_delta_fixture(scope)

    %{billing_delta: billing_delta}
  end

  describe "Index" do
    setup [:create_billing_delta]

    test "lists all billing_deltas", %{conn: conn, billing_delta: billing_delta} do
      {:ok, _index_live, html} = live(conn, ~p"/billing_deltas")

      assert html =~ "Listing Billing deltas"
      assert html =~ billing_delta.title
    end

    test "saves new billing_delta", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_deltas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Billing delta")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_deltas/new")

      assert render(form_live) =~ "New Billing delta"

      assert form_live
             |> form("#billing_delta-form", billing_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#billing_delta-form", billing_delta: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_deltas")

      html = render(index_live)
      assert html =~ "Billing delta created successfully"
      assert html =~ "some title"
    end

    test "updates billing_delta in listing", %{conn: conn, billing_delta: billing_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_deltas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#billing_deltas-#{billing_delta.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_deltas/#{billing_delta}/edit")

      assert render(form_live) =~ "Edit Billing delta"

      assert form_live
             |> form("#billing_delta-form", billing_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#billing_delta-form", billing_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_deltas")

      html = render(index_live)
      assert html =~ "Billing delta updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes billing_delta in listing", %{conn: conn, billing_delta: billing_delta} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_deltas")

      assert index_live
             |> element("#billing_deltas-#{billing_delta.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#billing_deltas-#{billing_delta.id}")
    end
  end

  describe "Show" do
    setup [:create_billing_delta]

    test "displays billing_delta", %{conn: conn, billing_delta: billing_delta} do
      {:ok, _show_live, html} = live(conn, ~p"/billing_deltas/#{billing_delta}")

      assert html =~ "Show Billing delta"
      assert html =~ billing_delta.title
    end

    test "updates billing_delta and returns to show", %{conn: conn, billing_delta: billing_delta} do
      {:ok, show_live, _html} = live(conn, ~p"/billing_deltas/#{billing_delta}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_deltas/#{billing_delta}/edit?return_to=show")

      assert render(form_live) =~ "Edit Billing delta"

      assert form_live
             |> form("#billing_delta-form", billing_delta: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#billing_delta-form", billing_delta: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_deltas/#{billing_delta}")

      html = render(show_live)
      assert html =~ "Billing delta updated successfully"
      assert html =~ "some updated title"
    end
  end
end
