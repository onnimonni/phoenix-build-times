defmodule ShopWeb.ContentAlphaLive.Index do
  use ShopWeb, :live_view

  alias Shop.Content

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Content alphas
        <:actions>
          <.button variant="primary" navigate={~p"/content_alphas/new"}>
            <.icon name="hero-plus" /> New Content alpha
          </.button>
        </:actions>
      </.header>

      <.table
        id="content_alphas"
        rows={@streams.content_alphas}
        row_click={fn {_id, content_alpha} -> JS.navigate(~p"/content_alphas/#{content_alpha}") end}
      >
        <:col :let={{_id, content_alpha}} label="Title">{content_alpha.title}</:col>
        <:col :let={{_id, content_alpha}} label="Body">{content_alpha.body}</:col>
        <:col :let={{_id, content_alpha}} label="Price">{content_alpha.price}</:col>
        <:col :let={{_id, content_alpha}} label="Quantity">{content_alpha.quantity}</:col>
        <:col :let={{_id, content_alpha}} label="Active">{content_alpha.active}</:col>
        <:col :let={{_id, content_alpha}} label="Due on">{content_alpha.due_on}</:col>
        <:action :let={{_id, content_alpha}}>
          <div class="sr-only">
            <.link navigate={~p"/content_alphas/#{content_alpha}"}>Show</.link>
          </div>
          <.link navigate={~p"/content_alphas/#{content_alpha}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, content_alpha}}>
          <.link
            phx-click={JS.push("delete", value: %{id: content_alpha.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Content.subscribe_content_alphas(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Content alphas")
     |> stream(:content_alphas, list_content_alphas(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_alpha = Content.get_content_alpha!(socket.assigns.current_scope, id)
    {:ok, _} = Content.delete_content_alpha(socket.assigns.current_scope, content_alpha)

    {:noreply, stream_delete(socket, :content_alphas, content_alpha)}
  end

  @impl true
  def handle_info({type, %Shop.Content.ContentAlpha{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply,
     stream(socket, :content_alphas, list_content_alphas(socket.assigns.current_scope),
       reset: true
     )}
  end

  defp list_content_alphas(current_scope) do
    Content.list_content_alphas(current_scope)
  end
end
