defmodule ShopWeb.CrmDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Crm delta {@crm_delta.id}
        <:subtitle>This is a crm_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/crm_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/crm_deltas/#{@crm_delta}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit crm_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@crm_delta.title}</:item>
        <:item title="Body">{@crm_delta.body}</:item>
        <:item title="Price">{@crm_delta.price}</:item>
        <:item title="Quantity">{@crm_delta.quantity}</:item>
        <:item title="Active">{@crm_delta.active}</:item>
        <:item title="Due on">{@crm_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Crm.subscribe_crm_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Crm delta")
     |> assign(:crm_delta, Crm.get_crm_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Crm.CrmDelta{id: id} = crm_delta},
        %{assigns: %{crm_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :crm_delta, crm_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Crm.CrmDelta{id: id}},
        %{assigns: %{crm_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current crm_delta was deleted.")
     |> push_navigate(to: ~p"/crm_deltas")}
  end

  def handle_info({type, %Shop.Crm.CrmDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
