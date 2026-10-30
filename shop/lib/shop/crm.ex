defmodule Shop.Crm do
  @moduledoc """
  The Crm context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Crm.CrmAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any crm_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %CrmAlpha{}}
    * {:updated, %CrmAlpha{}}
    * {:deleted, %CrmAlpha{}}

  """
  def subscribe_crm_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:crm_alphas")
  end

  defp broadcast_crm_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:crm_alphas", message)
  end

  @doc """
  Returns the list of crm_alphas.

  ## Examples

      iex> list_crm_alphas(scope)
      [%CrmAlpha{}, ...]

  """
  def list_crm_alphas(%Scope{} = scope) do
    Repo.all_by(CrmAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single crm_alpha.

  Raises `Ecto.NoResultsError` if the Crm alpha does not exist.

  ## Examples

      iex> get_crm_alpha!(scope, 123)
      %CrmAlpha{}

      iex> get_crm_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_crm_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(CrmAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a crm_alpha.

  ## Examples

      iex> create_crm_alpha(scope, %{field: value})
      {:ok, %CrmAlpha{}}

      iex> create_crm_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crm_alpha(%Scope{} = scope, attrs) do
    with {:ok, crm_alpha = %CrmAlpha{}} <-
           %CrmAlpha{}
           |> CrmAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_crm_alpha(scope, {:created, crm_alpha})
      {:ok, crm_alpha}
    end
  end

  @doc """
  Updates a crm_alpha.

  ## Examples

      iex> update_crm_alpha(scope, crm_alpha, %{field: new_value})
      {:ok, %CrmAlpha{}}

      iex> update_crm_alpha(scope, crm_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crm_alpha(%Scope{} = scope, %CrmAlpha{} = crm_alpha, attrs) do
    true = crm_alpha.user_id == scope.user.id

    with {:ok, crm_alpha = %CrmAlpha{}} <-
           crm_alpha
           |> CrmAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_crm_alpha(scope, {:updated, crm_alpha})
      {:ok, crm_alpha}
    end
  end

  @doc """
  Deletes a crm_alpha.

  ## Examples

      iex> delete_crm_alpha(scope, crm_alpha)
      {:ok, %CrmAlpha{}}

      iex> delete_crm_alpha(scope, crm_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crm_alpha(%Scope{} = scope, %CrmAlpha{} = crm_alpha) do
    true = crm_alpha.user_id == scope.user.id

    with {:ok, crm_alpha = %CrmAlpha{}} <-
           Repo.delete(crm_alpha) do
      broadcast_crm_alpha(scope, {:deleted, crm_alpha})
      {:ok, crm_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crm_alpha changes.

  ## Examples

      iex> change_crm_alpha(scope, crm_alpha)
      %Ecto.Changeset{data: %CrmAlpha{}}

  """
  def change_crm_alpha(%Scope{} = scope, %CrmAlpha{} = crm_alpha, attrs \\ %{}) do
    true = crm_alpha.user_id == scope.user.id

    CrmAlpha.changeset(crm_alpha, attrs, scope)
  end

  alias Shop.Crm.CrmBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any crm_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %CrmBravo{}}
    * {:updated, %CrmBravo{}}
    * {:deleted, %CrmBravo{}}

  """
  def subscribe_crm_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:crm_bravos")
  end

  defp broadcast_crm_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:crm_bravos", message)
  end

  @doc """
  Returns the list of crm_bravos.

  ## Examples

      iex> list_crm_bravos(scope)
      [%CrmBravo{}, ...]

  """
  def list_crm_bravos(%Scope{} = scope) do
    Repo.all_by(CrmBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single crm_bravo.

  Raises `Ecto.NoResultsError` if the Crm bravo does not exist.

  ## Examples

      iex> get_crm_bravo!(scope, 123)
      %CrmBravo{}

      iex> get_crm_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_crm_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(CrmBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a crm_bravo.

  ## Examples

      iex> create_crm_bravo(scope, %{field: value})
      {:ok, %CrmBravo{}}

      iex> create_crm_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crm_bravo(%Scope{} = scope, attrs) do
    with {:ok, crm_bravo = %CrmBravo{}} <-
           %CrmBravo{}
           |> CrmBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_crm_bravo(scope, {:created, crm_bravo})
      {:ok, crm_bravo}
    end
  end

  @doc """
  Updates a crm_bravo.

  ## Examples

      iex> update_crm_bravo(scope, crm_bravo, %{field: new_value})
      {:ok, %CrmBravo{}}

      iex> update_crm_bravo(scope, crm_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crm_bravo(%Scope{} = scope, %CrmBravo{} = crm_bravo, attrs) do
    true = crm_bravo.user_id == scope.user.id

    with {:ok, crm_bravo = %CrmBravo{}} <-
           crm_bravo
           |> CrmBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_crm_bravo(scope, {:updated, crm_bravo})
      {:ok, crm_bravo}
    end
  end

  @doc """
  Deletes a crm_bravo.

  ## Examples

      iex> delete_crm_bravo(scope, crm_bravo)
      {:ok, %CrmBravo{}}

      iex> delete_crm_bravo(scope, crm_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crm_bravo(%Scope{} = scope, %CrmBravo{} = crm_bravo) do
    true = crm_bravo.user_id == scope.user.id

    with {:ok, crm_bravo = %CrmBravo{}} <-
           Repo.delete(crm_bravo) do
      broadcast_crm_bravo(scope, {:deleted, crm_bravo})
      {:ok, crm_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crm_bravo changes.

  ## Examples

      iex> change_crm_bravo(scope, crm_bravo)
      %Ecto.Changeset{data: %CrmBravo{}}

  """
  def change_crm_bravo(%Scope{} = scope, %CrmBravo{} = crm_bravo, attrs \\ %{}) do
    true = crm_bravo.user_id == scope.user.id

    CrmBravo.changeset(crm_bravo, attrs, scope)
  end

  alias Shop.Crm.CrmCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any crm_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %CrmCharlie{}}
    * {:updated, %CrmCharlie{}}
    * {:deleted, %CrmCharlie{}}

  """
  def subscribe_crm_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:crm_charlies")
  end

  defp broadcast_crm_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:crm_charlies", message)
  end

  @doc """
  Returns the list of crm_charlies.

  ## Examples

      iex> list_crm_charlies(scope)
      [%CrmCharlie{}, ...]

  """
  def list_crm_charlies(%Scope{} = scope) do
    Repo.all_by(CrmCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single crm_charlie.

  Raises `Ecto.NoResultsError` if the Crm charlie does not exist.

  ## Examples

      iex> get_crm_charlie!(scope, 123)
      %CrmCharlie{}

      iex> get_crm_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_crm_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(CrmCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a crm_charlie.

  ## Examples

      iex> create_crm_charlie(scope, %{field: value})
      {:ok, %CrmCharlie{}}

      iex> create_crm_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crm_charlie(%Scope{} = scope, attrs) do
    with {:ok, crm_charlie = %CrmCharlie{}} <-
           %CrmCharlie{}
           |> CrmCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_crm_charlie(scope, {:created, crm_charlie})
      {:ok, crm_charlie}
    end
  end

  @doc """
  Updates a crm_charlie.

  ## Examples

      iex> update_crm_charlie(scope, crm_charlie, %{field: new_value})
      {:ok, %CrmCharlie{}}

      iex> update_crm_charlie(scope, crm_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crm_charlie(%Scope{} = scope, %CrmCharlie{} = crm_charlie, attrs) do
    true = crm_charlie.user_id == scope.user.id

    with {:ok, crm_charlie = %CrmCharlie{}} <-
           crm_charlie
           |> CrmCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_crm_charlie(scope, {:updated, crm_charlie})
      {:ok, crm_charlie}
    end
  end

  @doc """
  Deletes a crm_charlie.

  ## Examples

      iex> delete_crm_charlie(scope, crm_charlie)
      {:ok, %CrmCharlie{}}

      iex> delete_crm_charlie(scope, crm_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crm_charlie(%Scope{} = scope, %CrmCharlie{} = crm_charlie) do
    true = crm_charlie.user_id == scope.user.id

    with {:ok, crm_charlie = %CrmCharlie{}} <-
           Repo.delete(crm_charlie) do
      broadcast_crm_charlie(scope, {:deleted, crm_charlie})
      {:ok, crm_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crm_charlie changes.

  ## Examples

      iex> change_crm_charlie(scope, crm_charlie)
      %Ecto.Changeset{data: %CrmCharlie{}}

  """
  def change_crm_charlie(%Scope{} = scope, %CrmCharlie{} = crm_charlie, attrs \\ %{}) do
    true = crm_charlie.user_id == scope.user.id

    CrmCharlie.changeset(crm_charlie, attrs, scope)
  end

  alias Shop.Crm.CrmDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any crm_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %CrmDelta{}}
    * {:updated, %CrmDelta{}}
    * {:deleted, %CrmDelta{}}

  """
  def subscribe_crm_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:crm_deltas")
  end

  defp broadcast_crm_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:crm_deltas", message)
  end

  @doc """
  Returns the list of crm_deltas.

  ## Examples

      iex> list_crm_deltas(scope)
      [%CrmDelta{}, ...]

  """
  def list_crm_deltas(%Scope{} = scope) do
    Repo.all_by(CrmDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single crm_delta.

  Raises `Ecto.NoResultsError` if the Crm delta does not exist.

  ## Examples

      iex> get_crm_delta!(scope, 123)
      %CrmDelta{}

      iex> get_crm_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_crm_delta!(%Scope{} = scope, id) do
    Repo.get_by!(CrmDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a crm_delta.

  ## Examples

      iex> create_crm_delta(scope, %{field: value})
      {:ok, %CrmDelta{}}

      iex> create_crm_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crm_delta(%Scope{} = scope, attrs) do
    with {:ok, crm_delta = %CrmDelta{}} <-
           %CrmDelta{}
           |> CrmDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_crm_delta(scope, {:created, crm_delta})
      {:ok, crm_delta}
    end
  end

  @doc """
  Updates a crm_delta.

  ## Examples

      iex> update_crm_delta(scope, crm_delta, %{field: new_value})
      {:ok, %CrmDelta{}}

      iex> update_crm_delta(scope, crm_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crm_delta(%Scope{} = scope, %CrmDelta{} = crm_delta, attrs) do
    true = crm_delta.user_id == scope.user.id

    with {:ok, crm_delta = %CrmDelta{}} <-
           crm_delta
           |> CrmDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_crm_delta(scope, {:updated, crm_delta})
      {:ok, crm_delta}
    end
  end

  @doc """
  Deletes a crm_delta.

  ## Examples

      iex> delete_crm_delta(scope, crm_delta)
      {:ok, %CrmDelta{}}

      iex> delete_crm_delta(scope, crm_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crm_delta(%Scope{} = scope, %CrmDelta{} = crm_delta) do
    true = crm_delta.user_id == scope.user.id

    with {:ok, crm_delta = %CrmDelta{}} <-
           Repo.delete(crm_delta) do
      broadcast_crm_delta(scope, {:deleted, crm_delta})
      {:ok, crm_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crm_delta changes.

  ## Examples

      iex> change_crm_delta(scope, crm_delta)
      %Ecto.Changeset{data: %CrmDelta{}}

  """
  def change_crm_delta(%Scope{} = scope, %CrmDelta{} = crm_delta, attrs \\ %{}) do
    true = crm_delta.user_id == scope.user.id

    CrmDelta.changeset(crm_delta, attrs, scope)
  end

  alias Shop.Crm.CrmEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any crm_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %CrmEcho{}}
    * {:updated, %CrmEcho{}}
    * {:deleted, %CrmEcho{}}

  """
  def subscribe_crm_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:crm_echos")
  end

  defp broadcast_crm_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:crm_echos", message)
  end

  @doc """
  Returns the list of crm_echos.

  ## Examples

      iex> list_crm_echos(scope)
      [%CrmEcho{}, ...]

  """
  def list_crm_echos(%Scope{} = scope) do
    Repo.all_by(CrmEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single crm_echo.

  Raises `Ecto.NoResultsError` if the Crm echo does not exist.

  ## Examples

      iex> get_crm_echo!(scope, 123)
      %CrmEcho{}

      iex> get_crm_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_crm_echo!(%Scope{} = scope, id) do
    Repo.get_by!(CrmEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a crm_echo.

  ## Examples

      iex> create_crm_echo(scope, %{field: value})
      {:ok, %CrmEcho{}}

      iex> create_crm_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crm_echo(%Scope{} = scope, attrs) do
    with {:ok, crm_echo = %CrmEcho{}} <-
           %CrmEcho{}
           |> CrmEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_crm_echo(scope, {:created, crm_echo})
      {:ok, crm_echo}
    end
  end

  @doc """
  Updates a crm_echo.

  ## Examples

      iex> update_crm_echo(scope, crm_echo, %{field: new_value})
      {:ok, %CrmEcho{}}

      iex> update_crm_echo(scope, crm_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crm_echo(%Scope{} = scope, %CrmEcho{} = crm_echo, attrs) do
    true = crm_echo.user_id == scope.user.id

    with {:ok, crm_echo = %CrmEcho{}} <-
           crm_echo
           |> CrmEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_crm_echo(scope, {:updated, crm_echo})
      {:ok, crm_echo}
    end
  end

  @doc """
  Deletes a crm_echo.

  ## Examples

      iex> delete_crm_echo(scope, crm_echo)
      {:ok, %CrmEcho{}}

      iex> delete_crm_echo(scope, crm_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crm_echo(%Scope{} = scope, %CrmEcho{} = crm_echo) do
    true = crm_echo.user_id == scope.user.id

    with {:ok, crm_echo = %CrmEcho{}} <-
           Repo.delete(crm_echo) do
      broadcast_crm_echo(scope, {:deleted, crm_echo})
      {:ok, crm_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crm_echo changes.

  ## Examples

      iex> change_crm_echo(scope, crm_echo)
      %Ecto.Changeset{data: %CrmEcho{}}

  """
  def change_crm_echo(%Scope{} = scope, %CrmEcho{} = crm_echo, attrs \\ %{}) do
    true = crm_echo.user_id == scope.user.id

    CrmEcho.changeset(crm_echo, attrs, scope)
  end
end
