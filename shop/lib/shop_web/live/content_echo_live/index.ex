defmodule ShopWeb.ContentEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Content echos
        <:actions>
          <.button variant="primary" navigate={~p"/content_echos/new"}>
            <.icon name="hero-plus" /> New Content echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="content_echos"
        rows={@streams.content_echos}
        row_click={fn {_id, content_echo} -> JS.navigate(~p"/content_echos/#{content_echo}") end}
      >
        <:col :let={{_id, content_echo}} label="Title">{content_echo.title}</:col>
        <:col :let={{_id, content_echo}} label="Body">{content_echo.body}</:col>
        <:col :let={{_id, content_echo}} label="Price">{content_echo.price}</:col>
        <:col :let={{_id, content_echo}} label="Quantity">{content_echo.quantity}</:col>
        <:col :let={{_id, content_echo}} label="Active">{content_echo.active}</:col>
        <:col :let={{_id, content_echo}} label="Due on">{content_echo.due_on}</:col>
        <:action :let={{_id, content_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/content_echos/#{content_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/content_echos/#{content_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, content_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: content_echo.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Content.subscribe_content_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Content echos")
     |> stream(:content_echos, list_content_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_echo = Content.get_content_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Content.delete_content_echo(socket.assigns.current_scope, content_echo)

    {:noreply, stream_delete(socket, :content_echos, content_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Content.ContentEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :content_echos, list_content_echos(socket.assigns.current_scope), reset: true)}
  end

  defp list_content_echos(current_scope) do
    Content.list_content_echos(current_scope)
  end
end
