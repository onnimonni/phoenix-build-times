defmodule ShopWeb.SupportAlphaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Support alpha {@support_alpha.id}
        <:subtitle>This is a support_alpha record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/support_alphas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/support_alphas/#{@support_alpha}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit support_alpha
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@support_alpha.title}</:item>
        <:item title="Body">{@support_alpha.body}</:item>
        <:item title="Price">{@support_alpha.price}</:item>
        <:item title="Quantity">{@support_alpha.quantity}</:item>
        <:item title="Active">{@support_alpha.active}</:item>
        <:item title="Due on">{@support_alpha.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Support.subscribe_support_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Support alpha")
     |> assign(:support_alpha, Support.get_support_alpha!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Support.SupportAlpha{id: id} = support_alpha},
        %{assigns: %{support_alpha: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :support_alpha, support_alpha)}
  end

  def handle_info(
        {:deleted, %Shop.Support.SupportAlpha{id: id}},
        %{assigns: %{support_alpha: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current support_alpha was deleted.")
     |> push_navigate(to: ~p"/support_alphas")}
  end

  def handle_info({type, %Shop.Support.SupportAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
