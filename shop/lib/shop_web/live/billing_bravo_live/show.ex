defmodule ShopWeb.BillingBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Billing bravo {@billing_bravo.id}
        <:subtitle>This is a billing_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/billing_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/billing_bravos/#{@billing_bravo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit billing_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@billing_bravo.title}</:item>
        <:item title="Body">{@billing_bravo.body}</:item>
        <:item title="Price">{@billing_bravo.price}</:item>
        <:item title="Quantity">{@billing_bravo.quantity}</:item>
        <:item title="Active">{@billing_bravo.active}</:item>
        <:item title="Due on">{@billing_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Billing.subscribe_billing_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Billing bravo")
     |> assign(:billing_bravo, Billing.get_billing_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Billing.BillingBravo{id: id} = billing_bravo},
        %{assigns: %{billing_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :billing_bravo, billing_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Billing.BillingBravo{id: id}},
        %{assigns: %{billing_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current billing_bravo was deleted.")
     |> push_navigate(to: ~p"/billing_bravos")}
  end

  def handle_info({type, %Shop.Billing.BillingBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
