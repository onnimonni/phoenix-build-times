defmodule ShopWeb.BillingBravoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Billing
  alias Shop.Billing.BillingBravo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage billing_bravo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="billing_bravo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Billing bravo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @billing_bravo)}>Cancel</.button>
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
    billing_bravo = Billing.get_billing_bravo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Billing bravo")
    |> assign(:billing_bravo, billing_bravo)
    |> assign(
      :form,
      to_form(Billing.change_billing_bravo(socket.assigns.current_scope, billing_bravo))
    )
  end

  defp apply_action(socket, :new, _params) do
    billing_bravo = %BillingBravo{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Billing bravo")
    |> assign(:billing_bravo, billing_bravo)
    |> assign(
      :form,
      to_form(Billing.change_billing_bravo(socket.assigns.current_scope, billing_bravo))
    )
  end

  @impl true
  def handle_event("validate", %{"billing_bravo" => billing_bravo_params}, socket) do
    changeset =
      Billing.change_billing_bravo(
        socket.assigns.current_scope,
        socket.assigns.billing_bravo,
        billing_bravo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"billing_bravo" => billing_bravo_params}, socket) do
    save_billing_bravo(socket, socket.assigns.live_action, billing_bravo_params)
  end

  defp save_billing_bravo(socket, :edit, billing_bravo_params) do
    case Billing.update_billing_bravo(
           socket.assigns.current_scope,
           socket.assigns.billing_bravo,
           billing_bravo_params
         ) do
      {:ok, billing_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing bravo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_billing_bravo(socket, :new, billing_bravo_params) do
    case Billing.create_billing_bravo(socket.assigns.current_scope, billing_bravo_params) do
      {:ok, billing_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing bravo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _billing_bravo), do: ~p"/billing_bravos"
  defp return_path(_scope, "show", billing_bravo), do: ~p"/billing_bravos/#{billing_bravo}"
end
