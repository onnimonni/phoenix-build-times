defmodule ShopWeb.SupportBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Support bravos
        <:actions>
          <.button variant="primary" navigate={~p"/support_bravos/new"}>
            <.icon name="hero-plus" /> New Support bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="support_bravos"
        rows={@streams.support_bravos}
        row_click={fn {_id, support_bravo} -> JS.navigate(~p"/support_bravos/#{support_bravo}") end}
      >
        <:col :let={{_id, support_bravo}} label="Title">{support_bravo.title}</:col>
        <:col :let={{_id, support_bravo}} label="Body">{support_bravo.body}</:col>
        <:col :let={{_id, support_bravo}} label="Price">{support_bravo.price}</:col>
        <:col :let={{_id, support_bravo}} label="Quantity">{support_bravo.quantity}</:col>
        <:col :let={{_id, support_bravo}} label="Active">{support_bravo.active}</:col>
        <:col :let={{_id, support_bravo}} label="Due on">{support_bravo.due_on}</:col>
        <:action :let={{_id, support_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/support_bravos/#{support_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/support_bravos/#{support_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, support_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: support_bravo.id}) |> hide("##{id}")}
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
      Support.subscribe_support_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Support bravos")
     |> stream(:support_bravos, list_support_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    support_bravo = Support.get_support_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Support.delete_support_bravo(socket.assigns.current_scope, support_bravo)

    {:noreply, stream_delete(socket, :support_bravos, support_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Support.SupportBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :support_bravos, list_support_bravos(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_support_bravos(current_scope) do
    Support.list_support_bravos(current_scope)
  end
end
