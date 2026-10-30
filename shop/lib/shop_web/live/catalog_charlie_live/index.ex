defmodule ShopWeb.CatalogCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Catalog charlies
        <:actions>
          <.button variant="primary" navigate={~p"/catalog_charlies/new"}>
            <.icon name="hero-plus" /> New Catalog charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="catalog_charlies"
        rows={@streams.catalog_charlies}
        row_click={
          fn {_id, catalog_charlie} -> JS.navigate(~p"/catalog_charlies/#{catalog_charlie}") end
        }
      >
        <:col :let={{_id, catalog_charlie}} label="Title">{catalog_charlie.title}</:col>
        <:col :let={{_id, catalog_charlie}} label="Body">{catalog_charlie.body}</:col>
        <:col :let={{_id, catalog_charlie}} label="Price">{catalog_charlie.price}</:col>
        <:col :let={{_id, catalog_charlie}} label="Quantity">{catalog_charlie.quantity}</:col>
        <:col :let={{_id, catalog_charlie}} label="Active">{catalog_charlie.active}</:col>
        <:col :let={{_id, catalog_charlie}} label="Due on">{catalog_charlie.due_on}</:col>
        <:action :let={{_id, catalog_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/catalog_charlies/#{catalog_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/catalog_charlies/#{catalog_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, catalog_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: catalog_charlie.id}) |> hide("##{id}")}
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
      Catalog.subscribe_catalog_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Catalog charlies")
     |> stream(:catalog_charlies, list_catalog_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    catalog_charlie = Catalog.get_catalog_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Catalog.delete_catalog_charlie(socket.assigns.current_scope, catalog_charlie)

    {:noreply, stream_delete(socket, :catalog_charlies, catalog_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Catalog.CatalogCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :catalog_charlies, list_catalog_charlies(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_catalog_charlies(current_scope) do
    Catalog.list_catalog_charlies(current_scope)
  end
end
