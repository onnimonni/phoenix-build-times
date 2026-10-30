defmodule ShopWeb.SalesBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Sales bravos
        <:actions>
          <.button variant="primary" navigate={~p"/sales_bravos/new"}>
            <.icon name="hero-plus" /> New Sales bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="sales_bravos"
        rows={@streams.sales_bravos}
        row_click={fn {_id, sales_bravo} -> JS.navigate(~p"/sales_bravos/#{sales_bravo}") end}
      >
        <:col :let={{_id, sales_bravo}} label="Title">{sales_bravo.title}</:col>
        <:col :let={{_id, sales_bravo}} label="Body">{sales_bravo.body}</:col>
        <:col :let={{_id, sales_bravo}} label="Price">{sales_bravo.price}</:col>
        <:col :let={{_id, sales_bravo}} label="Quantity">{sales_bravo.quantity}</:col>
        <:col :let={{_id, sales_bravo}} label="Active">{sales_bravo.active}</:col>
        <:col :let={{_id, sales_bravo}} label="Due on">{sales_bravo.due_on}</:col>
        <:action :let={{_id, sales_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/sales_bravos/#{sales_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/sales_bravos/#{sales_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, sales_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: sales_bravo.id}) |> hide("##{id}")}
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
      Sales.subscribe_sales_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Sales bravos")
     |> stream(:sales_bravos, list_sales_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sales_bravo = Sales.get_sales_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Sales.delete_sales_bravo(socket.assigns.current_scope, sales_bravo)

    {:noreply, stream_delete(socket, :sales_bravos, sales_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Sales.SalesBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :sales_bravos, list_sales_bravos(socket.assigns.current_scope), reset: true)}
  end

  defp list_sales_bravos(current_scope) do
    Sales.list_sales_bravos(current_scope)
  end
end
