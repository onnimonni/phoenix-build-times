defmodule ShopWeb.CrmBravoLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.CrmFixtures

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

  defp create_crm_bravo(%{scope: scope}) do
    crm_bravo = crm_bravo_fixture(scope)

    %{crm_bravo: crm_bravo}
  end

  describe "Index" do
    setup [:create_crm_bravo]

    test "lists all crm_bravos", %{conn: conn, crm_bravo: crm_bravo} do
      {:ok, _index_live, html} = live(conn, ~p"/crm_bravos")

      assert html =~ "Listing Crm bravos"
      assert html =~ crm_bravo.title
    end

    test "saves new crm_bravo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_bravos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Crm bravo")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_bravos/new")

      assert render(form_live) =~ "New Crm bravo"

      assert form_live
             |> form("#crm_bravo-form", crm_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_bravo-form", crm_bravo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_bravos")

      html = render(index_live)
      assert html =~ "Crm bravo created successfully"
      assert html =~ "some title"
    end

    test "updates crm_bravo in listing", %{conn: conn, crm_bravo: crm_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_bravos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#crm_bravos-#{crm_bravo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_bravos/#{crm_bravo}/edit")

      assert render(form_live) =~ "Edit Crm bravo"

      assert form_live
             |> form("#crm_bravo-form", crm_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_bravo-form", crm_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_bravos")

      html = render(index_live)
      assert html =~ "Crm bravo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes crm_bravo in listing", %{conn: conn, crm_bravo: crm_bravo} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_bravos")

      assert index_live |> element("#crm_bravos-#{crm_bravo.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#crm_bravos-#{crm_bravo.id}")
    end
  end

  describe "Show" do
    setup [:create_crm_bravo]

    test "displays crm_bravo", %{conn: conn, crm_bravo: crm_bravo} do
      {:ok, _show_live, html} = live(conn, ~p"/crm_bravos/#{crm_bravo}")

      assert html =~ "Show Crm bravo"
      assert html =~ crm_bravo.title
    end

    test "updates crm_bravo and returns to show", %{conn: conn, crm_bravo: crm_bravo} do
      {:ok, show_live, _html} = live(conn, ~p"/crm_bravos/#{crm_bravo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_bravos/#{crm_bravo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Crm bravo"

      assert form_live
             |> form("#crm_bravo-form", crm_bravo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#crm_bravo-form", crm_bravo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_bravos/#{crm_bravo}")

      html = render(show_live)
      assert html =~ "Crm bravo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
