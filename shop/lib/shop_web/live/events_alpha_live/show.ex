defmodule ShopWeb.EventsAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Events alpha {@events_alpha.id}
        <:subtitle>This is a events_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/events_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/events_alphas/#{@events_alpha}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit events_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@events_alpha.title}</:item>
        <:item title="Body">{@events_alpha.body}</:item>
        <:item title="Price">{@events_alpha.price}</:item>
        <:item title="Quantity">{@events_alpha.quantity}</:item>
        <:item title="Active">{@events_alpha.active}</:item>
        <:item title="Due on">{@events_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Events.subscribe_events_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Events alpha")
     |> assign(:events_alpha, Events.get_events_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Events.EventsAlpha{id: id} = events_alpha},
        %{assigns: %{events_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :events_alpha, events_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Events.EventsAlpha{id: id}},
        %{assigns: %{events_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current events_alpha was deleted.")
     |> push_navigate(to: ~p"/events_alphas")}
  end

  def handle_info({type, %Shop.Events.EventsAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
