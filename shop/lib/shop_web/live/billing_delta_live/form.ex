defmodule ShopWeb.BillingDeltaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Billing
  alias Shop.Billing.BillingDelta

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage billing_delta records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="billing_delta-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Billing delta</.button>
          <.button navigate={return_path(@current_scope, @return_to, @billing_delta)}>Cancel</.button>
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
    billing_delta = Billing.get_billing_delta!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Billing delta")
    |> assign(:billing_delta, billing_delta)
    |> assign(
      :form,
      to_form(Billing.change_billing_delta(socket.assigns.current_scope, billing_delta))
    )
  end

  defp apply_action(socket, :new, _params) do
    billing_delta = %BillingDelta{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Billing delta")
    |> assign(:billing_delta, billing_delta)
    |> assign(
      :form,
      to_form(Billing.change_billing_delta(socket.assigns.current_scope, billing_delta))
    )
  end

  @impl true
  def handle_event("validate", %{"billing_delta" => billing_delta_params}, socket) do
    changeset =
      Billing.change_billing_delta(
        socket.assigns.current_scope,
        socket.assigns.billing_delta,
        billing_delta_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"billing_delta" => billing_delta_params}, socket) do
    save_billing_delta(socket, socket.assigns.live_action, billing_delta_params)
  end

  defp save_billing_delta(socket, :edit, billing_delta_params) do
    case Billing.update_billing_delta(
           socket.assigns.current_scope,
           socket.assigns.billing_delta,
           billing_delta_params
         ) do
      {:ok, billing_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing delta updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_billing_delta(socket, :new, billing_delta_params) do
    case Billing.create_billing_delta(socket.assigns.current_scope, billing_delta_params) do
      {:ok, billing_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing delta created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _billing_delta), do: ~p"/billing_deltas"
  defp return_path(_scope, "show", billing_delta), do: ~p"/billing_deltas/#{billing_delta}"
end
