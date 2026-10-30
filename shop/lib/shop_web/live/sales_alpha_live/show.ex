defmodule ShopWeb.SalesAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Sales alpha {@sales_alpha.id}
        <:subtitle>This is a sales_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/sales_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/sales_alphas/#{@sales_alpha}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit sales_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@sales_alpha.title}</:item>
        <:item title="Body">{@sales_alpha.body}</:item>
        <:item title="Price">{@sales_alpha.price}</:item>
        <:item title="Quantity">{@sales_alpha.quantity}</:item>
        <:item title="Active">{@sales_alpha.active}</:item>
        <:item title="Due on">{@sales_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Sales.subscribe_sales_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Sales alpha")
     |> assign(:sales_alpha, Sales.get_sales_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Sales.SalesAlpha{id: id} = sales_alpha},
        %{assigns: %{sales_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :sales_alpha, sales_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Sales.SalesAlpha{id: id}},
        %{assigns: %{sales_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current sales_alpha was deleted.")
     |> push_navigate(to: ~p"/sales_alphas")}
  end

  def handle_info({type, %Shop.Sales.SalesAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
