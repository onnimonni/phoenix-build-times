defmodule ShopWeb.EventsBravoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Events
  alias Shop.Events.EventsBravo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage events_bravo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="events_bravo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Events bravo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @events_bravo)}>Cancel</.button>
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
    events_bravo = Events.get_events_bravo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Events bravo")
    |> assign(:events_bravo, events_bravo)
    |> assign(
      :form,
      to_form(Events.change_events_bravo(socket.assigns.current_scope, events_bravo))
    )
  end

  defp apply_action(socket, :new, _params) do
    events_bravo = %EventsBravo{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Events bravo")
    |> assign(:events_bravo, events_bravo)
    |> assign(
      :form,
      to_form(Events.change_events_bravo(socket.assigns.current_scope, events_bravo))
    )
  end

  @impl true
  def handle_event("validate", %{"events_bravo" => events_bravo_params}, socket) do
    changeset =
      Events.change_events_bravo(
        socket.assigns.current_scope,
        socket.assigns.events_bravo,
        events_bravo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"events_bravo" => events_bravo_params}, socket) do
    save_events_bravo(socket, socket.assigns.live_action, events_bravo_params)
  end

  defp save_events_bravo(socket, :edit, events_bravo_params) do
    case Events.update_events_bravo(
           socket.assigns.current_scope,
           socket.assigns.events_bravo,
           events_bravo_params
         ) do
      {:ok, events_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Events bravo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, events_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_events_bravo(socket, :new, events_bravo_params) do
    case Events.create_events_bravo(socket.assigns.current_scope, events_bravo_params) do
      {:ok, events_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Events bravo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, events_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _events_bravo), do: ~p"/events_bravos"
  defp return_path(_scope, "show", events_bravo), do: ~p"/events_bravos/#{events_bravo}"
end
