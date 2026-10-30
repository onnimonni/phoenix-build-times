defmodule ShopWeb.ContentDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Content delta {@content_delta.id}
        <:subtitle>This is a content_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/content_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/content_deltas/#{@content_delta}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit content_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@content_delta.title}</:item>
        <:item title="Body">{@content_delta.body}</:item>
        <:item title="Price">{@content_delta.price}</:item>
        <:item title="Quantity">{@content_delta.quantity}</:item>
        <:item title="Active">{@content_delta.active}</:item>
        <:item title="Due on">{@content_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Content.subscribe_content_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Content delta")
     |> assign(:content_delta, Content.get_content_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Content.ContentDelta{id: id} = content_delta},
        %{assigns: %{content_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :content_delta, content_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Content.ContentDelta{id: id}},
        %{assigns: %{content_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current content_delta was deleted.")
     |> push_navigate(to: ~p"/content_deltas")}
  end

  def handle_info({type, %Shop.Content.ContentDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
