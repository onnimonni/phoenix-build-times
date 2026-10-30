defmodule ShopWeb.BillingEchoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Billing
  alias Shop.Billing.BillingEcho

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage billing_echo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="billing_echo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Billing echo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @billing_echo)}>Cancel</.button>
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
    billing_echo = Billing.get_billing_echo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Billing echo")
    |> assign(:billing_echo, billing_echo)
    |> assign(
      :form,
      to_form(Billing.change_billing_echo(socket.assigns.current_scope, billing_echo))
    )
  end

  defp apply_action(socket, :new, _params) do
    billing_echo = %BillingEcho{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Billing echo")
    |> assign(:billing_echo, billing_echo)
    |> assign(
      :form,
      to_form(Billing.change_billing_echo(socket.assigns.current_scope, billing_echo))
    )
  end

  @impl true
  def handle_event("validate", %{"billing_echo" => billing_echo_params}, socket) do
    changeset =
      Billing.change_billing_echo(
        socket.assigns.current_scope,
        socket.assigns.billing_echo,
        billing_echo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"billing_echo" => billing_echo_params}, socket) do
    save_billing_echo(socket, socket.assigns.live_action, billing_echo_params)
  end

  defp save_billing_echo(socket, :edit, billing_echo_params) do
    case Billing.update_billing_echo(
           socket.assigns.current_scope,
           socket.assigns.billing_echo,
           billing_echo_params
         ) do
      {:ok, billing_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing echo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_billing_echo(socket, :new, billing_echo_params) do
    case Billing.create_billing_echo(socket.assigns.current_scope, billing_echo_params) do
      {:ok, billing_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Billing echo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, billing_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _billing_echo), do: ~p"/billing_echos"
  defp return_path(_scope, "show", billing_echo), do: ~p"/billing_echos/#{billing_echo}"
end
