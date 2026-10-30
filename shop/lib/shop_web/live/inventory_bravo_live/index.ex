defmodule ShopWeb.InventoryBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Inventory bravos
        <:actions>
          <.button variant="primary" navigate={~p"/inventory_bravos/new"}>
            <.icon name="hero-plus" /> New Inventory bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="inventory_bravos"
        rows={@streams.inventory_bravos}
        row_click={
          fn {_id, inventory_bravo} -> JS.navigate(~p"/inventory_bravos/#{inventory_bravo}") end
        }
      >
        <:col :let={{_id, inventory_bravo}} label="Title">{inventory_bravo.title}</:col>
        <:col :let={{_id, inventory_bravo}} label="Body">{inventory_bravo.body}</:col>
        <:col :let={{_id, inventory_bravo}} label="Price">{inventory_bravo.price}</:col>
        <:col :let={{_id, inventory_bravo}} label="Quantity">{inventory_bravo.quantity}</:col>
        <:col :let={{_id, inventory_bravo}} label="Active">{inventory_bravo.active}</:col>
        <:col :let={{_id, inventory_bravo}} label="Due on">{inventory_bravo.due_on}</:col>
        <:action :let={{_id, inventory_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/inventory_bravos/#{inventory_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/inventory_bravos/#{inventory_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, inventory_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: inventory_bravo.id}) |> hide("##{id}")}
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
      Inventory.subscribe_inventory_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Inventory bravos")
     |> stream(:inventory_bravos, list_inventory_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    inventory_bravo = Inventory.get_inventory_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Inventory.delete_inventory_bravo(socket.assigns.current_scope, inventory_bravo)

    {:noreply, stream_delete(socket, :inventory_bravos, inventory_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Inventory.InventoryBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :inventory_bravos, list_inventory_bravos(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_inventory_bravos(current_scope) do
    Inventory.list_inventory_bravos(current_scope)
  end
end
