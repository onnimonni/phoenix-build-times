defmodule ShopWeb.BillingAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Billing alphas
        <:actions>
          <.button variant="primary" navigate={~p"/billing_alphas/new"}>
            <.icon name="hero-plus" /> New Billing alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="billing_alphas"
        rows={@streams.billing_alphas}
        row_click={fn {_id, billing_alpha} -> JS.navigate(~p"/billing_alphas/#{billing_alpha}") end}
      >
        <:col :let={{_id, billing_alpha}} label="Title">{billing_alpha.title}</:col>
        <:col :let={{_id, billing_alpha}} label="Body">{billing_alpha.body}</:col>
        <:col :let={{_id, billing_alpha}} label="Price">{billing_alpha.price}</:col>
        <:col :let={{_id, billing_alpha}} label="Quantity">{billing_alpha.quantity}</:col>
        <:col :let={{_id, billing_alpha}} label="Active">{billing_alpha.active}</:col>
        <:col :let={{_id, billing_alpha}} label="Due on">{billing_alpha.due_on}</:col>
        <:action :let={{_id, billing_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/billing_alphas/#{billing_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/billing_alphas/#{billing_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, billing_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: billing_alpha.id}) |> hide("##{id}")}
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
      Billing.subscribe_billing_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Billing alphas")
     |> stream(:billing_alphas, list_billing_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    billing_alpha = Billing.get_billing_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Billing.delete_billing_alpha(socket.assigns.current_scope, billing_alpha)

    {:noreply, stream_delete(socket, :billing_alphas, billing_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Billing.BillingAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :billing_alphas, list_billing_alphas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_billing_alphas(current_scope) do
    Billing.list_billing_alphas(current_scope)
  end
end
