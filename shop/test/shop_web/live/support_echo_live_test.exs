defmodule ShopWeb.SupportEchoLiveTest do
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

  defp create_support_echo(%{scope: scope}) do
    support_echo = support_echo_fixture(scope)

    %{support_echo: support_echo}
  end

  describe "Index" do
    setup [:create_support_echo]

    test "lists all support_echos", %{conn: conn, support_echo: support_echo} do
      {:ok, _index_live, html} = live(conn, ~p"/support_echos")

      assert html =~ "Listing Support echos"
      assert html =~ support_echo.title
    end

    test "saves new support_echo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/support_echos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Support echo")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_echos/new")

      assert render(form_live) =~ "New Support echo"

      assert form_live
             |> form("#support_echo-form", support_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_echo-form", support_echo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_echos")

      html = render(index_live)
      assert html =~ "Support echo created successfully"
      assert html =~ "some title"
    end

    test "updates support_echo in listing", %{conn: conn, support_echo: support_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/support_echos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#support_echos-#{support_echo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_echos/#{support_echo}/edit")

      assert render(form_live) =~ "Edit Support echo"

      assert form_live
             |> form("#support_echo-form", support_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#support_echo-form", support_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_echos")

      html = render(index_live)
      assert html =~ "Support echo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes support_echo in listing", %{conn: conn, support_echo: support_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/support_echos")

      assert index_live
             |> element("#support_echos-#{support_echo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#support_echos-#{support_echo.id}")
    end
  end

  describe "Show" do
    setup [:create_support_echo]

    test "displays support_echo", %{conn: conn, support_echo: support_echo} do
      {:ok, _show_live, html} = live(conn, ~p"/support_echos/#{support_echo}")

      assert html =~ "Show Support echo"
      assert html =~ support_echo.title
    end

    test "updates support_echo and returns to show", %{conn: conn, support_echo: support_echo} do
      {:ok, show_live, _html} = live(conn, ~p"/support_echos/#{support_echo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/support_echos/#{support_echo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Support echo"

      assert form_live
             |> form("#support_echo-form", support_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#support_echo-form", support_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/support_echos/#{support_echo}")

      html = render(show_live)
      assert html =~ "Support echo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
