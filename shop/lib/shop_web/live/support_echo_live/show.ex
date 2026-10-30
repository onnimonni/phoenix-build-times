defmodule ShopWeb.SupportEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Support echo {@support_echo.id}
        <:subtitle>This is a support_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/support_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/support_echos/#{@support_echo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit support_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@support_echo.title}</:item>
        <:item title="Body">{@support_echo.body}</:item>
        <:item title="Price">{@support_echo.price}</:item>
        <:item title="Quantity">{@support_echo.quantity}</:item>
        <:item title="Active">{@support_echo.active}</:item>
        <:item title="Due on">{@support_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Support.subscribe_support_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Support echo")
     |> assign(:support_echo, Support.get_support_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Support.SupportEcho{id: id} = support_echo},
        %{assigns: %{support_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :support_echo, support_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Support.SupportEcho{id: id}},
        %{assigns: %{support_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current support_echo was deleted.")
     |> push_navigate(to: ~p"/support_echos")}
  end

  def handle_info({type, %Shop.Support.SupportEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
