defmodule ShopWeb.ContentBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Content bravos
        <:actions>
          <.button variant="primary" navigate={~p"/content_bravos/new"}>
            <.icon name="hero-plus" /> New Content bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="content_bravos"
        rows={@streams.content_bravos}
        row_click={fn {_id, content_bravo} -> JS.navigate(~p"/content_bravos/#{content_bravo}") end}
      >
        <:col :let={{_id, content_bravo}} label="Title">{content_bravo.title}</:col>
        <:col :let={{_id, content_bravo}} label="Body">{content_bravo.body}</:col>
        <:col :let={{_id, content_bravo}} label="Price">{content_bravo.price}</:col>
        <:col :let={{_id, content_bravo}} label="Quantity">{content_bravo.quantity}</:col>
        <:col :let={{_id, content_bravo}} label="Active">{content_bravo.active}</:col>
        <:col :let={{_id, content_bravo}} label="Due on">{content_bravo.due_on}</:col>
        <:action :let={{_id, content_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/content_bravos/#{content_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/content_bravos/#{content_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, content_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: content_bravo.id}) |> hide("##{id}")}
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
      Content.subscribe_content_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Content bravos")
     |> stream(:content_bravos, list_content_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_bravo = Content.get_content_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Content.delete_content_bravo(socket.assigns.current_scope, content_bravo)

    {:noreply, stream_delete(socket, :content_bravos, content_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Content.ContentBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :content_bravos, list_content_bravos(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_content_bravos(current_scope) do
    Content.list_content_bravos(current_scope)
  end
end
