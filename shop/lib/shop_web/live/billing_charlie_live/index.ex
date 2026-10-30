defmodule ShopWeb.BillingCharlieLive.Index do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Billing charlies
        <:actions>
          <.button variant="primary" navigate={~p"/billing_charlies/new"}>
            <.icon name="hero-plus" /> New Billing charlie
          </.button>
        </:actions>
      </.header>

      <.table
        id="billing_charlies"
        rows={@streams.billing_charlies}
        row_click={
          fn {_id, billing_charlie} -> JS.navigate(~p"/billing_charlies/#{billing_charlie}") end
        }
      >
        <:col :let={{_id, billing_charlie}} label="Title">{billing_charlie.title}</:col>
        <:col :let={{_id, billing_charlie}} label="Body">{billing_charlie.body}</:col>
        <:col :let={{_id, billing_charlie}} label="Price">{billing_charlie.price}</:col>
        <:col :let={{_id, billing_charlie}} label="Quantity">{billing_charlie.quantity}</:col>
        <:col :let={{_id, billing_charlie}} label="Active">{billing_charlie.active}</:col>
        <:col :let={{_id, billing_charlie}} label="Due on">{billing_charlie.due_on}</:col>
        <:action :let={{_id, billing_charlie}}>
          <div class="sr-only">
            <.link navigate={~p"/billing_charlies/#{billing_charlie}"}>Show</.link>
          </div>
          <.link navigate={~p"/billing_charlies/#{billing_charlie}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, billing_charlie}}>
          <.link
            phx-click={JS.push("delete", value: %{id: billing_charlie.id}) |> hide("##{id}")}
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
      Billing.subscribe_billing_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Billing charlies")
     |> stream(:billing_charlies, list_billing_charlies(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    billing_charlie = Billing.get_billing_charlie!(socket.assigns.current_scope, id)
    {:ok, _} = Billing.delete_billing_charlie(socket.assigns.current_scope, billing_charlie)

    {:noreply, stream_delete(socket, :billing_charlies, billing_charlie)}
  end

  @impl true
  def handle_info({type, %Shop.Billing.BillingCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :billing_charlies, list_billing_charlies(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_billing_charlies(current_scope) do
    Billing.list_billing_charlies(current_scope)
  end
end
