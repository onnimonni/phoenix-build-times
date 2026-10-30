defmodule ShopWeb.SalesAlphaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Sales
  alias Shop.Sales.SalesAlpha

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage sales_alpha records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="sales_alpha-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Sales alpha</.button>
          <.button navigate={return_path(@current_scope, @return_to, @sales_alpha)}>Cancel</.button>
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
    sales_alpha = Sales.get_sales_alpha!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Sales alpha")
    |> assign(:sales_alpha, sales_alpha)
    |> assign(:form, to_form(Sales.change_sales_alpha(socket.assigns.current_scope, sales_alpha)))
  end

  defp apply_action(socket, :new, _params) do
    sales_alpha = %SalesAlpha{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Sales alpha")
    |> assign(:sales_alpha, sales_alpha)
    |> assign(:form, to_form(Sales.change_sales_alpha(socket.assigns.current_scope, sales_alpha)))
  end

  @impl true
  def handle_event("validate", %{"sales_alpha" => sales_alpha_params}, socket) do
    changeset =
      Sales.change_sales_alpha(
        socket.assigns.current_scope,
        socket.assigns.sales_alpha,
        sales_alpha_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"sales_alpha" => sales_alpha_params}, socket) do
    save_sales_alpha(socket, socket.assigns.live_action, sales_alpha_params)
  end

  defp save_sales_alpha(socket, :edit, sales_alpha_params) do
    case Sales.update_sales_alpha(
           socket.assigns.current_scope,
           socket.assigns.sales_alpha,
           sales_alpha_params
         ) do
      {:ok, sales_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sales alpha updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, sales_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_sales_alpha(socket, :new, sales_alpha_params) do
    case Sales.create_sales_alpha(socket.assigns.current_scope, sales_alpha_params) do
      {:ok, sales_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sales alpha created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, sales_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _sales_alpha), do: ~p"/sales_alphas"
  defp return_path(_scope, "show", sales_alpha), do: ~p"/sales_alphas/#{sales_alpha}"
end
