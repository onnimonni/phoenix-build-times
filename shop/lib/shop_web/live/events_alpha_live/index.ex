defmodule ShopWeb.EventsAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Events

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Events alphas
        <:actions>
          <.button variant="primary" navigate={~p"/events_alphas/new"}>
            <.icon name="hero-plus" /> New Events alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="events_alphas"
        rows={@streams.events_alphas}
        row_click={fn {_id, events_alpha} -> JS.navigate(~p"/events_alphas/#{events_alpha}") end}
      >
        <:col :let={{_id, events_alpha}} label="Title">{events_alpha.title}</:col>
        <:col :let={{_id, events_alpha}} label="Body">{events_alpha.body}</:col>
        <:col :let={{_id, events_alpha}} label="Price">{events_alpha.price}</:col>
        <:col :let={{_id, events_alpha}} label="Quantity">{events_alpha.quantity}</:col>
        <:col :let={{_id, events_alpha}} label="Active">{events_alpha.active}</:col>
        <:col :let={{_id, events_alpha}} label="Due on">{events_alpha.due_on}</:col>
        <:action :let={{_id, events_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/events_alphas/#{events_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/events_alphas/#{events_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, events_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: events_alpha.id}) |> hide("##{id}")}
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
      Events.subscribe_events_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Events alphas")
     |> stream(:events_alphas, list_events_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    events_alpha = Events.get_events_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Events.delete_events_alpha(socket.assigns.current_scope, events_alpha)

    {:noreply, stream_delete(socket, :events_alphas, events_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Events.EventsAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :events_alphas, list_events_alphas(socket.assigns.current_scope), reset: true)}
  end

  defp list_events_alphas(current_scope) do
    Events.list_events_alphas(current_scope)
  end
end
