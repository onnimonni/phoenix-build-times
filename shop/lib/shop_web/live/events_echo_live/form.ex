defmodule ShopWeb.EventsEchoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Events
  alias Shop.Events.EventsEcho

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage events_echo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="events_echo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Events echo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @events_echo)}>Cancel</.button>
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
    events_echo = Events.get_events_echo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Events echo")
    |> assign(:events_echo, events_echo)
    |> assign(
      :form,
      to_form(Events.change_events_echo(socket.assigns.current_scope, events_echo))
    )
  end

  defp apply_action(socket, :new, _params) do
    events_echo = %EventsEcho{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Events echo")
    |> assign(:events_echo, events_echo)
    |> assign(
      :form,
      to_form(Events.change_events_echo(socket.assigns.current_scope, events_echo))
    )
  end

  @impl true
  def handle_event("validate", %{"events_echo" => events_echo_params}, socket) do
    changeset =
      Events.change_events_echo(
        socket.assigns.current_scope,
        socket.assigns.events_echo,
        events_echo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"events_echo" => events_echo_params}, socket) do
    save_events_echo(socket, socket.assigns.live_action, events_echo_params)
  end

  defp save_events_echo(socket, :edit, events_echo_params) do
    case Events.update_events_echo(
           socket.assigns.current_scope,
           socket.assigns.events_echo,
           events_echo_params
         ) do
      {:ok, events_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Events echo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, events_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_events_echo(socket, :new, events_echo_params) do
    case Events.create_events_echo(socket.assigns.current_scope, events_echo_params) do
      {:ok, events_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Events echo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, events_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _events_echo), do: ~p"/events_echos"
  defp return_path(_scope, "show", events_echo), do: ~p"/events_echos/#{events_echo}"
end
