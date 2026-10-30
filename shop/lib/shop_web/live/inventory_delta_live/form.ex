defmodule ShopWeb.InventoryDeltaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Inventory
  alias Shop.Inventory.InventoryDelta

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage inventory_delta records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="inventory_delta-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Inventory delta</.button>
          <.button navigate={return_path(@current_scope, @return_to, @inventory_delta)}>Cancel</.button>
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
    inventory_delta = Inventory.get_inventory_delta!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Inventory delta")
    |> assign(:inventory_delta, inventory_delta)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_delta(socket.assigns.current_scope, inventory_delta))
    )
  end

  defp apply_action(socket, :new, _params) do
    inventory_delta = %InventoryDelta{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Inventory delta")
    |> assign(:inventory_delta, inventory_delta)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_delta(socket.assigns.current_scope, inventory_delta))
    )
  end

  @impl true
  def handle_event("validate", %{"inventory_delta" => inventory_delta_params}, socket) do
    changeset =
      Inventory.change_inventory_delta(
        socket.assigns.current_scope,
        socket.assigns.inventory_delta,
        inventory_delta_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"inventory_delta" => inventory_delta_params}, socket) do
    save_inventory_delta(socket, socket.assigns.live_action, inventory_delta_params)
  end

  defp save_inventory_delta(socket, :edit, inventory_delta_params) do
    case Inventory.update_inventory_delta(
           socket.assigns.current_scope,
           socket.assigns.inventory_delta,
           inventory_delta_params
         ) do
      {:ok, inventory_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory delta updated successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, inventory_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_inventory_delta(socket, :new, inventory_delta_params) do
    case Inventory.create_inventory_delta(socket.assigns.current_scope, inventory_delta_params) do
      {:ok, inventory_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory delta created successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, inventory_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _inventory_delta), do: ~p"/inventory_deltas"
  defp return_path(_scope, "show", inventory_delta), do: ~p"/inventory_deltas/#{inventory_delta}"
end
