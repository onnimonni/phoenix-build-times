defmodule ShopWeb.CrmAlphaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Crm
  alias Shop.Crm.CrmAlpha

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage crm_alpha records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="crm_alpha-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Crm alpha</.button>
          <.button navigate={return_path(@current_scope, @return_to, @crm_alpha)}>Cancel</.button>
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
    crm_alpha = Crm.get_crm_alpha!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Crm alpha")
    |> assign(:crm_alpha, crm_alpha)
    |> assign(:form, to_form(Crm.change_crm_alpha(socket.assigns.current_scope, crm_alpha)))
  end

  defp apply_action(socket, :new, _params) do
    crm_alpha = %CrmAlpha{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Crm alpha")
    |> assign(:crm_alpha, crm_alpha)
    |> assign(:form, to_form(Crm.change_crm_alpha(socket.assigns.current_scope, crm_alpha)))
  end

  @impl true
  def handle_event("validate", %{"crm_alpha" => crm_alpha_params}, socket) do
    changeset =
      Crm.change_crm_alpha(
        socket.assigns.current_scope,
        socket.assigns.crm_alpha,
        crm_alpha_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"crm_alpha" => crm_alpha_params}, socket) do
    save_crm_alpha(socket, socket.assigns.live_action, crm_alpha_params)
  end

  defp save_crm_alpha(socket, :edit, crm_alpha_params) do
    case Crm.update_crm_alpha(
           socket.assigns.current_scope,
           socket.assigns.crm_alpha,
           crm_alpha_params
         ) do
      {:ok, crm_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crm alpha updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, crm_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_crm_alpha(socket, :new, crm_alpha_params) do
    case Crm.create_crm_alpha(socket.assigns.current_scope, crm_alpha_params) do
      {:ok, crm_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crm alpha created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, crm_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _crm_alpha), do: ~p"/crm_alphas"
  defp return_path(_scope, "show", crm_alpha), do: ~p"/crm_alphas/#{crm_alpha}"
end
