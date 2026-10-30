defmodule ShopWeb.SupportEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Support echos
        <:actions>
          <.button variant="primary" navigate={~p"/support_echos/new"}>
            <.icon name="hero-plus" /> New Support echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="support_echos"
        rows={@streams.support_echos}
        row_click={fn {_id, support_echo} -> JS.navigate(~p"/support_echos/#{support_echo}") end}
      >
        <:col :let={{_id, support_echo}} label="Title">{support_echo.title}</:col>
        <:col :let={{_id, support_echo}} label="Body">{support_echo.body}</:col>
        <:col :let={{_id, support_echo}} label="Price">{support_echo.price}</:col>
        <:col :let={{_id, support_echo}} label="Quantity">{support_echo.quantity}</:col>
        <:col :let={{_id, support_echo}} label="Active">{support_echo.active}</:col>
        <:col :let={{_id, support_echo}} label="Due on">{support_echo.due_on}</:col>
        <:action :let={{_id, support_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/support_echos/#{support_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/support_echos/#{support_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, support_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: support_echo.id}) |> hide("##{id}")}
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
      Support.subscribe_support_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Support echos")
     |> stream(:support_echos, list_support_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    support_echo = Support.get_support_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Support.delete_support_echo(socket.assigns.current_scope, support_echo)

    {:noreply, stream_delete(socket, :support_echos, support_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Support.SupportEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :support_echos, list_support_echos(socket.assigns.current_scope), reset: true)}
  end

  defp list_support_echos(current_scope) do
    Support.list_support_echos(current_scope)
  end
end
