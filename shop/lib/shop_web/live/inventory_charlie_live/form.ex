defmodule ShopWeb.InventoryCharlieLive.Form do
  use ShopWeb, :live_view

  alias Shop.Inventory
  alias Shop.Inventory.InventoryCharlie

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage inventory_charlie records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="inventory_charlie-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Inventory charlie</.button>
          <.button navigate={return_path(@current_scope, @return_to, @inventory_charlie)}>Cancel</.button>
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
    inventory_charlie = Inventory.get_inventory_charlie!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Inventory charlie")
    |> assign(:inventory_charlie, inventory_charlie)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_charlie(socket.assigns.current_scope, inventory_charlie))
    )
  end

  defp apply_action(socket, :new, _params) do
    inventory_charlie = %InventoryCharlie{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Inventory charlie")
    |> assign(:inventory_charlie, inventory_charlie)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_charlie(socket.assigns.current_scope, inventory_charlie))
    )
  end

  @impl true
  def handle_event("validate", %{"inventory_charlie" => inventory_charlie_params}, socket) do
    changeset =
      Inventory.change_inventory_charlie(
        socket.assigns.current_scope,
        socket.assigns.inventory_charlie,
        inventory_charlie_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"inventory_charlie" => inventory_charlie_params}, socket) do
    save_inventory_charlie(socket, socket.assigns.live_action, inventory_charlie_params)
  end

  defp save_inventory_charlie(socket, :edit, inventory_charlie_params) do
    case Inventory.update_inventory_charlie(
           socket.assigns.current_scope,
           socket.assigns.inventory_charlie,
           inventory_charlie_params
         ) do
      {:ok, inventory_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory charlie updated successfully")
         |> push_navigate(
           to:
             return_path(
               socket.assigns.current_scope,
               socket.assigns.return_to,
               inventory_charlie
             )
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_inventory_charlie(socket, :new, inventory_charlie_params) do
    case Inventory.create_inventory_charlie(
           socket.assigns.current_scope,
           inventory_charlie_params
         ) do
      {:ok, inventory_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory charlie created successfully")
         |> push_navigate(
           to:
             return_path(
               socket.assigns.current_scope,
               socket.assigns.return_to,
               inventory_charlie
             )
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _inventory_charlie), do: ~p"/inventory_charlies"

  defp return_path(_scope, "show", inventory_charlie),
    do: ~p"/inventory_charlies/#{inventory_charlie}"
end
