defmodule ShopWeb.SalesCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Sales charlies
        <:actions>
          <.button variant="primary" navigate={~p"/sales_charlies/new"}>
            <.icon name="hero-plus" /> New Sales charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="sales_charlies"
        rows={@streams.sales_charlies}
        row_click={fn {_id, sales_charlie} -> JS.navigate(~p"/sales_charlies/#{sales_charlie}") end}
      >
        <:col :let={{_id, sales_charlie}} label="Title">{sales_charlie.title}</:col>
        <:col :let={{_id, sales_charlie}} label="Body">{sales_charlie.body}</:col>
        <:col :let={{_id, sales_charlie}} label="Price">{sales_charlie.price}</:col>
        <:col :let={{_id, sales_charlie}} label="Quantity">{sales_charlie.quantity}</:col>
        <:col :let={{_id, sales_charlie}} label="Active">{sales_charlie.active}</:col>
        <:col :let={{_id, sales_charlie}} label="Due on">{sales_charlie.due_on}</:col>
        <:action :let={{_id, sales_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/sales_charlies/#{sales_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/sales_charlies/#{sales_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, sales_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: sales_charlie.id}) |> hide("##{id}")}
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
      Sales.subscribe_sales_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Sales charlies")
     |> stream(:sales_charlies, list_sales_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sales_charlie = Sales.get_sales_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Sales.delete_sales_charlie(socket.assigns.current_scope, sales_charlie)

    {:noreply, stream_delete(socket, :sales_charlies, sales_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Sales.SalesCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :sales_charlies, list_sales_charlies(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_sales_charlies(current_scope) do
    Sales.list_sales_charlies(current_scope)
  end
end
