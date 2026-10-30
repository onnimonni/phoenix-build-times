defmodule ShopWeb.BillingAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Billing alpha {@billing_alpha.id}
        <:subtitle>This is a billing_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/billing_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/billing_alphas/#{@billing_alpha}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit billing_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@billing_alpha.title}</:item>
        <:item title="Body">{@billing_alpha.body}</:item>
        <:item title="Price">{@billing_alpha.price}</:item>
        <:item title="Quantity">{@billing_alpha.quantity}</:item>
        <:item title="Active">{@billing_alpha.active}</:item>
        <:item title="Due on">{@billing_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Billing.subscribe_billing_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Billing alpha")
     |> assign(:billing_alpha, Billing.get_billing_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Billing.BillingAlpha{id: id} = billing_alpha},
        %{assigns: %{billing_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :billing_alpha, billing_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Billing.BillingAlpha{id: id}},
        %{assigns: %{billing_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current billing_alpha was deleted.")
     |> push_navigate(to: ~p"/billing_alphas")}
  end

  def handle_info({type, %Shop.Billing.BillingAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
