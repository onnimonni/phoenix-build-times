defmodule ShopWeb.ContentEchoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Content
  alias Shop.Content.ContentEcho

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage content_echo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="content_echo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Content echo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @content_echo)}>Cancel</.button>
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
    content_echo = Content.get_content_echo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Content echo")
    |> assign(:content_echo, content_echo)
    |> assign(
      :form,
      to_form(Content.change_content_echo(socket.assigns.current_scope, content_echo))
    )
  end

  defp apply_action(socket, :new, _params) do
    content_echo = %ContentEcho{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Content echo")
    |> assign(:content_echo, content_echo)
    |> assign(
      :form,
      to_form(Content.change_content_echo(socket.assigns.current_scope, content_echo))
    )
  end

  @impl true
  def handle_event("validate", %{"content_echo" => content_echo_params}, socket) do
    changeset =
      Content.change_content_echo(
        socket.assigns.current_scope,
        socket.assigns.content_echo,
        content_echo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"content_echo" => content_echo_params}, socket) do
    save_content_echo(socket, socket.assigns.live_action, content_echo_params)
  end

  defp save_content_echo(socket, :edit, content_echo_params) do
    case Content.update_content_echo(
           socket.assigns.current_scope,
           socket.assigns.content_echo,
           content_echo_params
         ) do
      {:ok, content_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content echo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, content_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_content_echo(socket, :new, content_echo_params) do
    case Content.create_content_echo(socket.assigns.current_scope, content_echo_params) do
      {:ok, content_echo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content echo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, content_echo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _content_echo), do: ~p"/content_echos"
  defp return_path(_scope, "show", content_echo), do: ~p"/content_echos/#{content_echo}"
end
