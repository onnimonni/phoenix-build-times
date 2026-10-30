defmodule ShopWeb.SupportAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Support alphas
        <:actions>
          <.button variant="primary" navigate={~p"/support_alphas/new"}>
            <.icon name="hero-plus" /> New Support alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="support_alphas"
        rows={@streams.support_alphas}
        row_click={fn {_id, support_alpha} -> JS.navigate(~p"/support_alphas/#{support_alpha}") end}
      >
        <:col :let={{_id, support_alpha}} label="Title">{support_alpha.title}</:col>
        <:col :let={{_id, support_alpha}} label="Body">{support_alpha.body}</:col>
        <:col :let={{_id, support_alpha}} label="Price">{support_alpha.price}</:col>
        <:col :let={{_id, support_alpha}} label="Quantity">{support_alpha.quantity}</:col>
        <:col :let={{_id, support_alpha}} label="Active">{support_alpha.active}</:col>
        <:col :let={{_id, support_alpha}} label="Due on">{support_alpha.due_on}</:col>
        <:action :let={{_id, support_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/support_alphas/#{support_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/support_alphas/#{support_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, support_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: support_alpha.id}) |> hide("##{id}")}
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
      Support.subscribe_support_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Support alphas")
     |> stream(:support_alphas, list_support_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    support_alpha = Support.get_support_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Support.delete_support_alpha(socket.assigns.current_scope, support_alpha)

    {:noreply, stream_delete(socket, :support_alphas, support_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Support.SupportAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :support_alphas, list_support_alphas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_support_alphas(current_scope) do
    Support.list_support_alphas(current_scope)
  end
end
