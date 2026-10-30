defmodule ShopWeb.CatalogEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Catalog echos
        <:actions>
          <.button variant="primary" navigate={~p"/catalog_echos/new"}>
            <.icon name="hero-plus" /> New Catalog echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="catalog_echos"
        rows={@streams.catalog_echos}
        row_click={fn {_id, catalog_echo} -> JS.navigate(~p"/catalog_echos/#{catalog_echo}") end}
      >
        <:col :let={{_id, catalog_echo}} label="Title">{catalog_echo.title}</:col>
        <:col :let={{_id, catalog_echo}} label="Body">{catalog_echo.body}</:col>
        <:col :let={{_id, catalog_echo}} label="Price">{catalog_echo.price}</:col>
        <:col :let={{_id, catalog_echo}} label="Quantity">{catalog_echo.quantity}</:col>
        <:col :let={{_id, catalog_echo}} label="Active">{catalog_echo.active}</:col>
        <:col :let={{_id, catalog_echo}} label="Due on">{catalog_echo.due_on}</:col>
        <:action :let={{_id, catalog_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/catalog_echos/#{catalog_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/catalog_echos/#{catalog_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, catalog_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: catalog_echo.id}) |> hide("##{id}")}
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
      Catalog.subscribe_catalog_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Catalog echos")
     |> stream(:catalog_echos, list_catalog_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    catalog_echo = Catalog.get_catalog_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Catalog.delete_catalog_echo(socket.assigns.current_scope, catalog_echo)

    {:noreply, stream_delete(socket, :catalog_echos, catalog_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Catalog.CatalogEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :catalog_echos, list_catalog_echos(socket.assigns.current_scope), reset: true)}
  end

  defp list_catalog_echos(current_scope) do
    Catalog.list_catalog_echos(current_scope)
  end
end
