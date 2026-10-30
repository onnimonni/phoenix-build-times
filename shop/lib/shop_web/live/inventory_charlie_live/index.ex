defmodule ShopWeb.InventoryCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Inventory charlies
        <:actions>
          <.button variant="primary" navigate={~p"/inventory_charlies/new"}>
            <.icon name="hero-plus" /> New Inventory charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="inventory_charlies"
        rows={@streams.inventory_charlies}
        row_click={
          fn {_id, inventory_charlie} -> JS.navigate(~p"/inventory_charlies/#{inventory_charlie}") end
        }
      >
        <:col :let={{_id, inventory_charlie}} label="Title">{inventory_charlie.title}</:col>
        <:col :let={{_id, inventory_charlie}} label="Body">{inventory_charlie.body}</:col>
        <:col :let={{_id, inventory_charlie}} label="Price">{inventory_charlie.price}</:col>
        <:col :let={{_id, inventory_charlie}} label="Quantity">{inventory_charlie.quantity}</:col>
        <:col :let={{_id, inventory_charlie}} label="Active">{inventory_charlie.active}</:col>
        <:col :let={{_id, inventory_charlie}} label="Due on">{inventory_charlie.due_on}</:col>
        <:action :let={{_id, inventory_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/inventory_charlies/#{inventory_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/inventory_charlies/#{inventory_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, inventory_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: inventory_charlie.id}) |> hide("##{id}")}
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
      Inventory.subscribe_inventory_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Inventory charlies")
     |> stream(:inventory_charlies, list_inventory_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    inventory_charlie = Inventory.get_inventory_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Inventory.delete_inventory_charlie(socket.assigns.current_scope, inventory_charlie)

    {:noreply, stream_delete(socket, :inventory_charlies, inventory_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Inventory.InventoryCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :inventory_charlies, list_inventory_charlies(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_inventory_charlies(current_scope) do
    Inventory.list_inventory_charlies(current_scope)
  end
end
