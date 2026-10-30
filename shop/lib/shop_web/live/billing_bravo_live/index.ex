defmodule ShopWeb.BillingBravoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Billing bravos
        <:actions>
          <.button variant="primary" navigate={~p"/billing_bravos/new"}>
            <.icon name="hero-plus" /> New Billing bravo
          </.button>
        </:actions>
      </.header>

      <.table
        id="billing_bravos"
        rows={@streams.billing_bravos}
        row_click={fn {_id, billing_bravo} -> JS.navigate(~p"/billing_bravos/#{billing_bravo}") end}
      >
        <:col :let={{_id, billing_bravo}} label="Title">{billing_bravo.title}</:col>
        <:col :let={{_id, billing_bravo}} label="Body">{billing_bravo.body}</:col>
        <:col :let={{_id, billing_bravo}} label="Price">{billing_bravo.price}</:col>
        <:col :let={{_id, billing_bravo}} label="Quantity">{billing_bravo.quantity}</:col>
        <:col :let={{_id, billing_bravo}} label="Active">{billing_bravo.active}</:col>
        <:col :let={{_id, billing_bravo}} label="Due on">{billing_bravo.due_on}</:col>
        <:action :let={{_id, billing_bravo}}>
          <div class="sr-only">
            <.link navigate={~p"/billing_bravos/#{billing_bravo}"}>Show</.link>
          </div>
          <.link navigate={~p"/billing_bravos/#{billing_bravo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, billing_bravo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: billing_bravo.id}) |> hide("##{id}")}
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
      Billing.subscribe_billing_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Billing bravos")
     |> stream(:billing_bravos, list_billing_bravos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    billing_bravo = Billing.get_billing_bravo!(socket.assigns.current_scope, id)
    {:ok, _} = Billing.delete_billing_bravo(socket.assigns.current_scope, billing_bravo)

    {:noreply, stream_delete(socket, :billing_bravos, billing_bravo)}
  end

  @impl true
  def handle_info({type, %Shop.Billing.BillingBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :billing_bravos, list_billing_bravos(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_billing_bravos(current_scope) do
    Billing.list_billing_bravos(current_scope)
  end
end
