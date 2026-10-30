defmodule ShopWeb.BillingCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Billing charlie {@billing_charlie.id}
        <:subtitle>This is a billing_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/billing_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/billing_charlies/#{@billing_charlie}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit billing_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@billing_charlie.title}</:item>
        <:item title="Body">{@billing_charlie.body}</:item>
        <:item title="Price">{@billing_charlie.price}</:item>
        <:item title="Quantity">{@billing_charlie.quantity}</:item>
        <:item title="Active">{@billing_charlie.active}</:item>
        <:item title="Due on">{@billing_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Billing.subscribe_billing_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Billing charlie")
     |> assign(:billing_charlie, Billing.get_billing_charlie!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Billing.BillingCharlie{id: id} = billing_charlie},
        %{assigns: %{billing_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :billing_charlie, billing_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Billing.BillingCharlie{id: id}},
        %{assigns: %{billing_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current billing_charlie was deleted.")
     |> push_navigate(to: ~p"/billing_charlies")}
  end

  def handle_info({type, %Shop.Billing.BillingCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
