defmodule ShopWeb.BillingCharlieLiveTest do
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

  defp create_billing_charlie(%{scope: scope}) do
    billing_charlie = billing_charlie_fixture(scope)

    %{billing_charlie: billing_charlie}
  end

  describe "Index" do
    setup [:create_billing_charlie]

    test "lists all billing_charlies", %{conn: conn, billing_charlie: billing_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/billing_charlies")

      assert html =~ "Listing Billing charlies"
      assert html =~ billing_charlie.title
    end

    test "saves new billing_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Billing charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_charlies/new")

      assert render(form_live) =~ "New Billing charlie"

      assert form_live
             |> form("#billing_charlie-form", billing_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#billing_charlie-form", billing_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_charlies")

      html = render(index_live)
      assert html =~ "Billing charlie created successfully"
      assert html =~ "some title"
    end

    test "updates billing_charlie in listing", %{conn: conn, billing_charlie: billing_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#billing_charlies-#{billing_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/billing_charlies/#{billing_charlie}/edit")

      assert render(form_live) =~ "Edit Billing charlie"

      assert form_live
             |> form("#billing_charlie-form", billing_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#billing_charlie-form", billing_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_charlies")

      html = render(index_live)
      assert html =~ "Billing charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes billing_charlie in listing", %{conn: conn, billing_charlie: billing_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/billing_charlies")

      assert index_live
             |> element("#billing_charlies-#{billing_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#billing_charlies-#{billing_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_billing_charlie]

    test "displays billing_charlie", %{conn: conn, billing_charlie: billing_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/billing_charlies/#{billing_charlie}")

      assert html =~ "Show Billing charlie"
      assert html =~ billing_charlie.title
    end

    test "updates billing_charlie and returns to show", %{
      conn: conn,
      billing_charlie: billing_charlie
    } do
      {:ok, show_live, _html} = live(conn, ~p"/billing_charlies/#{billing_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/billing_charlies/#{billing_charlie}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Billing charlie"

      assert form_live
             |> form("#billing_charlie-form", billing_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#billing_charlie-form", billing_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/billing_charlies/#{billing_charlie}")

      html = render(show_live)
      assert html =~ "Billing charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
