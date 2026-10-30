defmodule ShopWeb.ContentEchoLiveTest do
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

  defp create_content_echo(%{scope: scope}) do
    content_echo = content_echo_fixture(scope)

    %{content_echo: content_echo}
  end

  describe "Index" do
    setup [:create_content_echo]

    test "lists all content_echos", %{conn: conn, content_echo: content_echo} do
      {:ok, _index_live, html} = live(conn, ~p"/content_echos")

      assert html =~ "Listing Content echos"
      assert html =~ content_echo.title
    end

    test "saves new content_echo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/content_echos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Content echo")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_echos/new")

      assert render(form_live) =~ "New Content echo"

      assert form_live
             |> form("#content_echo-form", content_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_echo-form", content_echo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_echos")

      html = render(index_live)
      assert html =~ "Content echo created successfully"
      assert html =~ "some title"
    end

    test "updates content_echo in listing", %{conn: conn, content_echo: content_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/content_echos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#content_echos-#{content_echo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_echos/#{content_echo}/edit")

      assert render(form_live) =~ "Edit Content echo"

      assert form_live
             |> form("#content_echo-form", content_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#content_echo-form", content_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_echos")

      html = render(index_live)
      assert html =~ "Content echo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes content_echo in listing", %{conn: conn, content_echo: content_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/content_echos")

      assert index_live
             |> element("#content_echos-#{content_echo.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#content_echos-#{content_echo.id}")
    end
  end

  describe "Show" do
    setup [:create_content_echo]

    test "displays content_echo", %{conn: conn, content_echo: content_echo} do
      {:ok, _show_live, html} = live(conn, ~p"/content_echos/#{content_echo}")

      assert html =~ "Show Content echo"
      assert html =~ content_echo.title
    end

    test "updates content_echo and returns to show", %{conn: conn, content_echo: content_echo} do
      {:ok, show_live, _html} = live(conn, ~p"/content_echos/#{content_echo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/content_echos/#{content_echo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Content echo"

      assert form_live
             |> form("#content_echo-form", content_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#content_echo-form", content_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/content_echos/#{content_echo}")

      html = render(show_live)
      assert html =~ "Content echo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
