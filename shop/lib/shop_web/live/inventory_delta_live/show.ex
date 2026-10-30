defmodule ShopWeb.InventoryDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Inventory delta {@inventory_delta.id}
        <:subtitle>This is a inventory_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/inventory_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/inventory_deltas/#{@inventory_delta}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit inventory_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@inventory_delta.title}</:item>
        <:item title="Body">{@inventory_delta.body}</:item>
        <:item title="Price">{@inventory_delta.price}</:item>
        <:item title="Quantity">{@inventory_delta.quantity}</:item>
        <:item title="Active">{@inventory_delta.active}</:item>
        <:item title="Due on">{@inventory_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Inventory.subscribe_inventory_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Inventory delta")
     |> assign(:inventory_delta, Inventory.get_inventory_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Inventory.InventoryDelta{id: id} = inventory_delta},
        %{assigns: %{inventory_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :inventory_delta, inventory_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Inventory.InventoryDelta{id: id}},
        %{assigns: %{inventory_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current inventory_delta was deleted.")
     |> push_navigate(to: ~p"/inventory_deltas")}
  end

  def handle_info({type, %Shop.Inventory.InventoryDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
