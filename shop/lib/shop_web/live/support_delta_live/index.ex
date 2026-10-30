defmodule ShopWeb.SupportDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Support deltas
        <:actions>
          <.button variant="primary" navigate={~p"/support_deltas/new"}>
            <.icon name="hero-plus" /> New Support delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="support_deltas"
        rows={@streams.support_deltas}
        row_click={fn {_id, support_delta} -> JS.navigate(~p"/support_deltas/#{support_delta}") end}
      >
        <:col :let={{_id, support_delta}} label="Title">{support_delta.title}</:col>
        <:col :let={{_id, support_delta}} label="Body">{support_delta.body}</:col>
        <:col :let={{_id, support_delta}} label="Price">{support_delta.price}</:col>
        <:col :let={{_id, support_delta}} label="Quantity">{support_delta.quantity}</:col>
        <:col :let={{_id, support_delta}} label="Active">{support_delta.active}</:col>
        <:col :let={{_id, support_delta}} label="Due on">{support_delta.due_on}</:col>
        <:action :let={{_id, support_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/support_deltas/#{support_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/support_deltas/#{support_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, support_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: support_delta.id}) |> hide("##{id}")}
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
      Support.subscribe_support_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Support deltas")
     |> stream(:support_deltas, list_support_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    support_delta = Support.get_support_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Support.delete_support_delta(socket.assigns.current_scope, support_delta)

    {:noreply, stream_delete(socket, :support_deltas, support_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Support.SupportDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :support_deltas, list_support_deltas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_support_deltas(current_scope) do
    Support.list_support_deltas(current_scope)
  end
end
