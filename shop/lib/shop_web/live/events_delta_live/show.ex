defmodule ShopWeb.EventsDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Events delta {@events_delta.id}
        <:subtitle>This is a events_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/events_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/events_deltas/#{@events_delta}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit events_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@events_delta.title}</:item>
        <:item title="Body">{@events_delta.body}</:item>
        <:item title="Price">{@events_delta.price}</:item>
        <:item title="Quantity">{@events_delta.quantity}</:item>
        <:item title="Active">{@events_delta.active}</:item>
        <:item title="Due on">{@events_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Events.subscribe_events_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Events delta")
     |> assign(:events_delta, Events.get_events_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Events.EventsDelta{id: id} = events_delta},
        %{assigns: %{events_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :events_delta, events_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Events.EventsDelta{id: id}},
        %{assigns: %{events_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current events_delta was deleted.")
     |> push_navigate(to: ~p"/events_deltas")}
  end

  def handle_info({type, %Shop.Events.EventsDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
