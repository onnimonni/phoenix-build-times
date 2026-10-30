defmodule ShopWeb.CrmCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Crm charlie {@crm_charlie.id}
        <:subtitle>This is a crm_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/crm_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/crm_charlies/#{@crm_charlie}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit crm_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@crm_charlie.title}</:item>
        <:item title="Body">{@crm_charlie.body}</:item>
        <:item title="Price">{@crm_charlie.price}</:item>
        <:item title="Quantity">{@crm_charlie.quantity}</:item>
        <:item title="Active">{@crm_charlie.active}</:item>
        <:item title="Due on">{@crm_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Crm.subscribe_crm_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Crm charlie")
     |> assign(:crm_charlie, Crm.get_crm_charlie!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Crm.CrmCharlie{id: id} = crm_charlie},
        %{assigns: %{crm_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :crm_charlie, crm_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Crm.CrmCharlie{id: id}},
        %{assigns: %{crm_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current crm_charlie was deleted.")
     |> push_navigate(to: ~p"/crm_charlies")}
  end

  def handle_info({type, %Shop.Crm.CrmCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
