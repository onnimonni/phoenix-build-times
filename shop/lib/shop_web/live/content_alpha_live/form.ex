defmodule ShopWeb.ContentAlphaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Content
  alias Shop.Content.ContentAlpha

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage content_alpha records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="content_alpha-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Content alpha</.button>
          <.button navigate={return_path(@current_scope, @return_to, @content_alpha)}>Cancel</.button>
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
    content_alpha = Content.get_content_alpha!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Content alpha")
    |> assign(:content_alpha, content_alpha)
    |> assign(
      :form,
      to_form(Content.change_content_alpha(socket.assigns.current_scope, content_alpha))
    )
  end

  defp apply_action(socket, :new, _params) do
    content_alpha = %ContentAlpha{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Content alpha")
    |> assign(:content_alpha, content_alpha)
    |> assign(
      :form,
      to_form(Content.change_content_alpha(socket.assigns.current_scope, content_alpha))
    )
  end

  @impl true
  def handle_event("validate", %{"content_alpha" => content_alpha_params}, socket) do
    changeset =
      Content.change_content_alpha(
        socket.assigns.current_scope,
        socket.assigns.content_alpha,
        content_alpha_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"content_alpha" => content_alpha_params}, socket) do
    save_content_alpha(socket, socket.assigns.live_action, content_alpha_params)
  end

  defp save_content_alpha(socket, :edit, content_alpha_params) do
    case Content.update_content_alpha(
           socket.assigns.current_scope,
           socket.assigns.content_alpha,
           content_alpha_params
         ) do
      {:ok, content_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content alpha updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, content_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_content_alpha(socket, :new, content_alpha_params) do
    case Content.create_content_alpha(socket.assigns.current_scope, content_alpha_params) do
      {:ok, content_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content alpha created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, content_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _content_alpha), do: ~p"/content_alphas"
  defp return_path(_scope, "show", content_alpha), do: ~p"/content_alphas/#{content_alpha}"
end
