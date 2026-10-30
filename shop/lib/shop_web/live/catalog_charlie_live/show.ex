defmodule ShopWeb.CatalogCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Catalog charlie {@catalog_charlie.id}
        <:subtitle>This is a catalog_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/catalog_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/catalog_charlies/#{@catalog_charlie}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit catalog_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@catalog_charlie.title}</:item>
        <:item title="Body">{@catalog_charlie.body}</:item>
        <:item title="Price">{@catalog_charlie.price}</:item>
        <:item title="Quantity">{@catalog_charlie.quantity}</:item>
        <:item title="Active">{@catalog_charlie.active}</:item>
        <:item title="Due on">{@catalog_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Catalog.subscribe_catalog_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Catalog charlie")
     |> assign(:catalog_charlie, Catalog.get_catalog_charlie!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Catalog.CatalogCharlie{id: id} = catalog_charlie},
        %{assigns: %{catalog_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :catalog_charlie, catalog_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Catalog.CatalogCharlie{id: id}},
        %{assigns: %{catalog_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current catalog_charlie was deleted.")
     |> push_navigate(to: ~p"/catalog_charlies")}
  end

  def handle_info({type, %Shop.Catalog.CatalogCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
