defmodule ShopWeb.CatalogAlphaLive.Form do
  use ShopWeb, :live_view

  alias Shop.Catalog
  alias Shop.Catalog.CatalogAlpha

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage catalog_alpha records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="catalog_alpha-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:due_on]} type="date" label="Due on" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Catalog alpha</.button>
          <.button navigate={return_path(@current_scope, @return_to, @catalog_alpha)}>Cancel</.button>
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
    catalog_alpha = Catalog.get_catalog_alpha!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Catalog alpha")
    |> assign(:catalog_alpha, catalog_alpha)
    |> assign(
      :form,
      to_form(Catalog.change_catalog_alpha(socket.assigns.current_scope, catalog_alpha))
    )
  end

  defp apply_action(socket, :new, _params) do
    catalog_alpha = %CatalogAlpha{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Catalog alpha")
    |> assign(:catalog_alpha, catalog_alpha)
    |> assign(
      :form,
      to_form(Catalog.change_catalog_alpha(socket.assigns.current_scope, catalog_alpha))
    )
  end

  @impl true
  def handle_event("validate", %{"catalog_alpha" => catalog_alpha_params}, socket) do
    changeset =
      Catalog.change_catalog_alpha(
        socket.assigns.current_scope,
        socket.assigns.catalog_alpha,
        catalog_alpha_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"catalog_alpha" => catalog_alpha_params}, socket) do
    save_catalog_alpha(socket, socket.assigns.live_action, catalog_alpha_params)
  end

  defp save_catalog_alpha(socket, :edit, catalog_alpha_params) do
    case Catalog.update_catalog_alpha(
           socket.assigns.current_scope,
           socket.assigns.catalog_alpha,
           catalog_alpha_params
         ) do
      {:ok, catalog_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Catalog alpha updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, catalog_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_catalog_alpha(socket, :new, catalog_alpha_params) do
    case Catalog.create_catalog_alpha(socket.assigns.current_scope, catalog_alpha_params) do
      {:ok, catalog_alpha} ->
        {:noreply,
         socket
         |> put_flash(:info, "Catalog alpha created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, catalog_alpha)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _catalog_alpha), do: ~p"/catalog_alphas"
  defp return_path(_scope, "show", catalog_alpha), do: ~p"/catalog_alphas/#{catalog_alpha}"
end
