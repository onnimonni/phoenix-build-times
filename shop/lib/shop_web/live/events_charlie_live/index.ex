defmodule ShopWeb.EventsCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Events charlies
        <:actions>
          <.button variant="primary" navigate={~p"/events_charlies/new"}>
            <.icon name="hero-plus" /> New Events charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="events_charlies"
        rows={@streams.events_charlies}
        row_click={
          fn {_id, events_charlie} -> JS.navigate(~p"/events_charlies/#{events_charlie}") end
        }
      >
        <:col :let={{_id, events_charlie}} label="Title">{events_charlie.title}</:col>
        <:col :let={{_id, events_charlie}} label="Body">{events_charlie.body}</:col>
        <:col :let={{_id, events_charlie}} label="Price">{events_charlie.price}</:col>
        <:col :let={{_id, events_charlie}} label="Quantity">{events_charlie.quantity}</:col>
        <:col :let={{_id, events_charlie}} label="Active">{events_charlie.active}</:col>
        <:col :let={{_id, events_charlie}} label="Due on">{events_charlie.due_on}</:col>
        <:action :let={{_id, events_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/events_charlies/#{events_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/events_charlies/#{events_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, events_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: events_charlie.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Events.subscribe_events_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Events charlies")
     |> stream(:events_charlies, list_events_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    events_charlie = Events.get_events_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Events.delete_events_charlie(socket.assigns.current_scope, events_charlie)

    {:noreply, stream_delete(socket, :events_charlies, events_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Events.EventsCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :events_charlies, list_events_charlies(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_events_charlies(current_scope) do
    Events.list_events_charlies(current_scope)
  end
end
