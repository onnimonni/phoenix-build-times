defmodule ShopWeb.SupportCharlieLive.Show do
  use ShopWeb, :live_view

  alias Shop.Support

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Support charlie {@support_charlie.id}
        <:subtitle>This is a support_charlie record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/support_charlies"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button
            variant="primary"
            navigate={~p"/support_charlies/#{@support_charlie}/edit?return_to=show"}
          >
            <.icon name="hero-pencil-square" /> Edit support_charlie
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@support_charlie.title}</:item>
        <:item title="Body">{@support_charlie.body}</:item>
        <:item title="Price">{@support_charlie.price}</:item>
        <:item title="Quantity">{@support_charlie.quantity}</:item>
        <:item title="Active">{@support_charlie.active}</:item>
        <:item title="Due on">{@support_charlie.due_on}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Support.subscribe_support_charlies(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Support charlie")
     |> assign(:support_charlie, Support.get_support_charlie!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Shop.Support.SupportCharlie{id: id} = support_charlie},
        %{assigns: %{support_charlie: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :support_charlie, support_charlie)}
  end

  def handle_info(
        {:deleted, %Shop.Support.SupportCharlie{id: id}},
        %{assigns: %{support_charlie: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current support_charlie was deleted.")
     |> push_navigate(to: ~p"/support_charlies")}
  end

  def handle_info({type, %Shop.Support.SupportCharlie{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
