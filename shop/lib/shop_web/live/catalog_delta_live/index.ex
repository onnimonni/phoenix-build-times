defmodule ShopWeb.CatalogDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Catalog deltas
        <:actions>
          <.button variant="primary" navigate={~p"/catalog_deltas/new"}>
            <.icon name="hero-plus" /> New Catalog delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="catalog_deltas"
        rows={@streams.catalog_deltas}
        row_click={fn {_id, catalog_delta} -> JS.navigate(~p"/catalog_deltas/#{catalog_delta}") end}
      >
        <:col :let={{_id, catalog_delta}} label="Title">{catalog_delta.title}</:col>
        <:col :let={{_id, catalog_delta}} label="Body">{catalog_delta.body}</:col>
        <:col :let={{_id, catalog_delta}} label="Price">{catalog_delta.price}</:col>
        <:col :let={{_id, catalog_delta}} label="Quantity">{catalog_delta.quantity}</:col>
        <:col :let={{_id, catalog_delta}} label="Active">{catalog_delta.active}</:col>
        <:col :let={{_id, catalog_delta}} label="Due on">{catalog_delta.due_on}</:col>
        <:action :let={{_id, catalog_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/catalog_deltas/#{catalog_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/catalog_deltas/#{catalog_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, catalog_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: catalog_delta.id}) |> hide("##{id}")}
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
      Catalog.subscribe_catalog_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Catalog deltas")
     |> stream(:catalog_deltas, list_catalog_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    catalog_delta = Catalog.get_catalog_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Catalog.delete_catalog_delta(socket.assigns.current_scope, catalog_delta)

    {:noreply, stream_delete(socket, :catalog_deltas, catalog_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Catalog.CatalogDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :catalog_deltas, list_catalog_deltas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_catalog_deltas(current_scope) do
    Catalog.list_catalog_deltas(current_scope)
  end
end
