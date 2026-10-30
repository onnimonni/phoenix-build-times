defmodule ShopWeb.CrmBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Crm bravo {@crm_bravo.id}
        <:subtitle>This is a crm_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/crm_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/crm_bravos/#{@crm_bravo}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit crm_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@crm_bravo.title}</:item>
        <:item title="Body">{@crm_bravo.body}</:item>
        <:item title="Price">{@crm_bravo.price}</:item>
        <:item title="Quantity">{@crm_bravo.quantity}</:item>
        <:item title="Active">{@crm_bravo.active}</:item>
        <:item title="Due on">{@crm_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Crm.subscribe_crm_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Crm bravo")
     |> assign(:crm_bravo, Crm.get_crm_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Crm.CrmBravo{id: id} = crm_bravo},
        %{assigns: %{crm_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :crm_bravo, crm_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Crm.CrmBravo{id: id}},
        %{assigns: %{crm_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current crm_bravo was deleted.")
     |> push_navigate(to: ~p"/crm_bravos")}
  end

  def handle_info({type, %Shop.Crm.CrmBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
