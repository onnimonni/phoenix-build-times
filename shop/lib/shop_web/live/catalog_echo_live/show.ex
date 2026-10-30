defmodule ShopWeb.CatalogEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Catalog echo {@catalog_echo.id}
        <:subtitle>This is a catalog_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/catalog_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/catalog_echos/#{@catalog_echo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit catalog_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@catalog_echo.title}</:item>
        <:item title="Body">{@catalog_echo.body}</:item>
        <:item title="Price">{@catalog_echo.price}</:item>
        <:item title="Quantity">{@catalog_echo.quantity}</:item>
        <:item title="Active">{@catalog_echo.active}</:item>
        <:item title="Due on">{@catalog_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Catalog.subscribe_catalog_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Catalog echo")
     |> assign(:catalog_echo, Catalog.get_catalog_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Catalog.CatalogEcho{id: id} = catalog_echo},
        %{assigns: %{catalog_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :catalog_echo, catalog_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Catalog.CatalogEcho{id: id}},
        %{assigns: %{catalog_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current catalog_echo was deleted.")
     |> push_navigate(to: ~p"/catalog_echos")}
  end

  def handle_info({type, %Shop.Catalog.CatalogEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
