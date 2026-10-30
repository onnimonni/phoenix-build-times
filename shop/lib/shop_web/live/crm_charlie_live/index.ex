defmodule ShopWeb.CrmCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Crm charlies
        <:actions>
          <.button variant="primary" navigate={~p"/crm_charlies/new"}>
            <.icon name="hero-plus" /> New Crm charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="crm_charlies"
        rows={@streams.crm_charlies}
        row_click={fn {_id, crm_charlie} -> JS.navigate(~p"/crm_charlies/#{crm_charlie}") end}
      >
        <:col :let={{_id, crm_charlie}} label="Title">{crm_charlie.title}</:col>
        <:col :let={{_id, crm_charlie}} label="Body">{crm_charlie.body}</:col>
        <:col :let={{_id, crm_charlie}} label="Price">{crm_charlie.price}</:col>
        <:col :let={{_id, crm_charlie}} label="Quantity">{crm_charlie.quantity}</:col>
        <:col :let={{_id, crm_charlie}} label="Active">{crm_charlie.active}</:col>
        <:col :let={{_id, crm_charlie}} label="Due on">{crm_charlie.due_on}</:col>
        <:action :let={{_id, crm_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/crm_charlies/#{crm_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/crm_charlies/#{crm_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, crm_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: crm_charlie.id}) |> hide("##{id}")}
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
      Crm.subscribe_crm_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Crm charlies")
     |> stream(:crm_charlies, list_crm_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    crm_charlie = Crm.get_crm_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Crm.delete_crm_charlie(socket.assigns.current_scope, crm_charlie)

    {:noreply, stream_delete(socket, :crm_charlies, crm_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Crm.CrmCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :crm_charlies, list_crm_charlies(socket.assigns.current_scope), reset: true)}
  end

  defp list_crm_charlies(current_scope) do
    Crm.list_crm_charlies(current_scope)
  end
end
