defmodule ShopWeb.InventoryBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Inventory bravo {@inventory_bravo.id}
        <:subtitle>This is a inventory_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/inventory_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/inventory_bravos/#{@inventory_bravo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit inventory_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@inventory_bravo.title}</:item>
        <:item title="Body">{@inventory_bravo.body}</:item>
        <:item title="Price">{@inventory_bravo.price}</:item>
        <:item title="Quantity">{@inventory_bravo.quantity}</:item>
        <:item title="Active">{@inventory_bravo.active}</:item>
        <:item title="Due on">{@inventory_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Inventory.subscribe_inventory_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Inventory bravo")
     |> assign(:inventory_bravo, Inventory.get_inventory_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Inventory.InventoryBravo{id: id} = inventory_bravo},
        %{assigns: %{inventory_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :inventory_bravo, inventory_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Inventory.InventoryBravo{id: id}},
        %{assigns: %{inventory_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current inventory_bravo was deleted.")
     |> push_navigate(to: ~p"/inventory_bravos")}
  end

  def handle_info({type, %Shop.Inventory.InventoryBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
