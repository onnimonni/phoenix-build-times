defmodule ShopWeb.BillingDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Billing delta {@billing_delta.id}
        <:subtitle>This is a billing_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/billing_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/billing_deltas/#{@billing_delta}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit billing_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@billing_delta.title}</:item>
        <:item title="Body">{@billing_delta.body}</:item>
        <:item title="Price">{@billing_delta.price}</:item>
        <:item title="Quantity">{@billing_delta.quantity}</:item>
        <:item title="Active">{@billing_delta.active}</:item>
        <:item title="Due on">{@billing_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Billing.subscribe_billing_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Billing delta")
     |> assign(:billing_delta, Billing.get_billing_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Billing.BillingDelta{id: id} = billing_delta},
        %{assigns: %{billing_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :billing_delta, billing_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Billing.BillingDelta{id: id}},
        %{assigns: %{billing_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current billing_delta was deleted.")
     |> push_navigate(to: ~p"/billing_deltas")}
  end

  def handle_info({type, %Shop.Billing.BillingDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
