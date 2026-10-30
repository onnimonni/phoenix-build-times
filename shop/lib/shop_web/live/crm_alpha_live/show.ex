defmodule ShopWeb.CrmAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Crm

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Crm alpha {@crm_alpha.id}
        <:subtitle>This is a crm_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/crm_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/crm_alphas/#{@crm_alpha}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit crm_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@crm_alpha.title}</:item>
        <:item title="Body">{@crm_alpha.body}</:item>
        <:item title="Price">{@crm_alpha.price}</:item>
        <:item title="Quantity">{@crm_alpha.quantity}</:item>
        <:item title="Active">{@crm_alpha.active}</:item>
        <:item title="Due on">{@crm_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Crm.subscribe_crm_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Crm alpha")
     |> assign(:crm_alpha, Crm.get_crm_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Crm.CrmAlpha{id: id} = crm_alpha},
        %{assigns: %{crm_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :crm_alpha, crm_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Crm.CrmAlpha{id: id}},
        %{assigns: %{crm_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current crm_alpha was deleted.")
     |> push_navigate(to: ~p"/crm_alphas")}
  end

  def handle_info({type, %Shop.Crm.CrmAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
