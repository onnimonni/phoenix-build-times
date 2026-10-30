defmodule ShopWeb.SalesCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Sales charlie {@sales_charlie.id}
        <:subtitle>This is a sales_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/sales_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/sales_charlies/#{@sales_charlie}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit sales_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@sales_charlie.title}</:item>
        <:item title="Body">{@sales_charlie.body}</:item>
        <:item title="Price">{@sales_charlie.price}</:item>
        <:item title="Quantity">{@sales_charlie.quantity}</:item>
        <:item title="Active">{@sales_charlie.active}</:item>
        <:item title="Due on">{@sales_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Sales.subscribe_sales_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Sales charlie")
     |> assign(:sales_charlie, Sales.get_sales_charlie!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Sales.SalesCharlie{id: id} = sales_charlie},
        %{assigns: %{sales_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :sales_charlie, sales_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Sales.SalesCharlie{id: id}},
        %{assigns: %{sales_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current sales_charlie was deleted.")
     |> push_navigate(to: ~p"/sales_charlies")}
  end

  def handle_info({type, %Shop.Sales.SalesCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
