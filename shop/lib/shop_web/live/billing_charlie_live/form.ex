defmodule ShopWeb.BillingCharlieLive.Form do
  use ShopWeb, :live_view

  alias Shop.Billing
  alias Shop.Billing.BillingCharlie

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage billing_charlie records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="billing_charlie-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Billing charlie</.button>
          <.button navigate={return_path(@current_scope, @return_to, @billing_charlie)}>Cancel</.button>
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
    billing_charlie = Billing.get_billing_charlie!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Billing charlie")
    |> assign(:billing_charlie, billing_charlie)
    |> assign(
      :form,
      to_form(Billing.change_billing_charlie(socket.assigns.current_scope, billing_charlie))
    )
  end

  defp apply_action(socket, :new, _params) do
    billing_charlie = %BillingCharlie{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Billing charlie")
    |> assign(:billing_charlie, billing_charlie)
    |> assign(
      :form,
      to_form(Billing.change_billing_charlie(socket.assigns.current_scope, billing_charlie))
    )
  end

  @impl true
  def handle_event("validate", %{"billing_charlie" => billing_charlie_params}, socket) do
    changeset =
      Billing.change_billing_charlie(
        socket.assigns.current_scope,
        socket.assigns.billing_charlie,
        billing_charlie_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"billing_charlie" => billing_charlie_params}, socket) do
    save_billing_charlie(socket, socket.assigns.live_action, billing_charlie_params)
  end

  defp save_billing_charlie(socket, :edit, billing_charlie_params) do
    case Billing.update_billing_charlie(
           socket.assigns.current_scope,
           socket.assigns.billing_charlie,
           billing_charlie_params
         ) do
      {:ok, billing_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing charlie updated successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_charlie)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_billing_charlie(socket, :new, billing_charlie_params) do
    case Billing.create_billing_charlie(socket.assigns.current_scope, billing_charlie_params) do
      {:ok, billing_charlie} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing charlie created successfully")
         |> push_navigate(
           to:
             return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_charlie)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _billing_charlie), do: ~p"/billing_charlies"
  defp return_path(_scope, "show", billing_charlie), do: ~p"/billing_charlies/#{billing_charlie}"
end
