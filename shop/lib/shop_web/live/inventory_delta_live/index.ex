defmodule ShopWeb.InventoryDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Inventory deltas
        <:actions>
          <.button variant="primary" navigate={~p"/inventory_deltas/new"}>
            <.icon name="hero-plus" /> New Inventory delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="inventory_deltas"
        rows={@streams.inventory_deltas}
        row_click={
          fn {_id, inventory_delta} -> JS.navigate(~p"/inventory_deltas/#{inventory_delta}") end
        }
      >
        <:col :let={{_id, inventory_delta}} label="Title">{inventory_delta.title}</:col>
        <:col :let={{_id, inventory_delta}} label="Body">{inventory_delta.body}</:col>
        <:col :let={{_id, inventory_delta}} label="Price">{inventory_delta.price}</:col>
        <:col :let={{_id, inventory_delta}} label="Quantity">{inventory_delta.quantity}</:col>
        <:col :let={{_id, inventory_delta}} label="Active">{inventory_delta.active}</:col>
        <:col :let={{_id, inventory_delta}} label="Due on">{inventory_delta.due_on}</:col>
        <:action :let={{_id, inventory_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/inventory_deltas/#{inventory_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/inventory_deltas/#{inventory_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, inventory_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: inventory_delta.id}) |> hide("##{id}")}
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
      Inventory.subscribe_inventory_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Inventory deltas")
     |> stream(:inventory_deltas, list_inventory_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    inventory_delta = Inventory.get_inventory_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Inventory.delete_inventory_delta(socket.assigns.current_scope, inventory_delta)

    {:noreply, stream_delete(socket, :inventory_deltas, inventory_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Inventory.InventoryDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :inventory_deltas, list_inventory_deltas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_inventory_deltas(current_scope) do
    Inventory.list_inventory_deltas(current_scope)
  end
end
