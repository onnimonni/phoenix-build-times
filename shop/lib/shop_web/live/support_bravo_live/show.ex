defmodule ShopWeb.SupportBravoLive.Show do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Support bravo {@support_bravo.id}
        <:subtitle>This is a support_bravo record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/support_bravos"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/support_bravos/#{@support_bravo}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit support_bravo
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@support_bravo.title}</:item>
        <:item title="Body">{@support_bravo.body}</:item>
        <:item title="Price">{@support_bravo.price}</:item>
        <:item title="Quantity">{@support_bravo.quantity}</:item>
        <:item title="Active">{@support_bravo.active}</:item>
        <:item title="Due on">{@support_bravo.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Support.subscribe_support_bravos(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Support bravo")
     |> assign(:support_bravo, Support.get_support_bravo!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Support.SupportBravo{id: id} = support_bravo},
        %{assigns: %{support_bravo: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :support_bravo, support_bravo)}
  end

  def handle_info(
        {:deleted, %Shop.Support.SupportBravo{id: id}},
        %{assigns: %{support_bravo: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current support_bravo was deleted.")
     |> push_navigate(to: ~p"/support_bravos")}
  end

  def handle_info({type, %Shop.Support.SupportBravo{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
