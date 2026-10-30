defmodule ShopWeb.InventoryEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Inventory echos
        <:actions>
          <.button variant="primary" navigate={~p"/inventory_echos/new"}>
            <.icon name="hero-plus" /> New Inventory echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="inventory_echos"
        rows={@streams.inventory_echos}
        row_click={
          fn {_id, inventory_echo} -> JS.navigate(~p"/inventory_echos/#{inventory_echo}") end
        }
      >
        <:col :let={{_id, inventory_echo}} label="Title">{inventory_echo.title}</:col>
        <:col :let={{_id, inventory_echo}} label="Body">{inventory_echo.body}</:col>
        <:col :let={{_id, inventory_echo}} label="Price">{inventory_echo.price}</:col>
        <:col :let={{_id, inventory_echo}} label="Quantity">{inventory_echo.quantity}</:col>
        <:col :let={{_id, inventory_echo}} label="Active">{inventory_echo.active}</:col>
        <:col :let={{_id, inventory_echo}} label="Due on">{inventory_echo.due_on}</:col>
        <:action :let={{_id, inventory_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/inventory_echos/#{inventory_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/inventory_echos/#{inventory_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, inventory_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: inventory_echo.id}) |> hide("##{id}")}
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
      Inventory.subscribe_inventory_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Inventory echos")
     |> stream(:inventory_echos, list_inventory_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    inventory_echo = Inventory.get_inventory_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Inventory.delete_inventory_echo(socket.assigns.current_scope, inventory_echo)

    {:noreply, stream_delete(socket, :inventory_echos, inventory_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Inventory.InventoryEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :inventory_echos, list_inventory_echos(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_inventory_echos(current_scope) do
    Inventory.list_inventory_echos(current_scope)
  end
end
