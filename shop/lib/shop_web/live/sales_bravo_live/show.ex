defmodule ShopWeb.SalesBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Sales bravo {@sales_bravo.id}
        <:subtitle>This is a sales_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/sales_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/sales_bravos/#{@sales_bravo}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit sales_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@sales_bravo.title}</:item>
        <:item title="Body">{@sales_bravo.body}</:item>
        <:item title="Price">{@sales_bravo.price}</:item>
        <:item title="Quantity">{@sales_bravo.quantity}</:item>
        <:item title="Active">{@sales_bravo.active}</:item>
        <:item title="Due on">{@sales_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Sales.subscribe_sales_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Sales bravo")
     |> assign(:sales_bravo, Sales.get_sales_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Sales.SalesBravo{id: id} = sales_bravo},
        %{assigns: %{sales_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :sales_bravo, sales_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Sales.SalesBravo{id: id}},
        %{assigns: %{sales_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current sales_bravo was deleted.")
     |> push_navigate(to: ~p"/sales_bravos")}
  end

  def handle_info({type, %Shop.Sales.SalesBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
