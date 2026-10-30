defmodule ShopWeb.EventsBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Events bravo {@events_bravo.id}
        <:subtitle>This is a events_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/events_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/events_bravos/#{@events_bravo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit events_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@events_bravo.title}</:item>
        <:item title="Body">{@events_bravo.body}</:item>
        <:item title="Price">{@events_bravo.price}</:item>
        <:item title="Quantity">{@events_bravo.quantity}</:item>
        <:item title="Active">{@events_bravo.active}</:item>
        <:item title="Due on">{@events_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Events.subscribe_events_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Events bravo")
     |> assign(:events_bravo, Events.get_events_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Events.EventsBravo{id: id} = events_bravo},
        %{assigns: %{events_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :events_bravo, events_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Events.EventsBravo{id: id}},
        %{assigns: %{events_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current events_bravo was deleted.")
     |> push_navigate(to: ~p"/events_bravos")}
  end

  def handle_info({type, %Shop.Events.EventsBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
