defmodule ShopWeb.SalesBravoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Sales
  alias Shop.Sales.SalesBravo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage sales_bravo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="sales_bravo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Sales bravo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @sales_bravo)}>Cancel</.button>
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
    sales_bravo = Sales.get_sales_bravo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Sales bravo")
    |> assign(:sales_bravo, sales_bravo)
    |> assign(:form, to_form(Sales.change_sales_bravo(socket.assigns.current_scope, sales_bravo)))
  end

  defp apply_action(socket, :new, _params) do
    sales_bravo = %SalesBravo{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Sales bravo")
    |> assign(:sales_bravo, sales_bravo)
    |> assign(:form, to_form(Sales.change_sales_bravo(socket.assigns.current_scope, sales_bravo)))
  end

  @impl true
  def handle_event("validate", %{"sales_bravo" => sales_bravo_params}, socket) do
    changeset =
      Sales.change_sales_bravo(
        socket.assigns.current_scope,
        socket.assigns.sales_bravo,
        sales_bravo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"sales_bravo" => sales_bravo_params}, socket) do
    save_sales_bravo(socket, socket.assigns.live_action, sales_bravo_params)
  end

  defp save_sales_bravo(socket, :edit, sales_bravo_params) do
    case Sales.update_sales_bravo(
           socket.assigns.current_scope,
           socket.assigns.sales_bravo,
           sales_bravo_params
         ) do
      {:ok, sales_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sales bravo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, sales_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_sales_bravo(socket, :new, sales_bravo_params) do
    case Sales.create_sales_bravo(socket.assigns.current_scope, sales_bravo_params) do
      {:ok, sales_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sales bravo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, sales_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _sales_bravo), do: ~p"/sales_bravos"
  defp return_path(_scope, "show", sales_bravo), do: ~p"/sales_bravos/#{sales_bravo}"
end
