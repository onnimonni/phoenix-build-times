defmodule ShopWeb.SupportAlphaLiveTest do
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

  defp create_support_alpha(%{scope: scope}) do
    support_alpha = support_alpha_fixture(scope)

    %{support_alpha: support_alpha}
  end

  describe "Index" do
    setup [:create_support_alpha]

    test "lists all support_alphas", %{conn: conn, support_alpha: support_alpha} do
      {:ok, _index_live, html} = live(conn, ~p"/support_alphas")

      assert html =~ "Listing Support alphas"
      assert html =~ support_alpha.title
    end

    test "saves new support_alpha", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/support_alphas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Support alpha")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_alphas/new")

      assert render(form_live) =~ "New Support alpha"

      assert form_live
             |> form("#support_alpha-form", support_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_alpha-form", support_alpha: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_alphas")

      html = render(index_live)
      assert html =~ "Support alpha created successfully"
      assert html =~ "some title"
    end

    test "updates support_alpha in listing", %{conn: conn, support_alpha: support_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/support_alphas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#support_alphas-#{support_alpha.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_alphas/#{support_alpha}/edit")

      assert render(form_live) =~ "Edit Support alpha"

      assert form_live
             |> form("#support_alpha-form", support_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_alpha-form", support_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_alphas")

      html = render(index_live)
      assert html =~ "Support alpha updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes support_alpha in listing", %{conn: conn, support_alpha: support_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/support_alphas")

      assert index_live
             |> element("#support_alphas-#{support_alpha.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#support_alphas-#{support_alpha.id}")
    end
  end

  describe "Show" do
    setup [:create_support_alpha]

    test "displays support_alpha", %{conn: conn, support_alpha: support_alpha} do
      {:ok, _show_live, html} = live(conn, ~p"/support_alphas/#{support_alpha}")

      assert html =~ "Show Support alpha"
      assert html =~ support_alpha.title
    end

    test "updates support_alpha and returns to show", %{conn: conn, support_alpha: support_alpha} do
      {:ok, show_live, _html} = live(conn, ~p"/support_alphas/#{support_alpha}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_alphas/#{support_alpha}/edit?return_to=show")

      assert render(form_live) =~ "Edit Support alpha"

      assert form_live
             |> form("#support_alpha-form", support_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#support_alpha-form", support_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_alphas/#{support_alpha}")

      html = render(show_live)
      assert html =~ "Support alpha updated successfully"
      assert html =~ "some updated title"
    end
  end
end
