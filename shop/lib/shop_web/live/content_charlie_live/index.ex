defmodule ShopWeb.ContentCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Content charlies
        <:actions>
          <.button variant="primary" navigate={~p"/content_charlies/new"}>
            <.icon name="hero-plus" /> New Content charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="content_charlies"
        rows={@streams.content_charlies}
        row_click={
          fn {_id, content_charlie} -> JS.navigate(~p"/content_charlies/#{content_charlie}") end
        }
      >
        <:col :let={{_id, content_charlie}} label="Title">{content_charlie.title}</:col>
        <:col :let={{_id, content_charlie}} label="Body">{content_charlie.body}</:col>
        <:col :let={{_id, content_charlie}} label="Price">{content_charlie.price}</:col>
        <:col :let={{_id, content_charlie}} label="Quantity">{content_charlie.quantity}</:col>
        <:col :let={{_id, content_charlie}} label="Active">{content_charlie.active}</:col>
        <:col :let={{_id, content_charlie}} label="Due on">{content_charlie.due_on}</:col>
        <:action :let={{_id, content_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/content_charlies/#{content_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/content_charlies/#{content_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, content_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: content_charlie.id}) |> hide("##{id}")}
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
      Content.subscribe_content_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Content charlies")
     |> stream(:content_charlies, list_content_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_charlie = Content.get_content_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Content.delete_content_charlie(socket.assigns.current_scope, content_charlie)

    {:noreply, stream_delete(socket, :content_charlies, content_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Content.ContentCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :content_charlies, list_content_charlies(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_content_charlies(current_scope) do
    Content.list_content_charlies(current_scope)
  end
end
