defmodule ShopWeb.SalesEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Sales echo {@sales_echo.id}
        <:subtitle>This is a sales_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/sales_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/sales_echos/#{@sales_echo}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit sales_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@sales_echo.title}</:item>
        <:item title="Body">{@sales_echo.body}</:item>
        <:item title="Price">{@sales_echo.price}</:item>
        <:item title="Quantity">{@sales_echo.quantity}</:item>
        <:item title="Active">{@sales_echo.active}</:item>
        <:item title="Due on">{@sales_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Sales.subscribe_sales_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Sales echo")
     |> assign(:sales_echo, Sales.get_sales_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Sales.SalesEcho{id: id} = sales_echo},
        %{assigns: %{sales_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :sales_echo, sales_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Sales.SalesEcho{id: id}},
        %{assigns: %{sales_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current sales_echo was deleted.")
     |> push_navigate(to: ~p"/sales_echos")}
  end

  def handle_info({type, %Shop.Sales.SalesEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
