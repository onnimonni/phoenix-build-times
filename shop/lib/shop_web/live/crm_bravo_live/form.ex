defmodule ShopWeb.CrmBravoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Crm
  alias Shop.Crm.CrmBravo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage crm_bravo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="crm_bravo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Crm bravo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @crm_bravo)}>Cancel</.button>
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
    crm_bravo = Crm.get_crm_bravo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Crm bravo")
    |> assign(:crm_bravo, crm_bravo)
    |> assign(:form, to_form(Crm.change_crm_bravo(socket.assigns.current_scope, crm_bravo)))
  end

  defp apply_action(socket, :new, _params) do
    crm_bravo = %CrmBravo{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Crm bravo")
    |> assign(:crm_bravo, crm_bravo)
    |> assign(:form, to_form(Crm.change_crm_bravo(socket.assigns.current_scope, crm_bravo)))
  end

  @impl true
  def handle_event("validate", %{"crm_bravo" => crm_bravo_params}, socket) do
    changeset =
      Crm.change_crm_bravo(
        socket.assigns.current_scope,
        socket.assigns.crm_bravo,
        crm_bravo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"crm_bravo" => crm_bravo_params}, socket) do
    save_crm_bravo(socket, socket.assigns.live_action, crm_bravo_params)
  end

  defp save_crm_bravo(socket, :edit, crm_bravo_params) do
    case Crm.update_crm_bravo(
           socket.assigns.current_scope,
           socket.assigns.crm_bravo,
           crm_bravo_params
         ) do
      {:ok, crm_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crm bravo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, crm_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_crm_bravo(socket, :new, crm_bravo_params) do
    case Crm.create_crm_bravo(socket.assigns.current_scope, crm_bravo_params) do
      {:ok, crm_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crm bravo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, crm_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _crm_bravo), do: ~p"/crm_bravos"
  defp return_path(_scope, "show", crm_bravo), do: ~p"/crm_bravos/#{crm_bravo}"
end
