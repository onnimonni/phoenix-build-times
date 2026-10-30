defmodule ShopWeb.CrmEchoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Crm echo {@crm_echo.id}
        <:subtitle>This is a crm_echo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/crm_echos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/crm_echos/#{@crm_echo}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit crm_echo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@crm_echo.title}</:item>
        <:item title="Body">{@crm_echo.body}</:item>
        <:item title="Price">{@crm_echo.price}</:item>
        <:item title="Quantity">{@crm_echo.quantity}</:item>
        <:item title="Active">{@crm_echo.active}</:item>
        <:item title="Due on">{@crm_echo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Crm.subscribe_crm_echos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Crm echo")
     |> assign(:crm_echo, Crm.get_crm_echo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Crm.CrmEcho{id: id} = crm_echo},
        %{assigns: %{crm_echo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :crm_echo, crm_echo)}
  end

  def handle_info(
        {:deleted, %Shop.Crm.CrmEcho{id: id}},
        %{assigns: %{crm_echo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current crm_echo was deleted.")
     |> push_navigate(to: ~p"/crm_echos")}
  end

  def handle_info({type, %Shop.Crm.CrmEcho{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
