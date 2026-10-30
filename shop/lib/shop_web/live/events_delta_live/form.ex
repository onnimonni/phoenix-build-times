defmodule ShopWeb.EventsDeltaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Events
  alias Shop.Events.EventsDelta

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage events_delta records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="events_delta-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Events delta</.button>
          <.button navigate={return_path(@current_scope, @return_to, @events_delta)}>Cancel</.button>
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
    events_delta = Events.get_events_delta!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Events delta")
    |> assign(:events_delta, events_delta)
    |> assign(
      :form,
      to_form(Events.change_events_delta(socket.assigns.current_scope, events_delta))
    )
  end

  defp apply_action(socket, :new, _params) do
    events_delta = %EventsDelta{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Events delta")
    |> assign(:events_delta, events_delta)
    |> assign(
      :form,
      to_form(Events.change_events_delta(socket.assigns.current_scope, events_delta))
    )
  end

  @impl true
  def handle_event("validate", %{"events_delta" => events_delta_params}, socket) do
    changeset =
      Events.change_events_delta(
        socket.assigns.current_scope,
        socket.assigns.events_delta,
        events_delta_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"events_delta" => events_delta_params}, socket) do
    save_events_delta(socket, socket.assigns.live_action, events_delta_params)
  end

  defp save_events_delta(socket, :edit, events_delta_params) do
    case Events.update_events_delta(
           socket.assigns.current_scope,
           socket.assigns.events_delta,
           events_delta_params
         ) do
      {:ok, events_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Events delta updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, events_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_events_delta(socket, :new, events_delta_params) do
    case Events.create_events_delta(socket.assigns.current_scope, events_delta_params) do
      {:ok, events_delta} ->
        {:noreply,
         socket
         |> put_flash(:info, "Events delta created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, events_delta)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _events_delta), do: ~p"/events_deltas"
  defp return_path(_scope, "show", events_delta), do: ~p"/events_deltas/#{events_delta}"
end
