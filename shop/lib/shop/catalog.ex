defmodule Shop.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Catalog.CatalogAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any catalog_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %CatalogAlpha{}}
    * {:updated, %CatalogAlpha{}}
    * {:deleted, %CatalogAlpha{}}

  """
  def subscribe_catalog_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:catalog_alphas")
  end

  defp broadcast_catalog_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:catalog_alphas", message)
  end

  @doc """
  Returns the list of catalog_alphas.

  ## Examples

      iex> list_catalog_alphas(scope)
      [%CatalogAlpha{}, ...]

  """
  def list_catalog_alphas(%Scope{} = scope) do
    Repo.all_by(CatalogAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single catalog_alpha.

  Raises `Ecto.NoResultsError` if the Catalog alpha does not exist.

  ## Examples

      iex> get_catalog_alpha!(scope, 123)
      %CatalogAlpha{}

      iex> get_catalog_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_catalog_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(CatalogAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a catalog_alpha.

  ## Examples

      iex> create_catalog_alpha(scope, %{field: value})
      {:ok, %CatalogAlpha{}}

      iex> create_catalog_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_catalog_alpha(%Scope{} = scope, attrs) do
    with {:ok, catalog_alpha = %CatalogAlpha{}} <-
           %CatalogAlpha{}
           |> CatalogAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_catalog_alpha(scope, {:created, catalog_alpha})
      {:ok, catalog_alpha}
    end
  end

  @doc """
  Updates a catalog_alpha.

  ## Examples

      iex> update_catalog_alpha(scope, catalog_alpha, %{field: new_value})
      {:ok, %CatalogAlpha{}}

      iex> update_catalog_alpha(scope, catalog_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catalog_alpha(%Scope{} = scope, %CatalogAlpha{} = catalog_alpha, attrs) do
    true = catalog_alpha.user_id == scope.user.id

    with {:ok, catalog_alpha = %CatalogAlpha{}} <-
           catalog_alpha
           |> CatalogAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_catalog_alpha(scope, {:updated, catalog_alpha})
      {:ok, catalog_alpha}
    end
  end

  @doc """
  Deletes a catalog_alpha.

  ## Examples

      iex> delete_catalog_alpha(scope, catalog_alpha)
      {:ok, %CatalogAlpha{}}

      iex> delete_catalog_alpha(scope, catalog_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catalog_alpha(%Scope{} = scope, %CatalogAlpha{} = catalog_alpha) do
    true = catalog_alpha.user_id == scope.user.id

    with {:ok, catalog_alpha = %CatalogAlpha{}} <-
           Repo.delete(catalog_alpha) do
      broadcast_catalog_alpha(scope, {:deleted, catalog_alpha})
      {:ok, catalog_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catalog_alpha changes.

  ## Examples

      iex> change_catalog_alpha(scope, catalog_alpha)
      %Ecto.Changeset{data: %CatalogAlpha{}}

  """
  def change_catalog_alpha(%Scope{} = scope, %CatalogAlpha{} = catalog_alpha, attrs \\ %{}) do
    true = catalog_alpha.user_id == scope.user.id

    CatalogAlpha.changeset(catalog_alpha, attrs, scope)
  end

  alias Shop.Catalog.CatalogBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any catalog_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %CatalogBravo{}}
    * {:updated, %CatalogBravo{}}
    * {:deleted, %CatalogBravo{}}

  """
  def subscribe_catalog_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:catalog_bravos")
  end

  defp broadcast_catalog_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:catalog_bravos", message)
  end

  @doc """
  Returns the list of catalog_bravos.

  ## Examples

      iex> list_catalog_bravos(scope)
      [%CatalogBravo{}, ...]

  """
  def list_catalog_bravos(%Scope{} = scope) do
    Repo.all_by(CatalogBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single catalog_bravo.

  Raises `Ecto.NoResultsError` if the Catalog bravo does not exist.

  ## Examples

      iex> get_catalog_bravo!(scope, 123)
      %CatalogBravo{}

      iex> get_catalog_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_catalog_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(CatalogBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a catalog_bravo.

  ## Examples

      iex> create_catalog_bravo(scope, %{field: value})
      {:ok, %CatalogBravo{}}

      iex> create_catalog_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_catalog_bravo(%Scope{} = scope, attrs) do
    with {:ok, catalog_bravo = %CatalogBravo{}} <-
           %CatalogBravo{}
           |> CatalogBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_catalog_bravo(scope, {:created, catalog_bravo})
      {:ok, catalog_bravo}
    end
  end

  @doc """
  Updates a catalog_bravo.

  ## Examples

      iex> update_catalog_bravo(scope, catalog_bravo, %{field: new_value})
      {:ok, %CatalogBravo{}}

      iex> update_catalog_bravo(scope, catalog_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catalog_bravo(%Scope{} = scope, %CatalogBravo{} = catalog_bravo, attrs) do
    true = catalog_bravo.user_id == scope.user.id

    with {:ok, catalog_bravo = %CatalogBravo{}} <-
           catalog_bravo
           |> CatalogBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_catalog_bravo(scope, {:updated, catalog_bravo})
      {:ok, catalog_bravo}
    end
  end

  @doc """
  Deletes a catalog_bravo.

  ## Examples

      iex> delete_catalog_bravo(scope, catalog_bravo)
      {:ok, %CatalogBravo{}}

      iex> delete_catalog_bravo(scope, catalog_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catalog_bravo(%Scope{} = scope, %CatalogBravo{} = catalog_bravo) do
    true = catalog_bravo.user_id == scope.user.id

    with {:ok, catalog_bravo = %CatalogBravo{}} <-
           Repo.delete(catalog_bravo) do
      broadcast_catalog_bravo(scope, {:deleted, catalog_bravo})
      {:ok, catalog_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catalog_bravo changes.

  ## Examples

      iex> change_catalog_bravo(scope, catalog_bravo)
      %Ecto.Changeset{data: %CatalogBravo{}}

  """
  def change_catalog_bravo(%Scope{} = scope, %CatalogBravo{} = catalog_bravo, attrs \\ %{}) do
    true = catalog_bravo.user_id == scope.user.id

    CatalogBravo.changeset(catalog_bravo, attrs, scope)
  end

  alias Shop.Catalog.CatalogCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any catalog_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %CatalogCharlie{}}
    * {:updated, %CatalogCharlie{}}
    * {:deleted, %CatalogCharlie{}}

  """
  def subscribe_catalog_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:catalog_charlies")
  end

  defp broadcast_catalog_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:catalog_charlies", message)
  end

  @doc """
  Returns the list of catalog_charlies.

  ## Examples

      iex> list_catalog_charlies(scope)
      [%CatalogCharlie{}, ...]

  """
  def list_catalog_charlies(%Scope{} = scope) do
    Repo.all_by(CatalogCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single catalog_charlie.

  Raises `Ecto.NoResultsError` if the Catalog charlie does not exist.

  ## Examples

      iex> get_catalog_charlie!(scope, 123)
      %CatalogCharlie{}

      iex> get_catalog_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_catalog_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(CatalogCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a catalog_charlie.

  ## Examples

      iex> create_catalog_charlie(scope, %{field: value})
      {:ok, %CatalogCharlie{}}

      iex> create_catalog_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_catalog_charlie(%Scope{} = scope, attrs) do
    with {:ok, catalog_charlie = %CatalogCharlie{}} <-
           %CatalogCharlie{}
           |> CatalogCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_catalog_charlie(scope, {:created, catalog_charlie})
      {:ok, catalog_charlie}
    end
  end

  @doc """
  Updates a catalog_charlie.

  ## Examples

      iex> update_catalog_charlie(scope, catalog_charlie, %{field: new_value})
      {:ok, %CatalogCharlie{}}

      iex> update_catalog_charlie(scope, catalog_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catalog_charlie(%Scope{} = scope, %CatalogCharlie{} = catalog_charlie, attrs) do
    true = catalog_charlie.user_id == scope.user.id

    with {:ok, catalog_charlie = %CatalogCharlie{}} <-
           catalog_charlie
           |> CatalogCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_catalog_charlie(scope, {:updated, catalog_charlie})
      {:ok, catalog_charlie}
    end
  end

  @doc """
  Deletes a catalog_charlie.

  ## Examples

      iex> delete_catalog_charlie(scope, catalog_charlie)
      {:ok, %CatalogCharlie{}}

      iex> delete_catalog_charlie(scope, catalog_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catalog_charlie(%Scope{} = scope, %CatalogCharlie{} = catalog_charlie) do
    true = catalog_charlie.user_id == scope.user.id

    with {:ok, catalog_charlie = %CatalogCharlie{}} <-
           Repo.delete(catalog_charlie) do
      broadcast_catalog_charlie(scope, {:deleted, catalog_charlie})
      {:ok, catalog_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catalog_charlie changes.

  ## Examples

      iex> change_catalog_charlie(scope, catalog_charlie)
      %Ecto.Changeset{data: %CatalogCharlie{}}

  """
  def change_catalog_charlie(%Scope{} = scope, %CatalogCharlie{} = catalog_charlie, attrs \\ %{}) do
    true = catalog_charlie.user_id == scope.user.id

    CatalogCharlie.changeset(catalog_charlie, attrs, scope)
  end

  alias Shop.Catalog.CatalogDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any catalog_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %CatalogDelta{}}
    * {:updated, %CatalogDelta{}}
    * {:deleted, %CatalogDelta{}}

  """
  def subscribe_catalog_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:catalog_deltas")
  end

  defp broadcast_catalog_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:catalog_deltas", message)
  end

  @doc """
  Returns the list of catalog_deltas.

  ## Examples

      iex> list_catalog_deltas(scope)
      [%CatalogDelta{}, ...]

  """
  def list_catalog_deltas(%Scope{} = scope) do
    Repo.all_by(CatalogDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single catalog_delta.

  Raises `Ecto.NoResultsError` if the Catalog delta does not exist.

  ## Examples

      iex> get_catalog_delta!(scope, 123)
      %CatalogDelta{}

      iex> get_catalog_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_catalog_delta!(%Scope{} = scope, id) do
    Repo.get_by!(CatalogDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a catalog_delta.

  ## Examples

      iex> create_catalog_delta(scope, %{field: value})
      {:ok, %CatalogDelta{}}

      iex> create_catalog_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_catalog_delta(%Scope{} = scope, attrs) do
    with {:ok, catalog_delta = %CatalogDelta{}} <-
           %CatalogDelta{}
           |> CatalogDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_catalog_delta(scope, {:created, catalog_delta})
      {:ok, catalog_delta}
    end
  end

  @doc """
  Updates a catalog_delta.

  ## Examples

      iex> update_catalog_delta(scope, catalog_delta, %{field: new_value})
      {:ok, %CatalogDelta{}}

      iex> update_catalog_delta(scope, catalog_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catalog_delta(%Scope{} = scope, %CatalogDelta{} = catalog_delta, attrs) do
    true = catalog_delta.user_id == scope.user.id

    with {:ok, catalog_delta = %CatalogDelta{}} <-
           catalog_delta
           |> CatalogDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_catalog_delta(scope, {:updated, catalog_delta})
      {:ok, catalog_delta}
    end
  end

  @doc """
  Deletes a catalog_delta.

  ## Examples

      iex> delete_catalog_delta(scope, catalog_delta)
      {:ok, %CatalogDelta{}}

      iex> delete_catalog_delta(scope, catalog_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catalog_delta(%Scope{} = scope, %CatalogDelta{} = catalog_delta) do
    true = catalog_delta.user_id == scope.user.id

    with {:ok, catalog_delta = %CatalogDelta{}} <-
           Repo.delete(catalog_delta) do
      broadcast_catalog_delta(scope, {:deleted, catalog_delta})
      {:ok, catalog_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catalog_delta changes.

  ## Examples

      iex> change_catalog_delta(scope, catalog_delta)
      %Ecto.Changeset{data: %CatalogDelta{}}

  """
  def change_catalog_delta(%Scope{} = scope, %CatalogDelta{} = catalog_delta, attrs \\ %{}) do
    true = catalog_delta.user_id == scope.user.id

    CatalogDelta.changeset(catalog_delta, attrs, scope)
  end

  alias Shop.Catalog.CatalogEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any catalog_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %CatalogEcho{}}
    * {:updated, %CatalogEcho{}}
    * {:deleted, %CatalogEcho{}}

  """
  def subscribe_catalog_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:catalog_echos")
  end

  defp broadcast_catalog_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:catalog_echos", message)
  end

  @doc """
  Returns the list of catalog_echos.

  ## Examples

      iex> list_catalog_echos(scope)
      [%CatalogEcho{}, ...]

  """
  def list_catalog_echos(%Scope{} = scope) do
    Repo.all_by(CatalogEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single catalog_echo.

  Raises `Ecto.NoResultsError` if the Catalog echo does not exist.

  ## Examples

      iex> get_catalog_echo!(scope, 123)
      %CatalogEcho{}

      iex> get_catalog_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_catalog_echo!(%Scope{} = scope, id) do
    Repo.get_by!(CatalogEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a catalog_echo.

  ## Examples

      iex> create_catalog_echo(scope, %{field: value})
      {:ok, %CatalogEcho{}}

      iex> create_catalog_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_catalog_echo(%Scope{} = scope, attrs) do
    with {:ok, catalog_echo = %CatalogEcho{}} <-
           %CatalogEcho{}
           |> CatalogEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_catalog_echo(scope, {:created, catalog_echo})
      {:ok, catalog_echo}
    end
  end

  @doc """
  Updates a catalog_echo.

  ## Examples

      iex> update_catalog_echo(scope, catalog_echo, %{field: new_value})
      {:ok, %CatalogEcho{}}

      iex> update_catalog_echo(scope, catalog_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catalog_echo(%Scope{} = scope, %CatalogEcho{} = catalog_echo, attrs) do
    true = catalog_echo.user_id == scope.user.id

    with {:ok, catalog_echo = %CatalogEcho{}} <-
           catalog_echo
           |> CatalogEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_catalog_echo(scope, {:updated, catalog_echo})
      {:ok, catalog_echo}
    end
  end

  @doc """
  Deletes a catalog_echo.

  ## Examples

      iex> delete_catalog_echo(scope, catalog_echo)
      {:ok, %CatalogEcho{}}

      iex> delete_catalog_echo(scope, catalog_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catalog_echo(%Scope{} = scope, %CatalogEcho{} = catalog_echo) do
    true = catalog_echo.user_id == scope.user.id

    with {:ok, catalog_echo = %CatalogEcho{}} <-
           Repo.delete(catalog_echo) do
      broadcast_catalog_echo(scope, {:deleted, catalog_echo})
      {:ok, catalog_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catalog_echo changes.

  ## Examples

      iex> change_catalog_echo(scope, catalog_echo)
      %Ecto.Changeset{data: %CatalogEcho{}}

  """
  def change_catalog_echo(%Scope{} = scope, %CatalogEcho{} = catalog_echo, attrs \\ %{}) do
    true = catalog_echo.user_id == scope.user.id

    CatalogEcho.changeset(catalog_echo, attrs, scope)
  end
end
