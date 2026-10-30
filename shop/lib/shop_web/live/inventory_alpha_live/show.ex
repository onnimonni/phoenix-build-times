defmodule ShopWeb.InventoryAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Inventory alpha {@inventory_alpha.id}
        <:subtitle>This is a inventory_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/inventory_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/inventory_alphas/#{@inventory_alpha}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit inventory_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@inventory_alpha.title}</:item>
        <:item title="Body">{@inventory_alpha.body}</:item>
        <:item title="Price">{@inventory_alpha.price}</:item>
        <:item title="Quantity">{@inventory_alpha.quantity}</:item>
        <:item title="Active">{@inventory_alpha.active}</:item>
        <:item title="Due on">{@inventory_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Inventory.subscribe_inventory_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Inventory alpha")
     |> assign(:inventory_alpha, Inventory.get_inventory_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Inventory.InventoryAlpha{id: id} = inventory_alpha},
        %{assigns: %{inventory_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :inventory_alpha, inventory_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Inventory.InventoryAlpha{id: id}},
        %{assigns: %{inventory_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current inventory_alpha was deleted.")
     |> push_navigate(to: ~p"/inventory_alphas")}
  end

  def handle_info({type, %Shop.Inventory.InventoryAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
