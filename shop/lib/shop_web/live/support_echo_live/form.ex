defmodule ShopWeb.SupportEchoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Support
  alias Shop.Support.SupportEcho

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage support_echo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="support_echo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Support echo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @support_echo)}>Cancel</.button>
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
    support_echo = Support.get_support_echo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Support echo")
    |> assign(:support_echo, support_echo)
    |> assign(
      :form,
      to_form(Support.change_support_echo(socket.assigns.current_scope, support_echo))
    )
  end

  defp apply_action(socket, :new, _params) do
    support_echo = %SupportEcho{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Support echo")
    |> assign(:support_echo, support_echo)
    |> assign(
      :form,
      to_form(Support.change_support_echo(socket.assigns.current_scope, support_echo))
    )
  end

  @impl true
  def handle_event("validate", %{"support_echo" => support_echo_params}, socket) do
    changeset =
      Support.change_support_echo(
        socket.assigns.current_scope,
        socket.assigns.support_echo,
        support_echo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"support_echo" => support_echo_params}, socket) do
    save_support_echo(socket, socket.assigns.live_action, support_echo_params)
  end

  defp save_support_echo(socket, :edit, support_echo_params) do
    case Support.update_support_echo(
           socket.assigns.current_scope,
           socket.assigns.support_echo,
           support_echo_params
         ) do
      {:ok, support_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Support echo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, support_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_support_echo(socket, :new, support_echo_params) do
    case Support.create_support_echo(socket.assigns.current_scope, support_echo_params) do
      {:ok, support_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Support echo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, support_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _support_echo), do: ~p"/support_echos"
  defp return_path(_scope, "show", support_echo), do: ~p"/support_echos/#{support_echo}"
end
