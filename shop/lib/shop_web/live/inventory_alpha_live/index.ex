defmodule ShopWeb.InventoryAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Inventory alphas
        <:actions>
          <.button variant="primary" navigate={~p"/inventory_alphas/new"}>
            <.icon name="hero-plus" /> New Inventory alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="inventory_alphas"
        rows={@streams.inventory_alphas}
        row_click={
          fn {_id, inventory_alpha} -> JS.navigate(~p"/inventory_alphas/#{inventory_alpha}") end
        }
      >
        <:col :let={{_id, inventory_alpha}} label="Title">{inventory_alpha.title}</:col>
        <:col :let={{_id, inventory_alpha}} label="Body">{inventory_alpha.body}</:col>
        <:col :let={{_id, inventory_alpha}} label="Price">{inventory_alpha.price}</:col>
        <:col :let={{_id, inventory_alpha}} label="Quantity">{inventory_alpha.quantity}</:col>
        <:col :let={{_id, inventory_alpha}} label="Active">{inventory_alpha.active}</:col>
        <:col :let={{_id, inventory_alpha}} label="Due on">{inventory_alpha.due_on}</:col>
        <:action :let={{_id, inventory_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/inventory_alphas/#{inventory_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/inventory_alphas/#{inventory_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, inventory_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: inventory_alpha.id}) |> hide("##{id}")}
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
      Inventory.subscribe_inventory_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Inventory alphas")
     |> stream(:inventory_alphas, list_inventory_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    inventory_alpha = Inventory.get_inventory_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Inventory.delete_inventory_alpha(socket.assigns.current_scope, inventory_alpha)

    {:noreply, stream_delete(socket, :inventory_alphas, inventory_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Inventory.InventoryAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :inventory_alphas, list_inventory_alphas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_inventory_alphas(current_scope) do
    Inventory.list_inventory_alphas(current_scope)
  end
end
