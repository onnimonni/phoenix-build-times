defmodule ShopWeb.SalesDeltaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Sales
  alias Shop.Sales.SalesDelta

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage sales_delta records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="sales_delta-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Sales delta</.button>
          <.button navigate={return_path(@current_scope, @return_to, @sales_delta)}>Cancel</.button>
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
    sales_delta = Sales.get_sales_delta!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Sales delta")
    |> assign(:sales_delta, sales_delta)
    |> assign(:form, to_form(Sales.change_sales_delta(socket.assigns.current_scope, sales_delta)))
  end

  defp apply_action(socket, :new, _params) do
    sales_delta = %SalesDelta{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Sales delta")
    |> assign(:sales_delta, sales_delta)
    |> assign(:form, to_form(Sales.change_sales_delta(socket.assigns.current_scope, sales_delta)))
  end

  @impl true
  def handle_event("validate", %{"sales_delta" => sales_delta_params}, socket) do
    changeset =
      Sales.change_sales_delta(
        socket.assigns.current_scope,
        socket.assigns.sales_delta,
        sales_delta_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"sales_delta" => sales_delta_params}, socket) do
    save_sales_delta(socket, socket.assigns.live_action, sales_delta_params)
  end

  defp save_sales_delta(socket, :edit, sales_delta_params) do
    case Sales.update_sales_delta(
           socket.assigns.current_scope,
           socket.assigns.sales_delta,
           sales_delta_params
         ) do
      {:ok, sales_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sales delta updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, sales_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_sales_delta(socket, :new, sales_delta_params) do
    case Sales.create_sales_delta(socket.assigns.current_scope, sales_delta_params) do
      {:ok, sales_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sales delta created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, sales_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _sales_delta), do: ~p"/sales_deltas"
  defp return_path(_scope, "show", sales_delta), do: ~p"/sales_deltas/#{sales_delta}"
end
