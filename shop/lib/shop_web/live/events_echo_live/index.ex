defmodule ShopWeb.EventsEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Events echos
        <:actions>
          <.button variant="primary" navigate={~p"/events_echos/new"}>
            <.icon name="hero-plus" /> New Events echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="events_echos"
        rows={@streams.events_echos}
        row_click={fn {_id, events_echo} -> JS.navigate(~p"/events_echos/#{events_echo}") end}
      >
        <:col :let={{_id, events_echo}} label="Title">{events_echo.title}</:col>
        <:col :let={{_id, events_echo}} label="Body">{events_echo.body}</:col>
        <:col :let={{_id, events_echo}} label="Price">{events_echo.price}</:col>
        <:col :let={{_id, events_echo}} label="Quantity">{events_echo.quantity}</:col>
        <:col :let={{_id, events_echo}} label="Active">{events_echo.active}</:col>
        <:col :let={{_id, events_echo}} label="Due on">{events_echo.due_on}</:col>
        <:action :let={{_id, events_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/events_echos/#{events_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/events_echos/#{events_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, events_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: events_echo.id}) |> hide("##{id}")}
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
      Events.subscribe_events_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Events echos")
     |> stream(:events_echos, list_events_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    events_echo = Events.get_events_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Events.delete_events_echo(socket.assigns.current_scope, events_echo)

    {:noreply, stream_delete(socket, :events_echos, events_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Events.EventsEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :events_echos, list_events_echos(socket.assigns.current_scope), reset: true)}
  end

  defp list_events_echos(current_scope) do
    Events.list_events_echos(current_scope)
  end
end
