defmodule Shop.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Inventory.InventoryAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any inventory_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %InventoryAlpha{}}
    * {:updated, %InventoryAlpha{}}
    * {:deleted, %InventoryAlpha{}}

  """
  def subscribe_inventory_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:inventory_alphas")
  end

  defp broadcast_inventory_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:inventory_alphas", message)
  end

  @doc """
  Returns the list of inventory_alphas.

  ## Examples

      iex> list_inventory_alphas(scope)
      [%InventoryAlpha{}, ...]

  """
  def list_inventory_alphas(%Scope{} = scope) do
    Repo.all_by(InventoryAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single inventory_alpha.

  Raises `Ecto.NoResultsError` if the Inventory alpha does not exist.

  ## Examples

      iex> get_inventory_alpha!(scope, 123)
      %InventoryAlpha{}

      iex> get_inventory_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(InventoryAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a inventory_alpha.

  ## Examples

      iex> create_inventory_alpha(scope, %{field: value})
      {:ok, %InventoryAlpha{}}

      iex> create_inventory_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory_alpha(%Scope{} = scope, attrs) do
    with {:ok, inventory_alpha = %InventoryAlpha{}} <-
           %InventoryAlpha{}
           |> InventoryAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_inventory_alpha(scope, {:created, inventory_alpha})
      {:ok, inventory_alpha}
    end
  end

  @doc """
  Updates a inventory_alpha.

  ## Examples

      iex> update_inventory_alpha(scope, inventory_alpha, %{field: new_value})
      {:ok, %InventoryAlpha{}}

      iex> update_inventory_alpha(scope, inventory_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory_alpha(%Scope{} = scope, %InventoryAlpha{} = inventory_alpha, attrs) do
    true = inventory_alpha.user_id == scope.user.id

    with {:ok, inventory_alpha = %InventoryAlpha{}} <-
           inventory_alpha
           |> InventoryAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_inventory_alpha(scope, {:updated, inventory_alpha})
      {:ok, inventory_alpha}
    end
  end

  @doc """
  Deletes a inventory_alpha.

  ## Examples

      iex> delete_inventory_alpha(scope, inventory_alpha)
      {:ok, %InventoryAlpha{}}

      iex> delete_inventory_alpha(scope, inventory_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory_alpha(%Scope{} = scope, %InventoryAlpha{} = inventory_alpha) do
    true = inventory_alpha.user_id == scope.user.id

    with {:ok, inventory_alpha = %InventoryAlpha{}} <-
           Repo.delete(inventory_alpha) do
      broadcast_inventory_alpha(scope, {:deleted, inventory_alpha})
      {:ok, inventory_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory_alpha changes.

  ## Examples

      iex> change_inventory_alpha(scope, inventory_alpha)
      %Ecto.Changeset{data: %InventoryAlpha{}}

  """
  def change_inventory_alpha(%Scope{} = scope, %InventoryAlpha{} = inventory_alpha, attrs \\ %{}) do
    true = inventory_alpha.user_id == scope.user.id

    InventoryAlpha.changeset(inventory_alpha, attrs, scope)
  end

  alias Shop.Inventory.InventoryBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any inventory_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %InventoryBravo{}}
    * {:updated, %InventoryBravo{}}
    * {:deleted, %InventoryBravo{}}

  """
  def subscribe_inventory_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:inventory_bravos")
  end

  defp broadcast_inventory_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:inventory_bravos", message)
  end

  @doc """
  Returns the list of inventory_bravos.

  ## Examples

      iex> list_inventory_bravos(scope)
      [%InventoryBravo{}, ...]

  """
  def list_inventory_bravos(%Scope{} = scope) do
    Repo.all_by(InventoryBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single inventory_bravo.

  Raises `Ecto.NoResultsError` if the Inventory bravo does not exist.

  ## Examples

      iex> get_inventory_bravo!(scope, 123)
      %InventoryBravo{}

      iex> get_inventory_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(InventoryBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a inventory_bravo.

  ## Examples

      iex> create_inventory_bravo(scope, %{field: value})
      {:ok, %InventoryBravo{}}

      iex> create_inventory_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory_bravo(%Scope{} = scope, attrs) do
    with {:ok, inventory_bravo = %InventoryBravo{}} <-
           %InventoryBravo{}
           |> InventoryBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_inventory_bravo(scope, {:created, inventory_bravo})
      {:ok, inventory_bravo}
    end
  end

  @doc """
  Updates a inventory_bravo.

  ## Examples

      iex> update_inventory_bravo(scope, inventory_bravo, %{field: new_value})
      {:ok, %InventoryBravo{}}

      iex> update_inventory_bravo(scope, inventory_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory_bravo(%Scope{} = scope, %InventoryBravo{} = inventory_bravo, attrs) do
    true = inventory_bravo.user_id == scope.user.id

    with {:ok, inventory_bravo = %InventoryBravo{}} <-
           inventory_bravo
           |> InventoryBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_inventory_bravo(scope, {:updated, inventory_bravo})
      {:ok, inventory_bravo}
    end
  end

  @doc """
  Deletes a inventory_bravo.

  ## Examples

      iex> delete_inventory_bravo(scope, inventory_bravo)
      {:ok, %InventoryBravo{}}

      iex> delete_inventory_bravo(scope, inventory_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory_bravo(%Scope{} = scope, %InventoryBravo{} = inventory_bravo) do
    true = inventory_bravo.user_id == scope.user.id

    with {:ok, inventory_bravo = %InventoryBravo{}} <-
           Repo.delete(inventory_bravo) do
      broadcast_inventory_bravo(scope, {:deleted, inventory_bravo})
      {:ok, inventory_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory_bravo changes.

  ## Examples

      iex> change_inventory_bravo(scope, inventory_bravo)
      %Ecto.Changeset{data: %InventoryBravo{}}

  """
  def change_inventory_bravo(%Scope{} = scope, %InventoryBravo{} = inventory_bravo, attrs \\ %{}) do
    true = inventory_bravo.user_id == scope.user.id

    InventoryBravo.changeset(inventory_bravo, attrs, scope)
  end

  alias Shop.Inventory.InventoryCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any inventory_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %InventoryCharlie{}}
    * {:updated, %InventoryCharlie{}}
    * {:deleted, %InventoryCharlie{}}

  """
  def subscribe_inventory_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:inventory_charlies")
  end

  defp broadcast_inventory_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:inventory_charlies", message)
  end

  @doc """
  Returns the list of inventory_charlies.

  ## Examples

      iex> list_inventory_charlies(scope)
      [%InventoryCharlie{}, ...]

  """
  def list_inventory_charlies(%Scope{} = scope) do
    Repo.all_by(InventoryCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single inventory_charlie.

  Raises `Ecto.NoResultsError` if the Inventory charlie does not exist.

  ## Examples

      iex> get_inventory_charlie!(scope, 123)
      %InventoryCharlie{}

      iex> get_inventory_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(InventoryCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a inventory_charlie.

  ## Examples

      iex> create_inventory_charlie(scope, %{field: value})
      {:ok, %InventoryCharlie{}}

      iex> create_inventory_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory_charlie(%Scope{} = scope, attrs) do
    with {:ok, inventory_charlie = %InventoryCharlie{}} <-
           %InventoryCharlie{}
           |> InventoryCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_inventory_charlie(scope, {:created, inventory_charlie})
      {:ok, inventory_charlie}
    end
  end

  @doc """
  Updates a inventory_charlie.

  ## Examples

      iex> update_inventory_charlie(scope, inventory_charlie, %{field: new_value})
      {:ok, %InventoryCharlie{}}

      iex> update_inventory_charlie(scope, inventory_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory_charlie(%Scope{} = scope, %InventoryCharlie{} = inventory_charlie, attrs) do
    true = inventory_charlie.user_id == scope.user.id

    with {:ok, inventory_charlie = %InventoryCharlie{}} <-
           inventory_charlie
           |> InventoryCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_inventory_charlie(scope, {:updated, inventory_charlie})
      {:ok, inventory_charlie}
    end
  end

  @doc """
  Deletes a inventory_charlie.

  ## Examples

      iex> delete_inventory_charlie(scope, inventory_charlie)
      {:ok, %InventoryCharlie{}}

      iex> delete_inventory_charlie(scope, inventory_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory_charlie(%Scope{} = scope, %InventoryCharlie{} = inventory_charlie) do
    true = inventory_charlie.user_id == scope.user.id

    with {:ok, inventory_charlie = %InventoryCharlie{}} <-
           Repo.delete(inventory_charlie) do
      broadcast_inventory_charlie(scope, {:deleted, inventory_charlie})
      {:ok, inventory_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory_charlie changes.

  ## Examples

      iex> change_inventory_charlie(scope, inventory_charlie)
      %Ecto.Changeset{data: %InventoryCharlie{}}

  """
  def change_inventory_charlie(
        %Scope{} = scope,
        %InventoryCharlie{} = inventory_charlie,
        attrs \\ %{}
      ) do
    true = inventory_charlie.user_id == scope.user.id

    InventoryCharlie.changeset(inventory_charlie, attrs, scope)
  end

  alias Shop.Inventory.InventoryDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any inventory_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %InventoryDelta{}}
    * {:updated, %InventoryDelta{}}
    * {:deleted, %InventoryDelta{}}

  """
  def subscribe_inventory_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:inventory_deltas")
  end

  defp broadcast_inventory_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:inventory_deltas", message)
  end

  @doc """
  Returns the list of inventory_deltas.

  ## Examples

      iex> list_inventory_deltas(scope)
      [%InventoryDelta{}, ...]

  """
  def list_inventory_deltas(%Scope{} = scope) do
    Repo.all_by(InventoryDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single inventory_delta.

  Raises `Ecto.NoResultsError` if the Inventory delta does not exist.

  ## Examples

      iex> get_inventory_delta!(scope, 123)
      %InventoryDelta{}

      iex> get_inventory_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory_delta!(%Scope{} = scope, id) do
    Repo.get_by!(InventoryDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a inventory_delta.

  ## Examples

      iex> create_inventory_delta(scope, %{field: value})
      {:ok, %InventoryDelta{}}

      iex> create_inventory_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory_delta(%Scope{} = scope, attrs) do
    with {:ok, inventory_delta = %InventoryDelta{}} <-
           %InventoryDelta{}
           |> InventoryDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_inventory_delta(scope, {:created, inventory_delta})
      {:ok, inventory_delta}
    end
  end

  @doc """
  Updates a inventory_delta.

  ## Examples

      iex> update_inventory_delta(scope, inventory_delta, %{field: new_value})
      {:ok, %InventoryDelta{}}

      iex> update_inventory_delta(scope, inventory_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory_delta(%Scope{} = scope, %InventoryDelta{} = inventory_delta, attrs) do
    true = inventory_delta.user_id == scope.user.id

    with {:ok, inventory_delta = %InventoryDelta{}} <-
           inventory_delta
           |> InventoryDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_inventory_delta(scope, {:updated, inventory_delta})
      {:ok, inventory_delta}
    end
  end

  @doc """
  Deletes a inventory_delta.

  ## Examples

      iex> delete_inventory_delta(scope, inventory_delta)
      {:ok, %InventoryDelta{}}

      iex> delete_inventory_delta(scope, inventory_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory_delta(%Scope{} = scope, %InventoryDelta{} = inventory_delta) do
    true = inventory_delta.user_id == scope.user.id

    with {:ok, inventory_delta = %InventoryDelta{}} <-
           Repo.delete(inventory_delta) do
      broadcast_inventory_delta(scope, {:deleted, inventory_delta})
      {:ok, inventory_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory_delta changes.

  ## Examples

      iex> change_inventory_delta(scope, inventory_delta)
      %Ecto.Changeset{data: %InventoryDelta{}}

  """
  def change_inventory_delta(%Scope{} = scope, %InventoryDelta{} = inventory_delta, attrs \\ %{}) do
    true = inventory_delta.user_id == scope.user.id

    InventoryDelta.changeset(inventory_delta, attrs, scope)
  end

  alias Shop.Inventory.InventoryEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any inventory_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %InventoryEcho{}}
    * {:updated, %InventoryEcho{}}
    * {:deleted, %InventoryEcho{}}

  """
  def subscribe_inventory_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:inventory_echos")
  end

  defp broadcast_inventory_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:inventory_echos", message)
  end

  @doc """
  Returns the list of inventory_echos.

  ## Examples

      iex> list_inventory_echos(scope)
      [%InventoryEcho{}, ...]

  """
  def list_inventory_echos(%Scope{} = scope) do
    Repo.all_by(InventoryEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single inventory_echo.

  Raises `Ecto.NoResultsError` if the Inventory echo does not exist.

  ## Examples

      iex> get_inventory_echo!(scope, 123)
      %InventoryEcho{}

      iex> get_inventory_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory_echo!(%Scope{} = scope, id) do
    Repo.get_by!(InventoryEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a inventory_echo.

  ## Examples

      iex> create_inventory_echo(scope, %{field: value})
      {:ok, %InventoryEcho{}}

      iex> create_inventory_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory_echo(%Scope{} = scope, attrs) do
    with {:ok, inventory_echo = %InventoryEcho{}} <-
           %InventoryEcho{}
           |> InventoryEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_inventory_echo(scope, {:created, inventory_echo})
      {:ok, inventory_echo}
    end
  end

  @doc """
  Updates a inventory_echo.

  ## Examples

      iex> update_inventory_echo(scope, inventory_echo, %{field: new_value})
      {:ok, %InventoryEcho{}}

      iex> update_inventory_echo(scope, inventory_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory_echo(%Scope{} = scope, %InventoryEcho{} = inventory_echo, attrs) do
    true = inventory_echo.user_id == scope.user.id

    with {:ok, inventory_echo = %InventoryEcho{}} <-
           inventory_echo
           |> InventoryEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_inventory_echo(scope, {:updated, inventory_echo})
      {:ok, inventory_echo}
    end
  end

  @doc """
  Deletes a inventory_echo.

  ## Examples

      iex> delete_inventory_echo(scope, inventory_echo)
      {:ok, %InventoryEcho{}}

      iex> delete_inventory_echo(scope, inventory_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory_echo(%Scope{} = scope, %InventoryEcho{} = inventory_echo) do
    true = inventory_echo.user_id == scope.user.id

    with {:ok, inventory_echo = %InventoryEcho{}} <-
           Repo.delete(inventory_echo) do
      broadcast_inventory_echo(scope, {:deleted, inventory_echo})
      {:ok, inventory_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory_echo changes.

  ## Examples

      iex> change_inventory_echo(scope, inventory_echo)
      %Ecto.Changeset{data: %InventoryEcho{}}

  """
  def change_inventory_echo(%Scope{} = scope, %InventoryEcho{} = inventory_echo, attrs \\ %{}) do
    true = inventory_echo.user_id == scope.user.id

    InventoryEcho.changeset(inventory_echo, attrs, scope)
  end
end
