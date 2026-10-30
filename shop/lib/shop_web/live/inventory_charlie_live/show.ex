defmodule ShopWeb.InventoryCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Inventory charlie {@inventory_charlie.id}
        <:subtitle>This is a inventory_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/inventory_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/inventory_charlies/#{@inventory_charlie}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit inventory_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@inventory_charlie.title}</:item>
        <:item title="Body">{@inventory_charlie.body}</:item>
        <:item title="Price">{@inventory_charlie.price}</:item>
        <:item title="Quantity">{@inventory_charlie.quantity}</:item>
        <:item title="Active">{@inventory_charlie.active}</:item>
        <:item title="Due on">{@inventory_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Inventory.subscribe_inventory_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Inventory charlie")
     |> assign(
       :inventory_charlie,
       Inventory.get_inventory_charlie!(socket.assigns.current_scope, id)
     )}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Inventory.InventoryCharlie{id: id} = inventory_charlie},
        %{assigns: %{inventory_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :inventory_charlie, inventory_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Inventory.InventoryCharlie{id: id}},
        %{assigns: %{inventory_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current inventory_charlie was deleted.")
     |> push_navigate(to: ~p"/inventory_charlies")}
  end

  def handle_info({type, %Shop.Inventory.InventoryCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
