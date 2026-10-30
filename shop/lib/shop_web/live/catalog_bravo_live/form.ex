defmodule ShopWeb.CatalogBravoLive.Form do
  use ShopWeb, :live_view

  alias Shop.Catalog
  alias Shop.Catalog.CatalogBravo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage catalog_bravo records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="catalog_bravo-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Catalog bravo</.button>
          <.button navigate={return_path(@current_scope, @return_to, @catalog_bravo)}>Cancel</.button>
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
    catalog_bravo = Catalog.get_catalog_bravo!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Catalog bravo")
    |> assign(:catalog_bravo, catalog_bravo)
    |> assign(
      :form,
      to_form(Catalog.change_catalog_bravo(socket.assigns.current_scope, catalog_bravo))
    )
  end

  defp apply_action(socket, :new, _params) do
    catalog_bravo = %CatalogBravo{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Catalog bravo")
    |> assign(:catalog_bravo, catalog_bravo)
    |> assign(
      :form,
      to_form(Catalog.change_catalog_bravo(socket.assigns.current_scope, catalog_bravo))
    )
  end

  @impl true
  def handle_event("validate", %{"catalog_bravo" => catalog_bravo_params}, socket) do
    changeset =
      Catalog.change_catalog_bravo(
        socket.assigns.current_scope,
        socket.assigns.catalog_bravo,
        catalog_bravo_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"catalog_bravo" => catalog_bravo_params}, socket) do
    save_catalog_bravo(socket, socket.assigns.live_action, catalog_bravo_params)
  end

  defp save_catalog_bravo(socket, :edit, catalog_bravo_params) do
    case Catalog.update_catalog_bravo(
           socket.assigns.current_scope,
           socket.assigns.catalog_bravo,
           catalog_bravo_params
         ) do
      {:ok, catalog_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Catalog bravo updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, catalog_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_catalog_bravo(socket, :new, catalog_bravo_params) do
    case Catalog.create_catalog_bravo(socket.assigns.current_scope, catalog_bravo_params) do
      {:ok, catalog_bravo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Catalog bravo created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, catalog_bravo)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _catalog_bravo), do: ~p"/catalog_bravos"
  defp return_path(_scope, "show", catalog_bravo), do: ~p"/catalog_bravos/#{catalog_bravo}"
end
