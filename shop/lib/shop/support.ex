defmodule Shop.Support do
  @moduledoc """
  The Support context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Support.SupportAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any support_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %SupportAlpha{}}
    * {:updated, %SupportAlpha{}}
    * {:deleted, %SupportAlpha{}}

  """
  def subscribe_support_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:support_alphas")
  end

  defp broadcast_support_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:support_alphas", message)
  end

  @doc """
  Returns the list of support_alphas.

  ## Examples

      iex> list_support_alphas(scope)
      [%SupportAlpha{}, ...]

  """
  def list_support_alphas(%Scope{} = scope) do
    Repo.all_by(SupportAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single support_alpha.

  Raises `Ecto.NoResultsError` if the Support alpha does not exist.

  ## Examples

      iex> get_support_alpha!(scope, 123)
      %SupportAlpha{}

      iex> get_support_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_support_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(SupportAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a support_alpha.

  ## Examples

      iex> create_support_alpha(scope, %{field: value})
      {:ok, %SupportAlpha{}}

      iex> create_support_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_support_alpha(%Scope{} = scope, attrs) do
    with {:ok, support_alpha = %SupportAlpha{}} <-
           %SupportAlpha{}
           |> SupportAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_support_alpha(scope, {:created, support_alpha})
      {:ok, support_alpha}
    end
  end

  @doc """
  Updates a support_alpha.

  ## Examples

      iex> update_support_alpha(scope, support_alpha, %{field: new_value})
      {:ok, %SupportAlpha{}}

      iex> update_support_alpha(scope, support_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_support_alpha(%Scope{} = scope, %SupportAlpha{} = support_alpha, attrs) do
    true = support_alpha.user_id == scope.user.id

    with {:ok, support_alpha = %SupportAlpha{}} <-
           support_alpha
           |> SupportAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_support_alpha(scope, {:updated, support_alpha})
      {:ok, support_alpha}
    end
  end

  @doc """
  Deletes a support_alpha.

  ## Examples

      iex> delete_support_alpha(scope, support_alpha)
      {:ok, %SupportAlpha{}}

      iex> delete_support_alpha(scope, support_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_support_alpha(%Scope{} = scope, %SupportAlpha{} = support_alpha) do
    true = support_alpha.user_id == scope.user.id

    with {:ok, support_alpha = %SupportAlpha{}} <-
           Repo.delete(support_alpha) do
      broadcast_support_alpha(scope, {:deleted, support_alpha})
      {:ok, support_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking support_alpha changes.

  ## Examples

      iex> change_support_alpha(scope, support_alpha)
      %Ecto.Changeset{data: %SupportAlpha{}}

  """
  def change_support_alpha(%Scope{} = scope, %SupportAlpha{} = support_alpha, attrs \\ %{}) do
    true = support_alpha.user_id == scope.user.id

    SupportAlpha.changeset(support_alpha, attrs, scope)
  end

  alias Shop.Support.SupportBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any support_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %SupportBravo{}}
    * {:updated, %SupportBravo{}}
    * {:deleted, %SupportBravo{}}

  """
  def subscribe_support_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:support_bravos")
  end

  defp broadcast_support_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:support_bravos", message)
  end

  @doc """
  Returns the list of support_bravos.

  ## Examples

      iex> list_support_bravos(scope)
      [%SupportBravo{}, ...]

  """
  def list_support_bravos(%Scope{} = scope) do
    Repo.all_by(SupportBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single support_bravo.

  Raises `Ecto.NoResultsError` if the Support bravo does not exist.

  ## Examples

      iex> get_support_bravo!(scope, 123)
      %SupportBravo{}

      iex> get_support_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_support_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(SupportBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a support_bravo.

  ## Examples

      iex> create_support_bravo(scope, %{field: value})
      {:ok, %SupportBravo{}}

      iex> create_support_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_support_bravo(%Scope{} = scope, attrs) do
    with {:ok, support_bravo = %SupportBravo{}} <-
           %SupportBravo{}
           |> SupportBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_support_bravo(scope, {:created, support_bravo})
      {:ok, support_bravo}
    end
  end

  @doc """
  Updates a support_bravo.

  ## Examples

      iex> update_support_bravo(scope, support_bravo, %{field: new_value})
      {:ok, %SupportBravo{}}

      iex> update_support_bravo(scope, support_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_support_bravo(%Scope{} = scope, %SupportBravo{} = support_bravo, attrs) do
    true = support_bravo.user_id == scope.user.id

    with {:ok, support_bravo = %SupportBravo{}} <-
           support_bravo
           |> SupportBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_support_bravo(scope, {:updated, support_bravo})
      {:ok, support_bravo}
    end
  end

  @doc """
  Deletes a support_bravo.

  ## Examples

      iex> delete_support_bravo(scope, support_bravo)
      {:ok, %SupportBravo{}}

      iex> delete_support_bravo(scope, support_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_support_bravo(%Scope{} = scope, %SupportBravo{} = support_bravo) do
    true = support_bravo.user_id == scope.user.id

    with {:ok, support_bravo = %SupportBravo{}} <-
           Repo.delete(support_bravo) do
      broadcast_support_bravo(scope, {:deleted, support_bravo})
      {:ok, support_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking support_bravo changes.

  ## Examples

      iex> change_support_bravo(scope, support_bravo)
      %Ecto.Changeset{data: %SupportBravo{}}

  """
  def change_support_bravo(%Scope{} = scope, %SupportBravo{} = support_bravo, attrs \\ %{}) do
    true = support_bravo.user_id == scope.user.id

    SupportBravo.changeset(support_bravo, attrs, scope)
  end

  alias Shop.Support.SupportCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any support_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %SupportCharlie{}}
    * {:updated, %SupportCharlie{}}
    * {:deleted, %SupportCharlie{}}

  """
  def subscribe_support_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:support_charlies")
  end

  defp broadcast_support_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:support_charlies", message)
  end

  @doc """
  Returns the list of support_charlies.

  ## Examples

      iex> list_support_charlies(scope)
      [%SupportCharlie{}, ...]

  """
  def list_support_charlies(%Scope{} = scope) do
    Repo.all_by(SupportCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single support_charlie.

  Raises `Ecto.NoResultsError` if the Support charlie does not exist.

  ## Examples

      iex> get_support_charlie!(scope, 123)
      %SupportCharlie{}

      iex> get_support_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_support_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(SupportCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a support_charlie.

  ## Examples

      iex> create_support_charlie(scope, %{field: value})
      {:ok, %SupportCharlie{}}

      iex> create_support_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_support_charlie(%Scope{} = scope, attrs) do
    with {:ok, support_charlie = %SupportCharlie{}} <-
           %SupportCharlie{}
           |> SupportCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_support_charlie(scope, {:created, support_charlie})
      {:ok, support_charlie}
    end
  end

  @doc """
  Updates a support_charlie.

  ## Examples

      iex> update_support_charlie(scope, support_charlie, %{field: new_value})
      {:ok, %SupportCharlie{}}

      iex> update_support_charlie(scope, support_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_support_charlie(%Scope{} = scope, %SupportCharlie{} = support_charlie, attrs) do
    true = support_charlie.user_id == scope.user.id

    with {:ok, support_charlie = %SupportCharlie{}} <-
           support_charlie
           |> SupportCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_support_charlie(scope, {:updated, support_charlie})
      {:ok, support_charlie}
    end
  end

  @doc """
  Deletes a support_charlie.

  ## Examples

      iex> delete_support_charlie(scope, support_charlie)
      {:ok, %SupportCharlie{}}

      iex> delete_support_charlie(scope, support_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_support_charlie(%Scope{} = scope, %SupportCharlie{} = support_charlie) do
    true = support_charlie.user_id == scope.user.id

    with {:ok, support_charlie = %SupportCharlie{}} <-
           Repo.delete(support_charlie) do
      broadcast_support_charlie(scope, {:deleted, support_charlie})
      {:ok, support_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking support_charlie changes.

  ## Examples

      iex> change_support_charlie(scope, support_charlie)
      %Ecto.Changeset{data: %SupportCharlie{}}

  """
  def change_support_charlie(%Scope{} = scope, %SupportCharlie{} = support_charlie, attrs \\ %{}) do
    true = support_charlie.user_id == scope.user.id

    SupportCharlie.changeset(support_charlie, attrs, scope)
  end

  alias Shop.Support.SupportDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any support_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %SupportDelta{}}
    * {:updated, %SupportDelta{}}
    * {:deleted, %SupportDelta{}}

  """
  def subscribe_support_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:support_deltas")
  end

  defp broadcast_support_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:support_deltas", message)
  end

  @doc """
  Returns the list of support_deltas.

  ## Examples

      iex> list_support_deltas(scope)
      [%SupportDelta{}, ...]

  """
  def list_support_deltas(%Scope{} = scope) do
    Repo.all_by(SupportDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single support_delta.

  Raises `Ecto.NoResultsError` if the Support delta does not exist.

  ## Examples

      iex> get_support_delta!(scope, 123)
      %SupportDelta{}

      iex> get_support_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_support_delta!(%Scope{} = scope, id) do
    Repo.get_by!(SupportDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a support_delta.

  ## Examples

      iex> create_support_delta(scope, %{field: value})
      {:ok, %SupportDelta{}}

      iex> create_support_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_support_delta(%Scope{} = scope, attrs) do
    with {:ok, support_delta = %SupportDelta{}} <-
           %SupportDelta{}
           |> SupportDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_support_delta(scope, {:created, support_delta})
      {:ok, support_delta}
    end
  end

  @doc """
  Updates a support_delta.

  ## Examples

      iex> update_support_delta(scope, support_delta, %{field: new_value})
      {:ok, %SupportDelta{}}

      iex> update_support_delta(scope, support_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_support_delta(%Scope{} = scope, %SupportDelta{} = support_delta, attrs) do
    true = support_delta.user_id == scope.user.id

    with {:ok, support_delta = %SupportDelta{}} <-
           support_delta
           |> SupportDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_support_delta(scope, {:updated, support_delta})
      {:ok, support_delta}
    end
  end

  @doc """
  Deletes a support_delta.

  ## Examples

      iex> delete_support_delta(scope, support_delta)
      {:ok, %SupportDelta{}}

      iex> delete_support_delta(scope, support_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_support_delta(%Scope{} = scope, %SupportDelta{} = support_delta) do
    true = support_delta.user_id == scope.user.id

    with {:ok, support_delta = %SupportDelta{}} <-
           Repo.delete(support_delta) do
      broadcast_support_delta(scope, {:deleted, support_delta})
      {:ok, support_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking support_delta changes.

  ## Examples

      iex> change_support_delta(scope, support_delta)
      %Ecto.Changeset{data: %SupportDelta{}}

  """
  def change_support_delta(%Scope{} = scope, %SupportDelta{} = support_delta, attrs \\ %{}) do
    true = support_delta.user_id == scope.user.id

    SupportDelta.changeset(support_delta, attrs, scope)
  end

  alias Shop.Support.SupportEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any support_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %SupportEcho{}}
    * {:updated, %SupportEcho{}}
    * {:deleted, %SupportEcho{}}

  """
  def subscribe_support_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:support_echos")
  end

  defp broadcast_support_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:support_echos", message)
  end

  @doc """
  Returns the list of support_echos.

  ## Examples

      iex> list_support_echos(scope)
      [%SupportEcho{}, ...]

  """
  def list_support_echos(%Scope{} = scope) do
    Repo.all_by(SupportEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single support_echo.

  Raises `Ecto.NoResultsError` if the Support echo does not exist.

  ## Examples

      iex> get_support_echo!(scope, 123)
      %SupportEcho{}

      iex> get_support_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_support_echo!(%Scope{} = scope, id) do
    Repo.get_by!(SupportEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a support_echo.

  ## Examples

      iex> create_support_echo(scope, %{field: value})
      {:ok, %SupportEcho{}}

      iex> create_support_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_support_echo(%Scope{} = scope, attrs) do
    with {:ok, support_echo = %SupportEcho{}} <-
           %SupportEcho{}
           |> SupportEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_support_echo(scope, {:created, support_echo})
      {:ok, support_echo}
    end
  end

  @doc """
  Updates a support_echo.

  ## Examples

      iex> update_support_echo(scope, support_echo, %{field: new_value})
      {:ok, %SupportEcho{}}

      iex> update_support_echo(scope, support_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_support_echo(%Scope{} = scope, %SupportEcho{} = support_echo, attrs) do
    true = support_echo.user_id == scope.user.id

    with {:ok, support_echo = %SupportEcho{}} <-
           support_echo
           |> SupportEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_support_echo(scope, {:updated, support_echo})
      {:ok, support_echo}
    end
  end

  @doc """
  Deletes a support_echo.

  ## Examples

      iex> delete_support_echo(scope, support_echo)
      {:ok, %SupportEcho{}}

      iex> delete_support_echo(scope, support_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_support_echo(%Scope{} = scope, %SupportEcho{} = support_echo) do
    true = support_echo.user_id == scope.user.id

    with {:ok, support_echo = %SupportEcho{}} <-
           Repo.delete(support_echo) do
      broadcast_support_echo(scope, {:deleted, support_echo})
      {:ok, support_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking support_echo changes.

  ## Examples

      iex> change_support_echo(scope, support_echo)
      %Ecto.Changeset{data: %SupportEcho{}}

  """
  def change_support_echo(%Scope{} = scope, %SupportEcho{} = support_echo, attrs \\ %{}) do
    true = support_echo.user_id == scope.user.id

    SupportEcho.changeset(support_echo, attrs, scope)
  end
end
