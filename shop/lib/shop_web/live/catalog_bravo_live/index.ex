defmodule ShopWeb.CatalogBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Catalog bravos
        <:actions>
          <.button variant="primary" navigate={~p"/catalog_bravos/new"}>
            <.icon name="hero-plus" /> New Catalog bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="catalog_bravos"
        rows={@streams.catalog_bravos}
        row_click={fn {_id, catalog_bravo} -> JS.navigate(~p"/catalog_bravos/#{catalog_bravo}") end}
      >
        <:col :let={{_id, catalog_bravo}} label="Title">{catalog_bravo.title}</:col>
        <:col :let={{_id, catalog_bravo}} label="Body">{catalog_bravo.body}</:col>
        <:col :let={{_id, catalog_bravo}} label="Price">{catalog_bravo.price}</:col>
        <:col :let={{_id, catalog_bravo}} label="Quantity">{catalog_bravo.quantity}</:col>
        <:col :let={{_id, catalog_bravo}} label="Active">{catalog_bravo.active}</:col>
        <:col :let={{_id, catalog_bravo}} label="Due on">{catalog_bravo.due_on}</:col>
        <:action :let={{_id, catalog_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/catalog_bravos/#{catalog_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/catalog_bravos/#{catalog_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, catalog_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: catalog_bravo.id}) |> hide("##{id}")}
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
      Catalog.subscribe_catalog_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Catalog bravos")
     |> stream(:catalog_bravos, list_catalog_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    catalog_bravo = Catalog.get_catalog_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Catalog.delete_catalog_bravo(socket.assigns.current_scope, catalog_bravo)

    {:noreply, stream_delete(socket, :catalog_bravos, catalog_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Catalog.CatalogBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :catalog_bravos, list_catalog_bravos(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_catalog_bravos(current_scope) do
    Catalog.list_catalog_bravos(current_scope)
  end
end
