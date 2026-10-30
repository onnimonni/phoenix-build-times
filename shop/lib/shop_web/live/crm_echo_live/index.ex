defmodule ShopWeb.CrmEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Crm echos
        <:actions>
          <.button variant="primary" navigate={~p"/crm_echos/new"}>
            <.icon name="hero-plus" /> New Crm echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="crm_echos"
        rows={@streams.crm_echos}
        row_click={fn {_id, crm_echo} -> JS.navigate(~p"/crm_echos/#{crm_echo}") end}
      >
        <:col :let={{_id, crm_echo}} label="Title">{crm_echo.title}</:col>
        <:col :let={{_id, crm_echo}} label="Body">{crm_echo.body}</:col>
        <:col :let={{_id, crm_echo}} label="Price">{crm_echo.price}</:col>
        <:col :let={{_id, crm_echo}} label="Quantity">{crm_echo.quantity}</:col>
        <:col :let={{_id, crm_echo}} label="Active">{crm_echo.active}</:col>
        <:col :let={{_id, crm_echo}} label="Due on">{crm_echo.due_on}</:col>
        <:action :let={{_id, crm_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/crm_echos/#{crm_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/crm_echos/#{crm_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, crm_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: crm_echo.id}) |> hide("##{id}")}
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
      Crm.subscribe_crm_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Crm echos")
     |> stream(:crm_echos, list_crm_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    crm_echo = Crm.get_crm_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Crm.delete_crm_echo(socket.assigns.current_scope, crm_echo)

    {:noreply, stream_delete(socket, :crm_echos, crm_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Crm.CrmEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :crm_echos, list_crm_echos(socket.assigns.current_scope), reset: true)}
  end

  defp list_crm_echos(current_scope) do
    Crm.list_crm_echos(current_scope)
  end
end
