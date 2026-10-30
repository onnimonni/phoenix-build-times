defmodule ShopWeb.CatalogAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Catalog alphas
        <:actions>
          <.button variant="primary" navigate={~p"/catalog_alphas/new"}>
            <.icon name="hero-plus" /> New Catalog alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="catalog_alphas"
        rows={@streams.catalog_alphas}
        row_click={fn {_id, catalog_alpha} -> JS.navigate(~p"/catalog_alphas/#{catalog_alpha}") end}
      >
        <:col :let={{_id, catalog_alpha}} label="Title">{catalog_alpha.title}</:col>
        <:col :let={{_id, catalog_alpha}} label="Body">{catalog_alpha.body}</:col>
        <:col :let={{_id, catalog_alpha}} label="Price">{catalog_alpha.price}</:col>
        <:col :let={{_id, catalog_alpha}} label="Quantity">{catalog_alpha.quantity}</:col>
        <:col :let={{_id, catalog_alpha}} label="Active">{catalog_alpha.active}</:col>
        <:col :let={{_id, catalog_alpha}} label="Due on">{catalog_alpha.due_on}</:col>
        <:action :let={{_id, catalog_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/catalog_alphas/#{catalog_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/catalog_alphas/#{catalog_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, catalog_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: catalog_alpha.id}) |> hide("##{id}")}
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
      Catalog.subscribe_catalog_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Catalog alphas")
     |> stream(:catalog_alphas, list_catalog_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    catalog_alpha = Catalog.get_catalog_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Catalog.delete_catalog_alpha(socket.assigns.current_scope, catalog_alpha)

    {:noreply, stream_delete(socket, :catalog_alphas, catalog_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Catalog.CatalogAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :catalog_alphas, list_catalog_alphas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_catalog_alphas(current_scope) do
    Catalog.list_catalog_alphas(current_scope)
  end
end
