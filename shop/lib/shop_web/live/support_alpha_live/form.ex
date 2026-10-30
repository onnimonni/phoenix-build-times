defmodule ShopWeb.SupportAlphaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Support
  alias Shop.Support.SupportAlpha

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage support_alpha records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="support_alpha-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Support alpha</.button>
          <.button navigate={return_path(@current_scope, @return_to, @support_alpha)}>Cancel</.button>
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
    support_alpha = Support.get_support_alpha!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Support alpha")
    |> assign(:support_alpha, support_alpha)
    |> assign(
      :form,
      to_form(Support.change_support_alpha(socket.assigns.current_scope, support_alpha))
    )
  end

  defp apply_action(socket, :new, _params) do
    support_alpha = %SupportAlpha{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Support alpha")
    |> assign(:support_alpha, support_alpha)
    |> assign(
      :form,
      to_form(Support.change_support_alpha(socket.assigns.current_scope, support_alpha))
    )
  end

  @impl true
  def handle_event("validate", %{"support_alpha" => support_alpha_params}, socket) do
    changeset =
      Support.change_support_alpha(
        socket.assigns.current_scope,
        socket.assigns.support_alpha,
        support_alpha_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"support_alpha" => support_alpha_params}, socket) do
    save_support_alpha(socket, socket.assigns.live_action, support_alpha_params)
  end

  defp save_support_alpha(socket, :edit, support_alpha_params) do
    case Support.update_support_alpha(
           socket.assigns.current_scope,
           socket.assigns.support_alpha,
           support_alpha_params
         ) do
      {:ok, support_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Support alpha updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, support_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_support_alpha(socket, :new, support_alpha_params) do
    case Support.create_support_alpha(socket.assigns.current_scope, support_alpha_params) do
      {:ok, support_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Support alpha created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, support_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _support_alpha), do: ~p"/support_alphas"
  defp return_path(_scope, "show", support_alpha), do: ~p"/support_alphas/#{support_alpha}"
end
