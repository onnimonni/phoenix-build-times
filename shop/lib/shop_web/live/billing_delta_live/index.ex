defmodule ShopWeb.BillingDeltaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Billing deltas
        <:actions>
          <.button variant="primary" navigate={~p"/billing_deltas/new"}>
            <.icon name="hero-plus" /> New Billing delta
          </.button>
        </:actions>
      </.header>

      <.table
        id="billing_deltas"
        rows={@streams.billing_deltas}
        row_click={fn {_id, billing_delta} -> JS.navigate(~p"/billing_deltas/#{billing_delta}") end}
      >
        <:col :let={{_id, billing_delta}} label="Title">{billing_delta.title}</:col>
        <:col :let={{_id, billing_delta}} label="Body">{billing_delta.body}</:col>
        <:col :let={{_id, billing_delta}} label="Price">{billing_delta.price}</:col>
        <:col :let={{_id, billing_delta}} label="Quantity">{billing_delta.quantity}</:col>
        <:col :let={{_id, billing_delta}} label="Active">{billing_delta.active}</:col>
        <:col :let={{_id, billing_delta}} label="Due on">{billing_delta.due_on}</:col>
        <:action :let={{_id, billing_delta}}>
          <div class="sr-only">
            <.link navigate={~p"/billing_deltas/#{billing_delta}"}>Show</.link>
          </div>
          <.link navigate={~p"/billing_deltas/#{billing_delta}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, billing_delta}}>
          <.link
            phx-click={JS.push("delete", value: %{id: billing_delta.id}) |> hide("##{id}")}
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
      Billing.subscribe_billing_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Billing deltas")
     |> stream(:billing_deltas, list_billing_deltas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    billing_delta = Billing.get_billing_delta!(socket.assigns.current_scope, id)
    {:ok, _} = Billing.delete_billing_delta(socket.assigns.current_scope, billing_delta)

    {:noreply, stream_delete(socket, :billing_deltas, billing_delta)}
  end

  @impl true
  def handle_info({type, %Shop.Billing.BillingDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :billing_deltas, list_billing_deltas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_billing_deltas(current_scope) do
    Billing.list_billing_deltas(current_scope)
  end
end
