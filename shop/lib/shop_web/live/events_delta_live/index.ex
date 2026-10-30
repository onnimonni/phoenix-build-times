defmodule ShopWeb.EventsDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Events deltas
        <:actions>
          <.button variant="primary" navigate={~p"/events_deltas/new"}>
            <.icon name="hero-plus" /> New Events delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="events_deltas"
        rows={@streams.events_deltas}
        row_click={fn {_id, events_delta} -> JS.navigate(~p"/events_deltas/#{events_delta}") end}
      >
        <:col :let={{_id, events_delta}} label="Title">{events_delta.title}</:col>
        <:col :let={{_id, events_delta}} label="Body">{events_delta.body}</:col>
        <:col :let={{_id, events_delta}} label="Price">{events_delta.price}</:col>
        <:col :let={{_id, events_delta}} label="Quantity">{events_delta.quantity}</:col>
        <:col :let={{_id, events_delta}} label="Active">{events_delta.active}</:col>
        <:col :let={{_id, events_delta}} label="Due on">{events_delta.due_on}</:col>
        <:action :let={{_id, events_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/events_deltas/#{events_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/events_deltas/#{events_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, events_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: events_delta.id}) |> hide("##{id}")}
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
      Events.subscribe_events_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Events deltas")
     |> stream(:events_deltas, list_events_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    events_delta = Events.get_events_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Events.delete_events_delta(socket.assigns.current_scope, events_delta)

    {:noreply, stream_delete(socket, :events_deltas, events_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Events.EventsDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :events_deltas, list_events_deltas(socket.assigns.current_scope), reset: true)}
  end

  defp list_events_deltas(current_scope) do
    Events.list_events_deltas(current_scope)
  end
end
