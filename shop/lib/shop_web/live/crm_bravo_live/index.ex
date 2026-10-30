defmodule ShopWeb.CrmBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Crm bravos
        <:actions>
          <.button variant="primary" navigate={~p"/crm_bravos/new"}>
            <.icon name="hero-plus" /> New Crm bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="crm_bravos"
        rows={@streams.crm_bravos}
        row_click={fn {_id, crm_bravo} -> JS.navigate(~p"/crm_bravos/#{crm_bravo}") end}
      >
        <:col :let={{_id, crm_bravo}} label="Title">{crm_bravo.title}</:col>
        <:col :let={{_id, crm_bravo}} label="Body">{crm_bravo.body}</:col>
        <:col :let={{_id, crm_bravo}} label="Price">{crm_bravo.price}</:col>
        <:col :let={{_id, crm_bravo}} label="Quantity">{crm_bravo.quantity}</:col>
        <:col :let={{_id, crm_bravo}} label="Active">{crm_bravo.active}</:col>
        <:col :let={{_id, crm_bravo}} label="Due on">{crm_bravo.due_on}</:col>
        <:action :let={{_id, crm_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/crm_bravos/#{crm_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/crm_bravos/#{crm_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, crm_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: crm_bravo.id}) |> hide("##{id}")}
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
      Crm.subscribe_crm_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Crm bravos")
     |> stream(:crm_bravos, list_crm_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    crm_bravo = Crm.get_crm_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Crm.delete_crm_bravo(socket.assigns.current_scope, crm_bravo)

    {:noreply, stream_delete(socket, :crm_bravos, crm_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Crm.CrmBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :crm_bravos, list_crm_bravos(socket.assigns.current_scope), reset: true)}
  end

  defp list_crm_bravos(current_scope) do
    Crm.list_crm_bravos(current_scope)
  end
end
