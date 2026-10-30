defmodule ShopWeb.ContentAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Content alpha {@content_alpha.id}
        <:subtitle>This is a content_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/content_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/content_alphas/#{@content_alpha}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit content_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@content_alpha.title}</:item>
        <:item title="Body">{@content_alpha.body}</:item>
        <:item title="Price">{@content_alpha.price}</:item>
        <:item title="Quantity">{@content_alpha.quantity}</:item>
        <:item title="Active">{@content_alpha.active}</:item>
        <:item title="Due on">{@content_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Content.subscribe_content_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Content alpha")
     |> assign(:content_alpha, Content.get_content_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Content.ContentAlpha{id: id} = content_alpha},
        %{assigns: %{content_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :content_alpha, content_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Content.ContentAlpha{id: id}},
        %{assigns: %{content_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current content_alpha was deleted.")
     |> push_navigate(to: ~p"/content_alphas")}
  end

  def handle_info({type, %Shop.Content.ContentAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
