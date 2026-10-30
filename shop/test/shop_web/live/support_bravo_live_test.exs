defmodule ShopWeb.SupportBravoLiveTest do
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

  defp create_support_bravo(%{scope: scope}) do
    support_bravo = support_bravo_fixture(scope)

    %{support_bravo: support_bravo}
  end

  describe "Index" do
    setup [:create_support_bravo]

    test "lists all support_bravos", %{conn: conn, support_bravo: support_bravo} do
      {:ok, _index_live, html} = live(conn, ~p"/support_bravos")

      assert html =~ "Listing Support bravos"
      assert html =~ support_bravo.title
    end

    test "saves new support_bravo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/support_bravos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Support bravo")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_bravos/new")

      assert render(form_live) =~ "New Support bravo"

      assert form_live
             |> form("#support_bravo-form", support_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_bravo-form", support_bravo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_bravos")

      html = render(index_live)
      assert html =~ "Support bravo created successfully"
      assert html =~ "some title"
    end

    test "updates support_bravo in listing", %{conn: conn, support_bravo: support_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/support_bravos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#support_bravos-#{support_bravo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_bravos/#{support_bravo}/edit")

      assert render(form_live) =~ "Edit Support bravo"

      assert form_live
             |> form("#support_bravo-form", support_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_bravo-form", support_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_bravos")

      html = render(index_live)
      assert html =~ "Support bravo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes support_bravo in listing", %{conn: conn, support_bravo: support_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/support_bravos")

      assert index_live
             |> element("#support_bravos-#{support_bravo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#support_bravos-#{support_bravo.id}")
    end
  end

  describe "Show" do
    setup [:create_support_bravo]

    test "displays support_bravo", %{conn: conn, support_bravo: support_bravo} do
      {:ok, _show_live, html} = live(conn, ~p"/support_bravos/#{support_bravo}")

      assert html =~ "Show Support bravo"
      assert html =~ support_bravo.title
    end

    test "updates support_bravo and returns to show", %{conn: conn, support_bravo: support_bravo} do
      {:ok, show_live, _html} = live(conn, ~p"/support_bravos/#{support_bravo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_bravos/#{support_bravo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Support bravo"

      assert form_live
             |> form("#support_bravo-form", support_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#support_bravo-form", support_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_bravos/#{support_bravo}")

      html = render(show_live)
      assert html =~ "Support bravo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
