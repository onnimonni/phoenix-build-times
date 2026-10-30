defmodule ShopWeb.CatalogBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Catalog bravo {@catalog_bravo.id}
        <:subtitle>This is a catalog_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/catalog_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/catalog_bravos/#{@catalog_bravo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit catalog_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@catalog_bravo.title}</:item>
        <:item title="Body">{@catalog_bravo.body}</:item>
        <:item title="Price">{@catalog_bravo.price}</:item>
        <:item title="Quantity">{@catalog_bravo.quantity}</:item>
        <:item title="Active">{@catalog_bravo.active}</:item>
        <:item title="Due on">{@catalog_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Catalog.subscribe_catalog_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Catalog bravo")
     |> assign(:catalog_bravo, Catalog.get_catalog_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Catalog.CatalogBravo{id: id} = catalog_bravo},
        %{assigns: %{catalog_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :catalog_bravo, catalog_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Catalog.CatalogBravo{id: id}},
        %{assigns: %{catalog_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current catalog_bravo was deleted.")
     |> push_navigate(to: ~p"/catalog_bravos")}
  end

  def handle_info({type, %Shop.Catalog.CatalogBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
