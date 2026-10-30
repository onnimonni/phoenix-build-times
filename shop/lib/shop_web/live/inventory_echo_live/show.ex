defmodule ShopWeb.InventoryEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Inventory

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Inventory echo {@inventory_echo.id}
        <:subtitle>This is a inventory_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/inventory_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/inventory_echos/#{@inventory_echo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit inventory_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@inventory_echo.title}</:item>
        <:item title="Body">{@inventory_echo.body}</:item>
        <:item title="Price">{@inventory_echo.price}</:item>
        <:item title="Quantity">{@inventory_echo.quantity}</:item>
        <:item title="Active">{@inventory_echo.active}</:item>
        <:item title="Due on">{@inventory_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Inventory.subscribe_inventory_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Inventory echo")
     |> assign(:inventory_echo, Inventory.get_inventory_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Inventory.InventoryEcho{id: id} = inventory_echo},
        %{assigns: %{inventory_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :inventory_echo, inventory_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Inventory.InventoryEcho{id: id}},
        %{assigns: %{inventory_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current inventory_echo was deleted.")
     |> push_navigate(to: ~p"/inventory_echos")}
  end

  def handle_info({type, %Shop.Inventory.InventoryEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
