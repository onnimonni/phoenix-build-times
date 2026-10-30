defmodule ShopWeb.SalesDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Sales deltas
        <:actions>
          <.button variant="primary" navigate={~p"/sales_deltas/new"}>
            <.icon name="hero-plus" /> New Sales delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="sales_deltas"
        rows={@streams.sales_deltas}
        row_click={fn {_id, sales_delta} -> JS.navigate(~p"/sales_deltas/#{sales_delta}") end}
      >
        <:col :let={{_id, sales_delta}} label="Title">{sales_delta.title}</:col>
        <:col :let={{_id, sales_delta}} label="Body">{sales_delta.body}</:col>
        <:col :let={{_id, sales_delta}} label="Price">{sales_delta.price}</:col>
        <:col :let={{_id, sales_delta}} label="Quantity">{sales_delta.quantity}</:col>
        <:col :let={{_id, sales_delta}} label="Active">{sales_delta.active}</:col>
        <:col :let={{_id, sales_delta}} label="Due on">{sales_delta.due_on}</:col>
        <:action :let={{_id, sales_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/sales_deltas/#{sales_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/sales_deltas/#{sales_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, sales_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: sales_delta.id}) |> hide("##{id}")}
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
      Sales.subscribe_sales_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Sales deltas")
     |> stream(:sales_deltas, list_sales_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sales_delta = Sales.get_sales_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Sales.delete_sales_delta(socket.assigns.current_scope, sales_delta)

    {:noreply, stream_delete(socket, :sales_deltas, sales_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Sales.SalesDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :sales_deltas, list_sales_deltas(socket.assigns.current_scope), reset: true)}
  end

  defp list_sales_deltas(current_scope) do
    Sales.list_sales_deltas(current_scope)
  end
end
