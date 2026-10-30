defmodule ShopWeb.CrmAlphaLiveTest do
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

  defp create_crm_alpha(%{scope: scope}) do
    crm_alpha = crm_alpha_fixture(scope)

    %{crm_alpha: crm_alpha}
  end

  describe "Index" do
    setup [:create_crm_alpha]

    test "lists all crm_alphas", %{conn: conn, crm_alpha: crm_alpha} do
      {:ok, _index_live, html} = live(conn, ~p"/crm_alphas")

      assert html =~ "Listing Crm alphas"
      assert html =~ crm_alpha.title
    end

    test "saves new crm_alpha", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_alphas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Crm alpha")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_alphas/new")

      assert render(form_live) =~ "New Crm alpha"

      assert form_live
             |> form("#crm_alpha-form", crm_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_alpha-form", crm_alpha: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_alphas")

      html = render(index_live)
      assert html =~ "Crm alpha created successfully"
      assert html =~ "some title"
    end

    test "updates crm_alpha in listing", %{conn: conn, crm_alpha: crm_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_alphas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#crm_alphas-#{crm_alpha.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_alphas/#{crm_alpha}/edit")

      assert render(form_live) =~ "Edit Crm alpha"

      assert form_live
             |> form("#crm_alpha-form", crm_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_alpha-form", crm_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_alphas")

      html = render(index_live)
      assert html =~ "Crm alpha updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes crm_alpha in listing", %{conn: conn, crm_alpha: crm_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_alphas")

      assert index_live |> element("#crm_alphas-#{crm_alpha.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#crm_alphas-#{crm_alpha.id}")
    end
  end

  describe "Show" do
    setup [:create_crm_alpha]

    test "displays crm_alpha", %{conn: conn, crm_alpha: crm_alpha} do
      {:ok, _show_live, html} = live(conn, ~p"/crm_alphas/#{crm_alpha}")

      assert html =~ "Show Crm alpha"
      assert html =~ crm_alpha.title
    end

    test "updates crm_alpha and returns to show", %{conn: conn, crm_alpha: crm_alpha} do
      {:ok, show_live, _html} = live(conn, ~p"/crm_alphas/#{crm_alpha}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_alphas/#{crm_alpha}/edit?return_to=show")

      assert render(form_live) =~ "Edit Crm alpha"

      assert form_live
             |> form("#crm_alpha-form", crm_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#crm_alpha-form", crm_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_alphas/#{crm_alpha}")

      html = render(show_live)
      assert html =~ "Crm alpha updated successfully"
      assert html =~ "some updated title"
    end
  end
end
