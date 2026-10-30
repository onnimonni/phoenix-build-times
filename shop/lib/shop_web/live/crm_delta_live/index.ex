defmodule ShopWeb.CrmDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Crm deltas
        <:actions>
          <.button variant="primary" navigate={~p"/crm_deltas/new"}>
            <.icon name="hero-plus" /> New Crm delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="crm_deltas"
        rows={@streams.crm_deltas}
        row_click={fn {_id, crm_delta} -> JS.navigate(~p"/crm_deltas/#{crm_delta}") end}
      >
        <:col :let={{_id, crm_delta}} label="Title">{crm_delta.title}</:col>
        <:col :let={{_id, crm_delta}} label="Body">{crm_delta.body}</:col>
        <:col :let={{_id, crm_delta}} label="Price">{crm_delta.price}</:col>
        <:col :let={{_id, crm_delta}} label="Quantity">{crm_delta.quantity}</:col>
        <:col :let={{_id, crm_delta}} label="Active">{crm_delta.active}</:col>
        <:col :let={{_id, crm_delta}} label="Due on">{crm_delta.due_on}</:col>
        <:action :let={{_id, crm_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/crm_deltas/#{crm_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/crm_deltas/#{crm_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, crm_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: crm_delta.id}) |> hide("##{id}")}
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
      Crm.subscribe_crm_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Crm deltas")
     |> stream(:crm_deltas, list_crm_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    crm_delta = Crm.get_crm_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Crm.delete_crm_delta(socket.assigns.current_scope, crm_delta)

    {:noreply, stream_delete(socket, :crm_deltas, crm_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Crm.CrmDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :crm_deltas, list_crm_deltas(socket.assigns.current_scope), reset: true)}
  end

  defp list_crm_deltas(current_scope) do
    Crm.list_crm_deltas(current_scope)
  end
end
