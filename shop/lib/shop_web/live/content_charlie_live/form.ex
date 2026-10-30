defmodule ShopWeb.ContentCharlieLive.Form do
  use ShopWeb, :live_view

  alias Shop.Content
  alias Shop.Content.ContentCharlie

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage content_charlie records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="content_charlie-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Content charlie</.button>
          <.button navigate={return_path(@current_scope, @return_to, @content_charlie)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    content_charlie = Content.get_content_charlie!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Content charlie")
    |> assign(:content_charlie, content_charlie)
    |> assign(
      :form,
      to_form(Content.change_content_charlie(socket.assigns.current_scope, content_charlie))
    )
  end

  defp apply_action(socket, :new, _params) do
    content_charlie = %ContentCharlie{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Content charlie")
    |> assign(:content_charlie, content_charlie)
    |> assign(
      :form,
      to_form(Content.change_content_charlie(socket.assigns.current_scope, content_charlie))
    )
  end

  @impl true
  def handle_event("validate", %{"content_charlie" => content_charlie_params}, socket) do
    changeset =
      Content.change_content_charlie(
        socket.assigns.current_scope,
        socket.assigns.content_charlie,
        content_charlie_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"content_charlie" => content_charlie_params}, socket) do
    save_content_charlie(socket, socket.assigns.live_action, content_charlie_params)
  end

  defp save_content_charlie(socket, :edit, content_charlie_params) do
    case Content.update_content_charlie(
           socket.assigns.current_scope,
           socket.assigns.content_charlie,
           content_charlie_params
         ) do
      {:ok, content_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content charlie updated successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, content_charlie)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_content_charlie(socket, :new, content_charlie_params) do
    case Content.create_content_charlie(socket.assigns.current_scope, content_charlie_params) do
      {:ok, content_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content charlie created successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, content_charlie)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _content_charlie), do: ~p"/content_charlies"
  defp return_path(_scope, "show", content_charlie), do: ~p"/content_charlies/#{content_charlie}"
end
