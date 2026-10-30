defmodule ShopWeb.CrmCharlieLive.Form do
  use ShopWeb, :live_view

  alias Shop.Crm
  alias Shop.Crm.CrmCharlie

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage crm_charlie records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="crm_charlie-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Crm charlie</.button>
          <.button navigate={return_path(@current_scope, @return_to, @crm_charlie)}>Cancel</.button>
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
    crm_charlie = Crm.get_crm_charlie!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Crm charlie")
    |> assign(:crm_charlie, crm_charlie)
    |> assign(:form, to_form(Crm.change_crm_charlie(socket.assigns.current_scope, crm_charlie)))
  end

  defp apply_action(socket, :new, _params) do
    crm_charlie = %CrmCharlie{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Crm charlie")
    |> assign(:crm_charlie, crm_charlie)
    |> assign(:form, to_form(Crm.change_crm_charlie(socket.assigns.current_scope, crm_charlie)))
  end

  @impl true
  def handle_event("validate", %{"crm_charlie" => crm_charlie_params}, socket) do
    changeset =
      Crm.change_crm_charlie(
        socket.assigns.current_scope,
        socket.assigns.crm_charlie,
        crm_charlie_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"crm_charlie" => crm_charlie_params}, socket) do
    save_crm_charlie(socket, socket.assigns.live_action, crm_charlie_params)
  end

  defp save_crm_charlie(socket, :edit, crm_charlie_params) do
    case Crm.update_crm_charlie(
           socket.assigns.current_scope,
           socket.assigns.crm_charlie,
           crm_charlie_params
         ) do
      {:ok, crm_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crm charlie updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, crm_charlie)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_crm_charlie(socket, :new, crm_charlie_params) do
    case Crm.create_crm_charlie(socket.assigns.current_scope, crm_charlie_params) do
      {:ok, crm_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crm charlie created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, crm_charlie)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _crm_charlie), do: ~p"/crm_charlies"
  defp return_path(_scope, "show", crm_charlie), do: ~p"/crm_charlies/#{crm_charlie}"
end
