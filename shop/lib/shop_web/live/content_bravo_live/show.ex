defmodule ShopWeb.ContentBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Content bravo {@content_bravo.id}
        <:subtitle>This is a content_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/content_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/content_bravos/#{@content_bravo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit content_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@content_bravo.title}</:item>
        <:item title="Body">{@content_bravo.body}</:item>
        <:item title="Price">{@content_bravo.price}</:item>
        <:item title="Quantity">{@content_bravo.quantity}</:item>
        <:item title="Active">{@content_bravo.active}</:item>
        <:item title="Due on">{@content_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Content.subscribe_content_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Content bravo")
     |> assign(:content_bravo, Content.get_content_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Content.ContentBravo{id: id} = content_bravo},
        %{assigns: %{content_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :content_bravo, content_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Content.ContentBravo{id: id}},
        %{assigns: %{content_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current content_bravo was deleted.")
     |> push_navigate(to: ~p"/content_bravos")}
  end

  def handle_info({type, %Shop.Content.ContentBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
