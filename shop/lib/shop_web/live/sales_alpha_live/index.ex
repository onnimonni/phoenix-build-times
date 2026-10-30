defmodule ShopWeb.SalesAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Sales

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Sales alphas
        <:actions>
          <.button variant="primary" navigate={~p"/sales_alphas/new"}>
            <.icon name="hero-plus" /> New Sales alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="sales_alphas"
        rows={@streams.sales_alphas}
        row_click={fn {_id, sales_alpha} -> JS.navigate(~p"/sales_alphas/#{sales_alpha}") end}
      >
        <:col :let={{_id, sales_alpha}} label="Title">{sales_alpha.title}</:col>
        <:col :let={{_id, sales_alpha}} label="Body">{sales_alpha.body}</:col>
        <:col :let={{_id, sales_alpha}} label="Price">{sales_alpha.price}</:col>
        <:col :let={{_id, sales_alpha}} label="Quantity">{sales_alpha.quantity}</:col>
        <:col :let={{_id, sales_alpha}} label="Active">{sales_alpha.active}</:col>
        <:col :let={{_id, sales_alpha}} label="Due on">{sales_alpha.due_on}</:col>
        <:action :let={{_id, sales_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/sales_alphas/#{sales_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/sales_alphas/#{sales_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, sales_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: sales_alpha.id}) |> hide("##{id}")}
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
      Sales.subscribe_sales_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Sales alphas")
     |> stream(:sales_alphas, list_sales_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sales_alpha = Sales.get_sales_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Sales.delete_sales_alpha(socket.assigns.current_scope, sales_alpha)

    {:noreply, stream_delete(socket, :sales_alphas, sales_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Sales.SalesAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :sales_alphas, list_sales_alphas(socket.assigns.current_scope), reset: true)}
  end

  defp list_sales_alphas(current_scope) do
    Sales.list_sales_alphas(current_scope)
  end
end
