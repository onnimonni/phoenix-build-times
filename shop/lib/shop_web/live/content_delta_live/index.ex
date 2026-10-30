defmodule ShopWeb.ContentDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Content deltas
        <:actions>
          <.button variant="primary" navigate={~p"/content_deltas/new"}>
            <.icon name="hero-plus" /> New Content delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="content_deltas"
        rows={@streams.content_deltas}
        row_click={fn {_id, content_delta} -> JS.navigate(~p"/content_deltas/#{content_delta}") end}
      >
        <:col :let={{_id, content_delta}} label="Title">{content_delta.title}</:col>
        <:col :let={{_id, content_delta}} label="Body">{content_delta.body}</:col>
        <:col :let={{_id, content_delta}} label="Price">{content_delta.price}</:col>
        <:col :let={{_id, content_delta}} label="Quantity">{content_delta.quantity}</:col>
        <:col :let={{_id, content_delta}} label="Active">{content_delta.active}</:col>
        <:col :let={{_id, content_delta}} label="Due on">{content_delta.due_on}</:col>
        <:action :let={{_id, content_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/content_deltas/#{content_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/content_deltas/#{content_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, content_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: content_delta.id}) |> hide("##{id}")}
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
      Content.subscribe_content_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Content deltas")
     |> stream(:content_deltas, list_content_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_delta = Content.get_content_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Content.delete_content_delta(socket.assigns.current_scope, content_delta)

    {:noreply, stream_delete(socket, :content_deltas, content_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Content.ContentDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :content_deltas, list_content_deltas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_content_deltas(current_scope) do
    Content.list_content_deltas(current_scope)
  end
end
