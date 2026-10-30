defmodule ShopWeb.BillingEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Billing

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Billing echo {@billing_echo.id}
        <:subtitle>This is a billing_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/billing_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/billing_echos/#{@billing_echo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit billing_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@billing_echo.title}</:item>
        <:item title="Body">{@billing_echo.body}</:item>
        <:item title="Price">{@billing_echo.price}</:item>
        <:item title="Quantity">{@billing_echo.quantity}</:item>
        <:item title="Active">{@billing_echo.active}</:item>
        <:item title="Due on">{@billing_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Billing.subscribe_billing_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Billing echo")
     |> assign(:billing_echo, Billing.get_billing_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Billing.BillingEcho{id: id} = billing_echo},
        %{assigns: %{billing_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :billing_echo, billing_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Billing.BillingEcho{id: id}},
        %{assigns: %{billing_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current billing_echo was deleted.")
     |> push_navigate(to: ~p"/billing_echos")}
  end

  def handle_info({type, %Shop.Billing.BillingEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
