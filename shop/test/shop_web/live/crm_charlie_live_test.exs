defmodule ShopWeb.CrmCharlieLiveTest do
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

  defp create_crm_charlie(%{scope: scope}) do
    crm_charlie = crm_charlie_fixture(scope)

    %{crm_charlie: crm_charlie}
  end

  describe "Index" do
    setup [:create_crm_charlie]

    test "lists all crm_charlies", %{conn: conn, crm_charlie: crm_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/crm_charlies")

      assert html =~ "Listing Crm charlies"
      assert html =~ crm_charlie.title
    end

    test "saves new crm_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Crm charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_charlies/new")

      assert render(form_live) =~ "New Crm charlie"

      assert form_live
             |> form("#crm_charlie-form", crm_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_charlie-form", crm_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_charlies")

      html = render(index_live)
      assert html =~ "Crm charlie created successfully"
      assert html =~ "some title"
    end

    test "updates crm_charlie in listing", %{conn: conn, crm_charlie: crm_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#crm_charlies-#{crm_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_charlies/#{crm_charlie}/edit")

      assert render(form_live) =~ "Edit Crm charlie"

      assert form_live
             |> form("#crm_charlie-form", crm_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_charlie-form", crm_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_charlies")

      html = render(index_live)
      assert html =~ "Crm charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes crm_charlie in listing", %{conn: conn, crm_charlie: crm_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_charlies")

      assert index_live
             |> element("#crm_charlies-#{crm_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#crm_charlies-#{crm_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_crm_charlie]

    test "displays crm_charlie", %{conn: conn, crm_charlie: crm_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/crm_charlies/#{crm_charlie}")

      assert html =~ "Show Crm charlie"
      assert html =~ crm_charlie.title
    end

    test "updates crm_charlie and returns to show", %{conn: conn, crm_charlie: crm_charlie} do
      {:ok, show_live, _html} = live(conn, ~p"/crm_charlies/#{crm_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_charlies/#{crm_charlie}/edit?return_to=show")

      assert render(form_live) =~ "Edit Crm charlie"

      assert form_live
             |> form("#crm_charlie-form", crm_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#crm_charlie-form", crm_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_charlies/#{crm_charlie}")

      html = render(show_live)
      assert html =~ "Crm charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
