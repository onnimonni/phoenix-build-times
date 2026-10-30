defmodule ShopWeb.BillingEchoLive.Index do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Billing echos
        <:actions>
          <.button variant="primary" navigate={~p"/billing_echos/new"}>
            <.icon name="hero-plus" /> New Billing echo
          </.button>
        </:actions>
      </.header>

      <.table
        id="billing_echos"
        rows={@streams.billing_echos}
        row_click={fn {_id, billing_echo} -> JS.navigate(~p"/billing_echos/#{billing_echo}") end}
      >
        <:col :let={{_id, billing_echo}} label="Title">{billing_echo.title}</:col>
        <:col :let={{_id, billing_echo}} label="Body">{billing_echo.body}</:col>
        <:col :let={{_id, billing_echo}} label="Price">{billing_echo.price}</:col>
        <:col :let={{_id, billing_echo}} label="Quantity">{billing_echo.quantity}</:col>
        <:col :let={{_id, billing_echo}} label="Active">{billing_echo.active}</:col>
        <:col :let={{_id, billing_echo}} label="Due on">{billing_echo.due_on}</:col>
        <:action :let={{_id, billing_echo}}>
          <div class="sr-only">
            <.link navigate={~p"/billing_echos/#{billing_echo}"}>Show</.link>
          </div>
          <.link navigate={~p"/billing_echos/#{billing_echo}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, billing_echo}}>
          <.link
            phx-click={JS.push("delete", value: %{id: billing_echo.id}) |> hide("##{id}")}
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
      Billing.subscribe_billing_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Billing echos")
     |> stream(:billing_echos, list_billing_echos(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    billing_echo = Billing.get_billing_echo!(socket.assigns.current_scope, id)
    {:ok, _} = Billing.delete_billing_echo(socket.assigns.current_scope, billing_echo)

    {:noreply, stream_delete(socket, :billing_echos, billing_echo)}
  end

  @impl true
  def handle_info({type, %Shop.Billing.BillingEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :billing_echos, list_billing_echos(socket.assigns.current_scope), reset: true)}
  end

  defp list_billing_echos(current_scope) do
    Billing.list_billing_echos(current_scope)
  end
end
