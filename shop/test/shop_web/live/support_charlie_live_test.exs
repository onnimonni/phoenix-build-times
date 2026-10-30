defmodule ShopWeb.SupportCharlieLiveTest do
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

  defp create_support_charlie(%{scope: scope}) do
    support_charlie = support_charlie_fixture(scope)

    %{support_charlie: support_charlie}
  end

  describe "Index" do
    setup [:create_support_charlie]

    test "lists all support_charlies", %{conn: conn, support_charlie: support_charlie} do
      {:ok, _index_live, html} = live(conn, ~p"/support_charlies")

      assert html =~ "Listing Support charlies"
      assert html =~ support_charlie.title
    end

    test "saves new support_charlie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/support_charlies")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Support charlie")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_charlies/new")

      assert render(form_live) =~ "New Support charlie"

      assert form_live
             |> form("#support_charlie-form", support_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_charlie-form", support_charlie: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_charlies")

      html = render(index_live)
      assert html =~ "Support charlie created successfully"
      assert html =~ "some title"
    end

    test "updates support_charlie in listing", %{conn: conn, support_charlie: support_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/support_charlies")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#support_charlies-#{support_charlie.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_charlies/#{support_charlie}/edit")

      assert render(form_live) =~ "Edit Support charlie"

      assert form_live
             |> form("#support_charlie-form", support_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_charlie-form", support_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_charlies")

      html = render(index_live)
      assert html =~ "Support charlie updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes support_charlie in listing", %{conn: conn, support_charlie: support_charlie} do
      {:ok, index_live, _html} = live(conn, ~p"/support_charlies")

      assert index_live
             |> element("#support_charlies-#{support_charlie.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#support_charlies-#{support_charlie.id}")
    end
  end

  describe "Show" do
    setup [:create_support_charlie]

    test "displays support_charlie", %{conn: conn, support_charlie: support_charlie} do
      {:ok, _show_live, html} = live(conn, ~p"/support_charlies/#{support_charlie}")

      assert html =~ "Show Support charlie"
      assert html =~ support_charlie.title
    end

    test "updates support_charlie and returns to show", %{
      conn: conn,
      support_charlie: support_charlie
    } do
      {:ok, show_live, _html} = live(conn, ~p"/support_charlies/#{support_charlie}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(
                 conn,
                 ~p"/support_charlies/#{support_charlie}/edit?return_to=show"
               )

      assert render(form_live) =~ "Edit Support charlie"

      assert form_live
             |> form("#support_charlie-form", support_charlie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#support_charlie-form", support_charlie: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_charlies/#{support_charlie}")

      html = render(show_live)
      assert html =~ "Support charlie updated successfully"
      assert html =~ "some updated title"
    end
  end
end
