defmodule ShopWeb.ContentAlphaLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.ContentFixtures

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

  defp create_content_alpha(%{scope: scope}) do
    content_alpha = content_alpha_fixture(scope)

    %{content_alpha: content_alpha}
  end

  describe "Index" do
    setup [:create_content_alpha]

    test "lists all content_alphas", %{conn: conn, content_alpha: content_alpha} do
      {:ok, _index_live, html} = live(conn, ~p"/content_alphas")

      assert html =~ "Listing Content alphas"
      assert html =~ content_alpha.title
    end

    test "saves new content_alpha", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/content_alphas")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Content alpha")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_alphas/new")

      assert render(form_live) =~ "New Content alpha"

      assert form_live
             |> form("#content_alpha-form", content_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_alpha-form", content_alpha: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_alphas")

      html = render(index_live)
      assert html =~ "Content alpha created successfully"
      assert html =~ "some title"
    end

    test "updates content_alpha in listing", %{conn: conn, content_alpha: content_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/content_alphas")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#content_alphas-#{content_alpha.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_alphas/#{content_alpha}/edit")

      assert render(form_live) =~ "Edit Content alpha"

      assert form_live
             |> form("#content_alpha-form", content_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_alpha-form", content_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_alphas")

      html = render(index_live)
      assert html =~ "Content alpha updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes content_alpha in listing", %{conn: conn, content_alpha: content_alpha} do
      {:ok, index_live, _html} = live(conn, ~p"/content_alphas")

      assert index_live
             |> element("#content_alphas-#{content_alpha.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#content_alphas-#{content_alpha.id}")
    end
  end

  describe "Show" do
    setup [:create_content_alpha]

    test "displays content_alpha", %{conn: conn, content_alpha: content_alpha} do
      {:ok, _show_live, html} = live(conn, ~p"/content_alphas/#{content_alpha}")

      assert html =~ "Show Content alpha"
      assert html =~ content_alpha.title
    end

    test "updates content_alpha and returns to show", %{conn: conn, content_alpha: content_alpha} do
      {:ok, show_live, _html} = live(conn, ~p"/content_alphas/#{content_alpha}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_alphas/#{content_alpha}/edit?return_to=show")

      assert render(form_live) =~ "Edit Content alpha"

      assert form_live
             |> form("#content_alpha-form", content_alpha: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#content_alpha-form", content_alpha: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_alphas/#{content_alpha}")

      html = render(show_live)
      assert html =~ "Content alpha updated successfully"
      assert html =~ "some updated title"
    end
  end
end
