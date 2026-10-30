defmodule ShopWeb.SupportDeltaLive.Show do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Support delta {@support_delta.id}
        <:subtitle>This is a support_delta record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/support_deltas"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/support_deltas/#{@support_delta}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit support_delta
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@support_delta.title}</:item>
        <:item title="Body">{@support_delta.body}</:item>
        <:item title="Price">{@support_delta.price}</:item>
        <:item title="Quantity">{@support_delta.quantity}</:item>
        <:item title="Active">{@support_delta.active}</:item>
        <:item title="Due on">{@support_delta.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Support.subscribe_support_deltas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Support delta")
     |> assign(:support_delta, Support.get_support_delta!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Support.SupportDelta{id: id} = support_delta},
        %{assigns: %{support_delta: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :support_delta, support_delta)}
  end

  def handle_info(
        {:deleted, %Shop.Support.SupportDelta{id: id}},
        %{assigns: %{support_delta: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current support_delta was deleted.")
     |> push_navigate(to: ~p"/support_deltas")}
  end

  def handle_info({type, %Shop.Support.SupportDelta{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
