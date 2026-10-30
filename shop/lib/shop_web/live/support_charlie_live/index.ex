defmodule ShopWeb.SupportCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Support charlies
        <:actions>
          <.button variant="primary" navigate={~p"/support_charlies/new"}>
            <.icon name="hero-plus" /> New Support charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="support_charlies"
        rows={@streams.support_charlies}
        row_click={
          fn {_id, support_charlie} -> JS.navigate(~p"/support_charlies/#{support_charlie}") end
        }
      >
        <:col :let={{_id, support_charlie}} label="Title">{support_charlie.title}</:col>
        <:col :let={{_id, support_charlie}} label="Body">{support_charlie.body}</:col>
        <:col :let={{_id, support_charlie}} label="Price">{support_charlie.price}</:col>
        <:col :let={{_id, support_charlie}} label="Quantity">{support_charlie.quantity}</:col>
        <:col :let={{_id, support_charlie}} label="Active">{support_charlie.active}</:col>
        <:col :let={{_id, support_charlie}} label="Due on">{support_charlie.due_on}</:col>
        <:action :let={{_id, support_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/support_charlies/#{support_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/support_charlies/#{support_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, support_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: support_charlie.id}) |> hide("##{id}")}
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
      Support.subscribe_support_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Support charlies")
     |> stream(:support_charlies, list_support_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    support_charlie = Support.get_support_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Support.delete_support_charlie(socket.assigns.current_scope, support_charlie)

    {:noreply, stream_delete(socket, :support_charlies, support_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Support.SupportCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :support_charlies, list_support_charlies(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_support_charlies(current_scope) do
    Support.list_support_charlies(current_scope)
  end
end
