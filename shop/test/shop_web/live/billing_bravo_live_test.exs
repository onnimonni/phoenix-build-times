defmodule ShopWeb.BillingBravoLiveTest do
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

  defp create_billing_bravo(%{scope: scope}) do
    billing_bravo = billing_bravo_fixture(scope)

    %{billing_bravo: billing_bravo}
  end

  describe "Index" do
    setup [:create_billing_bravo]

    test "lists all billing_bravos", %{conn: conn, billing_bravo: billing_bravo} do
      {:ok, _index_live, html} = live(conn, ~p"/billing_bravos")

      assert html =~ "Listing Billing bravos"
      assert html =~ billing_bravo.title
    end

    test "saves new billing_bravo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_bravos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Billing bravo")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_bravos/new")

      assert render(form_live) =~ "New Billing bravo"

      assert form_live
             |> form("#billing_bravo-form", billing_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#billing_bravo-form", billing_bravo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_bravos")

      html = render(index_live)
      assert html =~ "Billing bravo created successfully"
      assert html =~ "some title"
    end

    test "updates billing_bravo in listing", %{conn: conn, billing_bravo: billing_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_bravos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#billing_bravos-#{billing_bravo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_bravos/#{billing_bravo}/edit")

      assert render(form_live) =~ "Edit Billing bravo"

      assert form_live
             |> form("#billing_bravo-form", billing_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#billing_bravo-form", billing_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_bravos")

      html = render(index_live)
      assert html =~ "Billing bravo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes billing_bravo in listing", %{conn: conn, billing_bravo: billing_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_bravos")

      assert index_live
             |> element("#billing_bravos-#{billing_bravo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#billing_bravos-#{billing_bravo.id}")
    end
  end

  describe "Show" do
    setup [:create_billing_bravo]

    test "displays billing_bravo", %{conn: conn, billing_bravo: billing_bravo} do
      {:ok, _show_live, html} = live(conn, ~p"/billing_bravos/#{billing_bravo}")

      assert html =~ "Show Billing bravo"
      assert html =~ billing_bravo.title
    end

    test "updates billing_bravo and returns to show", %{conn: conn, billing_bravo: billing_bravo} do
      {:ok, show_live, _html} = live(conn, ~p"/billing_bravos/#{billing_bravo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_bravos/#{billing_bravo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Billing bravo"

      assert form_live
             |> form("#billing_bravo-form", billing_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#billing_bravo-form", billing_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_bravos/#{billing_bravo}")

      html = render(show_live)
      assert html =~ "Billing bravo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
