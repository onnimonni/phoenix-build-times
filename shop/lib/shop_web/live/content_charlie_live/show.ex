defmodule ShopWeb.ContentCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Content charlie {@content_charlie.id}
        <:subtitle>This is a content_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/content_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/content_charlies/#{@content_charlie}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit content_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@content_charlie.title}</:item>
        <:item title="Body">{@content_charlie.body}</:item>
        <:item title="Price">{@content_charlie.price}</:item>
        <:item title="Quantity">{@content_charlie.quantity}</:item>
        <:item title="Active">{@content_charlie.active}</:item>
        <:item title="Due on">{@content_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Content.subscribe_content_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Content charlie")
     |> assign(:content_charlie, Content.get_content_charlie!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Content.ContentCharlie{id: id} = content_charlie},
        %{assigns: %{content_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :content_charlie, content_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Content.ContentCharlie{id: id}},
        %{assigns: %{content_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current content_charlie was deleted.")
     |> push_navigate(to: ~p"/content_charlies")}
  end

  def handle_info({type, %Shop.Content.ContentCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
