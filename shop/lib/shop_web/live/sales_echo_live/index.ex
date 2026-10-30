defmodule ShopWeb.SalesEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Sales echos
        <:actions>
          <.button variant="primary" navigate={~p"/sales_echos/new"}>
            <.icon name="hero-plus" /> New Sales echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="sales_echos"
        rows={@streams.sales_echos}
        row_click={fn {_id, sales_echo} -> JS.navigate(~p"/sales_echos/#{sales_echo}") end}
      >
        <:col :let={{_id, sales_echo}} label="Title">{sales_echo.title}</:col>
        <:col :let={{_id, sales_echo}} label="Body">{sales_echo.body}</:col>
        <:col :let={{_id, sales_echo}} label="Price">{sales_echo.price}</:col>
        <:col :let={{_id, sales_echo}} label="Quantity">{sales_echo.quantity}</:col>
        <:col :let={{_id, sales_echo}} label="Active">{sales_echo.active}</:col>
        <:col :let={{_id, sales_echo}} label="Due on">{sales_echo.due_on}</:col>
        <:action :let={{_id, sales_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/sales_echos/#{sales_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/sales_echos/#{sales_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, sales_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: sales_echo.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Sales.subscribe_sales_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Sales echos")
     |> stream(:sales_echos, list_sales_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sales_echo = Sales.get_sales_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Sales.delete_sales_echo(socket.assigns.current_scope, sales_echo)

    {:noreply, stream_delete(socket, :sales_echos, sales_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Sales.SalesEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :sales_echos, list_sales_echos(socket.assigns.current_scope), reset: true)}
  end

  defp list_sales_echos(current_scope) do
    Sales.list_sales_echos(current_scope)
  end
end
