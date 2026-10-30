defmodule ShopWeb.EventsBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Events bravos
        <:actions>
          <.button variant="primary" navigate={~p"/events_bravos/new"}>
            <.icon name="hero-plus" /> New Events bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="events_bravos"
        rows={@streams.events_bravos}
        row_click={fn {_id, events_bravo} -> JS.navigate(~p"/events_bravos/#{events_bravo}") end}
      >
        <:col :let={{_id, events_bravo}} label="Title">{events_bravo.title}</:col>
        <:col :let={{_id, events_bravo}} label="Body">{events_bravo.body}</:col>
        <:col :let={{_id, events_bravo}} label="Price">{events_bravo.price}</:col>
        <:col :let={{_id, events_bravo}} label="Quantity">{events_bravo.quantity}</:col>
        <:col :let={{_id, events_bravo}} label="Active">{events_bravo.active}</:col>
        <:col :let={{_id, events_bravo}} label="Due on">{events_bravo.due_on}</:col>
        <:action :let={{_id, events_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/events_bravos/#{events_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/events_bravos/#{events_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, events_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: events_bravo.id}) |> hide("##{id}")}
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
      Events.subscribe_events_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Events bravos")
     |> stream(:events_bravos, list_events_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    events_bravo = Events.get_events_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Events.delete_events_bravo(socket.assigns.current_scope, events_bravo)

    {:noreply, stream_delete(socket, :events_bravos, events_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Events.EventsBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :events_bravos, list_events_bravos(socket.assigns.current_scope), reset: true)}
  end

  defp list_events_bravos(current_scope) do
    Events.list_events_bravos(current_scope)
  end
end
