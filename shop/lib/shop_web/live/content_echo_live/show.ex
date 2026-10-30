defmodule ShopWeb.ContentEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Content echo {@content_echo.id}
        <:subtitle>This is a content_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/content_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/content_echos/#{@content_echo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit content_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@content_echo.title}</:item>
        <:item title="Body">{@content_echo.body}</:item>
        <:item title="Price">{@content_echo.price}</:item>
        <:item title="Quantity">{@content_echo.quantity}</:item>
        <:item title="Active">{@content_echo.active}</:item>
        <:item title="Due on">{@content_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Content.subscribe_content_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Content echo")
     |> assign(:content_echo, Content.get_content_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Content.ContentEcho{id: id} = content_echo},
        %{assigns: %{content_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :content_echo, content_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Content.ContentEcho{id: id}},
        %{assigns: %{content_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current content_echo was deleted.")
     |> push_navigate(to: ~p"/content_echos")}
  end

  def handle_info({type, %Shop.Content.ContentEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
