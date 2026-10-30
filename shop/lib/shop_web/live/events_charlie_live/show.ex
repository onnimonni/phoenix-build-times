defmodule ShopWeb.EventsCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Events charlie {@events_charlie.id}
        <:subtitle>This is a events_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/events_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/events_charlies/#{@events_charlie}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit events_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@events_charlie.title}</:item>
        <:item title="Body">{@events_charlie.body}</:item>
        <:item title="Price">{@events_charlie.price}</:item>
        <:item title="Quantity">{@events_charlie.quantity}</:item>
        <:item title="Active">{@events_charlie.active}</:item>
        <:item title="Due on">{@events_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Events.subscribe_events_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Events charlie")
     |> assign(:events_charlie, Events.get_events_charlie!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Events.EventsCharlie{id: id} = events_charlie},
        %{assigns: %{events_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :events_charlie, events_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Events.EventsCharlie{id: id}},
        %{assigns: %{events_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current events_charlie was deleted.")
     |> push_navigate(to: ~p"/events_charlies")}
  end

  def handle_info({type, %Shop.Events.EventsCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
