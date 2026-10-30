defmodule ShopWeb.CrmEchoLiveTest do
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

  defp create_crm_echo(%{scope: scope}) do
    crm_echo = crm_echo_fixture(scope)

    %{crm_echo: crm_echo}
  end

  describe "Index" do
    setup [:create_crm_echo]

    test "lists all crm_echos", %{conn: conn, crm_echo: crm_echo} do
      {:ok, _index_live, html} = live(conn, ~p"/crm_echos")

      assert html =~ "Listing Crm echos"
      assert html =~ crm_echo.title
    end

    test "saves new crm_echo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_echos")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Crm echo")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_echos/new")

      assert render(form_live) =~ "New Crm echo"

      assert form_live
             |> form("#crm_echo-form", crm_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_echo-form", crm_echo: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_echos")

      html = render(index_live)
      assert html =~ "Crm echo created successfully"
      assert html =~ "some title"
    end

    test "updates crm_echo in listing", %{conn: conn, crm_echo: crm_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_echos")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#crm_echos-#{crm_echo.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_echos/#{crm_echo}/edit")

      assert render(form_live) =~ "Edit Crm echo"

      assert form_live
             |> form("#crm_echo-form", crm_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#crm_echo-form", crm_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_echos")

      html = render(index_live)
      assert html =~ "Crm echo updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes crm_echo in listing", %{conn: conn, crm_echo: crm_echo} do
      {:ok, index_live, _html} = live(conn, ~p"/crm_echos")

      assert index_live |> element("#crm_echos-#{crm_echo.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#crm_echos-#{crm_echo.id}")
    end
  end

  describe "Show" do
    setup [:create_crm_echo]

    test "displays crm_echo", %{conn: conn, crm_echo: crm_echo} do
      {:ok, _show_live, html} = live(conn, ~p"/crm_echos/#{crm_echo}")

      assert html =~ "Show Crm echo"
      assert html =~ crm_echo.title
    end

    test "updates crm_echo and returns to show", %{conn: conn, crm_echo: crm_echo} do
      {:ok, show_live, _html} = live(conn, ~p"/crm_echos/#{crm_echo}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/crm_echos/#{crm_echo}/edit?return_to=show")

      assert render(form_live) =~ "Edit Crm echo"

      assert form_live
             |> form("#crm_echo-form", crm_echo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#crm_echo-form", crm_echo: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/crm_echos/#{crm_echo}")

      html = render(show_live)
      assert html =~ "Crm echo updated successfully"
      assert html =~ "some updated title"
    end
  end
end
