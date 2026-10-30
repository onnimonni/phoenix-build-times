defmodule ShopWeb.InventoryEchoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Inventory
  alias Shop.Inventory.InventoryEcho

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage inventory_echo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="inventory_echo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Inventory echo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @inventory_echo)}>Cancel</.button>
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
    inventory_echo = Inventory.get_inventory_echo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Inventory echo")
    |> assign(:inventory_echo, inventory_echo)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_echo(socket.assigns.current_scope, inventory_echo))
    )
  end

  defp apply_action(socket, :new, _params) do
    inventory_echo = %InventoryEcho{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Inventory echo")
    |> assign(:inventory_echo, inventory_echo)
    |> assign(
      :form,
      to_form(Inventory.change_inventory_echo(socket.assigns.current_scope, inventory_echo))
    )
  end

  @impl true
  def handle_event("validate", %{"inventory_echo" => inventory_echo_params}, socket) do
    changeset =
      Inventory.change_inventory_echo(
        socket.assigns.current_scope,
        socket.assigns.inventory_echo,
        inventory_echo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"inventory_echo" => inventory_echo_params}, socket) do
    save_inventory_echo(socket, socket.assigns.live_action, inventory_echo_params)
  end

  defp save_inventory_echo(socket, :edit, inventory_echo_params) do
    case Inventory.update_inventory_echo(
           socket.assigns.current_scope,
           socket.assigns.inventory_echo,
           inventory_echo_params
         ) do
      {:ok, inventory_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory echo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, inventory_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_inventory_echo(socket, :new, inventory_echo_params) do
    case Inventory.create_inventory_echo(socket.assigns.current_scope, inventory_echo_params) do
      {:ok, inventory_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Inventory echo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, inventory_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _inventory_echo), do: ~p"/inventory_echos"
  defp return_path(_scope, "show", inventory_echo), do: ~p"/inventory_echos/#{inventory_echo}"
end
