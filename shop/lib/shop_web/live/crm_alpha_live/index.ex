defmodule ShopWeb.CrmAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Crm alphas
        <:actions>
          <.button variant="primary" navigate={~p"/crm_alphas/new"}>
            <.icon name="hero-plus" /> New Crm alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="crm_alphas"
        rows={@streams.crm_alphas}
        row_click={fn {_id, crm_alpha} -> JS.navigate(~p"/crm_alphas/#{crm_alpha}") end}
      >
        <:col :let={{_id, crm_alpha}} label="Title">{crm_alpha.title}</:col>
        <:col :let={{_id, crm_alpha}} label="Body">{crm_alpha.body}</:col>
        <:col :let={{_id, crm_alpha}} label="Price">{crm_alpha.price}</:col>
        <:col :let={{_id, crm_alpha}} label="Quantity">{crm_alpha.quantity}</:col>
        <:col :let={{_id, crm_alpha}} label="Active">{crm_alpha.active}</:col>
        <:col :let={{_id, crm_alpha}} label="Due on">{crm_alpha.due_on}</:col>
        <:action :let={{_id, crm_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/crm_alphas/#{crm_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/crm_alphas/#{crm_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, crm_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: crm_alpha.id}) |> hide("##{id}")}
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
      Crm.subscribe_crm_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Crm alphas")
     |> stream(:crm_alphas, list_crm_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    crm_alpha = Crm.get_crm_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Crm.delete_crm_alpha(socket.assigns.current_scope, crm_alpha)

    {:noreply, stream_delete(socket, :crm_alphas, crm_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Crm.CrmAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :crm_alphas, list_crm_alphas(socket.assigns.current_scope), reset: true)}
  end

  defp list_crm_alphas(current_scope) do
    Crm.list_crm_alphas(current_scope)
  end
end
