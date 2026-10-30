defmodule ShopWeb.SalesDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Sales delta {@sales_delta.id}
        <:subtitle>This is a sales_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/sales_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/sales_deltas/#{@sales_delta}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit sales_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@sales_delta.title}</:item>
        <:item title="Body">{@sales_delta.body}</:item>
        <:item title="Price">{@sales_delta.price}</:item>
        <:item title="Quantity">{@sales_delta.quantity}</:item>
        <:item title="Active">{@sales_delta.active}</:item>
        <:item title="Due on">{@sales_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Sales.subscribe_sales_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Sales delta")
     |> assign(:sales_delta, Sales.get_sales_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Sales.SalesDelta{id: id} = sales_delta},
        %{assigns: %{sales_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :sales_delta, sales_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Sales.SalesDelta{id: id}},
        %{assigns: %{sales_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current sales_delta was deleted.")
     |> push_navigate(to: ~p"/sales_deltas")}
  end

  def handle_info({type, %Shop.Sales.SalesDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
