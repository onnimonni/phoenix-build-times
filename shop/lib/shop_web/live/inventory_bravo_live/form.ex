defmodule ShopWeb.InventoryBravoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Inventory
  alias Shop.Inventory.InventoryBravo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage inventory_bravo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="inventory_bravo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Inventory bravo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @inventory_bravo)}>Cancel</.button>
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
    inventory_bravo = Inventory.get_inventory_bravo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Inventory bravo")
    |> assign(:inventory_bravo, inventory_bravo)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_bravo(socket.assigns.current_scope, inventory_bravo))
    )
  end

  defp apply_action(socket, :new, _params) do
    inventory_bravo = %InventoryBravo{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Inventory bravo")
    |> assign(:inventory_bravo, inventory_bravo)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_bravo(socket.assigns.current_scope, inventory_bravo))
    )
  end

  @impl true
  def handle_event("validate", %{"inventory_bravo" => inventory_bravo_params}, socket) do
    changeset =
      Inventory.change_inventory_bravo(
        socket.assigns.current_scope,
        socket.assigns.inventory_bravo,
        inventory_bravo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"inventory_bravo" => inventory_bravo_params}, socket) do
    save_inventory_bravo(socket, socket.assigns.live_action, inventory_bravo_params)
  end

  defp save_inventory_bravo(socket, :edit, inventory_bravo_params) do
    case Inventory.update_inventory_bravo(
           socket.assigns.current_scope,
           socket.assigns.inventory_bravo,
           inventory_bravo_params
         ) do
      {:ok, inventory_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory bravo updated successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, inventory_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_inventory_bravo(socket, :new, inventory_bravo_params) do
    case Inventory.create_inventory_bravo(socket.assigns.current_scope, inventory_bravo_params) do
      {:ok, inventory_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory bravo created successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, inventory_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _inventory_bravo), do: ~p"/inventory_bravos"
  defp return_path(_scope, "show", inventory_bravo), do: ~p"/inventory_bravos/#{inventory_bravo}"
end
