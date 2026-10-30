defmodule ShopWeb.EventsEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Events echo {@events_echo.id}
        <:subtitle>This is a events_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/events_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/events_echos/#{@events_echo}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit events_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@events_echo.title}</:item>
        <:item title="Body">{@events_echo.body}</:item>
        <:item title="Price">{@events_echo.price}</:item>
        <:item title="Quantity">{@events_echo.quantity}</:item>
        <:item title="Active">{@events_echo.active}</:item>
        <:item title="Due on">{@events_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Events.subscribe_events_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Events echo")
     |> assign(:events_echo, Events.get_events_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Events.EventsEcho{id: id} = events_echo},
        %{assigns: %{events_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :events_echo, events_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Events.EventsEcho{id: id}},
        %{assigns: %{events_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current events_echo was deleted.")
     |> push_navigate(to: ~p"/events_echos")}
  end

  def handle_info({type, %Shop.Events.EventsEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
