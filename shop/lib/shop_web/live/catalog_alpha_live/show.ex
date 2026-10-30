defmodule ShopWeb.CatalogAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Catalog alpha {@catalog_alpha.id}
        <:subtitle>This is a catalog_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/catalog_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/catalog_alphas/#{@catalog_alpha}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit catalog_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@catalog_alpha.title}</:item>
        <:item title="Body">{@catalog_alpha.body}</:item>
        <:item title="Price">{@catalog_alpha.price}</:item>
        <:item title="Quantity">{@catalog_alpha.quantity}</:item>
        <:item title="Active">{@catalog_alpha.active}</:item>
        <:item title="Due on">{@catalog_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Catalog.subscribe_catalog_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Catalog alpha")
     |> assign(:catalog_alpha, Catalog.get_catalog_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Catalog.CatalogAlpha{id: id} = catalog_alpha},
        %{assigns: %{catalog_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :catalog_alpha, catalog_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Catalog.CatalogAlpha{id: id}},
        %{assigns: %{catalog_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current catalog_alpha was deleted.")
     |> push_navigate(to: ~p"/catalog_alphas")}
  end

  def handle_info({type, %Shop.Catalog.CatalogAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
