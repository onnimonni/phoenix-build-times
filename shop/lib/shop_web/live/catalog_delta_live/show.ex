defmodule ShopWeb.CatalogDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Catalog delta {@catalog_delta.id}
        <:subtitle>This is a catalog_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/catalog_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/catalog_deltas/#{@catalog_delta}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit catalog_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@catalog_delta.title}</:item>
        <:item title="Body">{@catalog_delta.body}</:item>
        <:item title="Price">{@catalog_delta.price}</:item>
        <:item title="Quantity">{@catalog_delta.quantity}</:item>
        <:item title="Active">{@catalog_delta.active}</:item>
        <:item title="Due on">{@catalog_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Catalog.subscribe_catalog_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Catalog delta")
     |> assign(:catalog_delta, Catalog.get_catalog_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Catalog.CatalogDelta{id: id} = catalog_delta},
        %{assigns: %{catalog_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :catalog_delta, catalog_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Catalog.CatalogDelta{id: id}},
        %{assigns: %{catalog_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current catalog_delta was deleted.")
     |> push_navigate(to: ~p"/catalog_deltas")}
  end

  def handle_info({type, %Shop.Catalog.CatalogDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
