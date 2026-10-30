defmodule Shop.Billing do
  @moduledoc """
  The Billing context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Billing.BillingAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any billing_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %BillingAlpha{}}
    * {:updated, %BillingAlpha{}}
    * {:deleted, %BillingAlpha{}}

  """
  def subscribe_billing_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:billing_alphas")
  end

  defp broadcast_billing_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:billing_alphas", message)
  end

  @doc """
  Returns the list of billing_alphas.

  ## Examples

      iex> list_billing_alphas(scope)
      [%BillingAlpha{}, ...]

  """
  def list_billing_alphas(%Scope{} = scope) do
    Repo.all_by(BillingAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single billing_alpha.

  Raises `Ecto.NoResultsError` if the Billing alpha does not exist.

  ## Examples

      iex> get_billing_alpha!(scope, 123)
      %BillingAlpha{}

      iex> get_billing_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_billing_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(BillingAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a billing_alpha.

  ## Examples

      iex> create_billing_alpha(scope, %{field: value})
      {:ok, %BillingAlpha{}}

      iex> create_billing_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_billing_alpha(%Scope{} = scope, attrs) do
    with {:ok, billing_alpha = %BillingAlpha{}} <-
           %BillingAlpha{}
           |> BillingAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_billing_alpha(scope, {:created, billing_alpha})
      {:ok, billing_alpha}
    end
  end

  @doc """
  Updates a billing_alpha.

  ## Examples

      iex> update_billing_alpha(scope, billing_alpha, %{field: new_value})
      {:ok, %BillingAlpha{}}

      iex> update_billing_alpha(scope, billing_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_billing_alpha(%Scope{} = scope, %BillingAlpha{} = billing_alpha, attrs) do
    true = billing_alpha.user_id == scope.user.id

    with {:ok, billing_alpha = %BillingAlpha{}} <-
           billing_alpha
           |> BillingAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_billing_alpha(scope, {:updated, billing_alpha})
      {:ok, billing_alpha}
    end
  end

  @doc """
  Deletes a billing_alpha.

  ## Examples

      iex> delete_billing_alpha(scope, billing_alpha)
      {:ok, %BillingAlpha{}}

      iex> delete_billing_alpha(scope, billing_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_billing_alpha(%Scope{} = scope, %BillingAlpha{} = billing_alpha) do
    true = billing_alpha.user_id == scope.user.id

    with {:ok, billing_alpha = %BillingAlpha{}} <-
           Repo.delete(billing_alpha) do
      broadcast_billing_alpha(scope, {:deleted, billing_alpha})
      {:ok, billing_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking billing_alpha changes.

  ## Examples

      iex> change_billing_alpha(scope, billing_alpha)
      %Ecto.Changeset{data: %BillingAlpha{}}

  """
  def change_billing_alpha(%Scope{} = scope, %BillingAlpha{} = billing_alpha, attrs \\ %{}) do
    true = billing_alpha.user_id == scope.user.id

    BillingAlpha.changeset(billing_alpha, attrs, scope)
  end

  alias Shop.Billing.BillingBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any billing_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %BillingBravo{}}
    * {:updated, %BillingBravo{}}
    * {:deleted, %BillingBravo{}}

  """
  def subscribe_billing_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:billing_bravos")
  end

  defp broadcast_billing_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:billing_bravos", message)
  end

  @doc """
  Returns the list of billing_bravos.

  ## Examples

      iex> list_billing_bravos(scope)
      [%BillingBravo{}, ...]

  """
  def list_billing_bravos(%Scope{} = scope) do
    Repo.all_by(BillingBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single billing_bravo.

  Raises `Ecto.NoResultsError` if the Billing bravo does not exist.

  ## Examples

      iex> get_billing_bravo!(scope, 123)
      %BillingBravo{}

      iex> get_billing_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_billing_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(BillingBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a billing_bravo.

  ## Examples

      iex> create_billing_bravo(scope, %{field: value})
      {:ok, %BillingBravo{}}

      iex> create_billing_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_billing_bravo(%Scope{} = scope, attrs) do
    with {:ok, billing_bravo = %BillingBravo{}} <-
           %BillingBravo{}
           |> BillingBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_billing_bravo(scope, {:created, billing_bravo})
      {:ok, billing_bravo}
    end
  end

  @doc """
  Updates a billing_bravo.

  ## Examples

      iex> update_billing_bravo(scope, billing_bravo, %{field: new_value})
      {:ok, %BillingBravo{}}

      iex> update_billing_bravo(scope, billing_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_billing_bravo(%Scope{} = scope, %BillingBravo{} = billing_bravo, attrs) do
    true = billing_bravo.user_id == scope.user.id

    with {:ok, billing_bravo = %BillingBravo{}} <-
           billing_bravo
           |> BillingBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_billing_bravo(scope, {:updated, billing_bravo})
      {:ok, billing_bravo}
    end
  end

  @doc """
  Deletes a billing_bravo.

  ## Examples

      iex> delete_billing_bravo(scope, billing_bravo)
      {:ok, %BillingBravo{}}

      iex> delete_billing_bravo(scope, billing_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_billing_bravo(%Scope{} = scope, %BillingBravo{} = billing_bravo) do
    true = billing_bravo.user_id == scope.user.id

    with {:ok, billing_bravo = %BillingBravo{}} <-
           Repo.delete(billing_bravo) do
      broadcast_billing_bravo(scope, {:deleted, billing_bravo})
      {:ok, billing_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking billing_bravo changes.

  ## Examples

      iex> change_billing_bravo(scope, billing_bravo)
      %Ecto.Changeset{data: %BillingBravo{}}

  """
  def change_billing_bravo(%Scope{} = scope, %BillingBravo{} = billing_bravo, attrs \\ %{}) do
    true = billing_bravo.user_id == scope.user.id

    BillingBravo.changeset(billing_bravo, attrs, scope)
  end

  alias Shop.Billing.BillingCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any billing_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %BillingCharlie{}}
    * {:updated, %BillingCharlie{}}
    * {:deleted, %BillingCharlie{}}

  """
  def subscribe_billing_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:billing_charlies")
  end

  defp broadcast_billing_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:billing_charlies", message)
  end

  @doc """
  Returns the list of billing_charlies.

  ## Examples

      iex> list_billing_charlies(scope)
      [%BillingCharlie{}, ...]

  """
  def list_billing_charlies(%Scope{} = scope) do
    Repo.all_by(BillingCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single billing_charlie.

  Raises `Ecto.NoResultsError` if the Billing charlie does not exist.

  ## Examples

      iex> get_billing_charlie!(scope, 123)
      %BillingCharlie{}

      iex> get_billing_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_billing_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(BillingCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a billing_charlie.

  ## Examples

      iex> create_billing_charlie(scope, %{field: value})
      {:ok, %BillingCharlie{}}

      iex> create_billing_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_billing_charlie(%Scope{} = scope, attrs) do
    with {:ok, billing_charlie = %BillingCharlie{}} <-
           %BillingCharlie{}
           |> BillingCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_billing_charlie(scope, {:created, billing_charlie})
      {:ok, billing_charlie}
    end
  end

  @doc """
  Updates a billing_charlie.

  ## Examples

      iex> update_billing_charlie(scope, billing_charlie, %{field: new_value})
      {:ok, %BillingCharlie{}}

      iex> update_billing_charlie(scope, billing_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_billing_charlie(%Scope{} = scope, %BillingCharlie{} = billing_charlie, attrs) do
    true = billing_charlie.user_id == scope.user.id

    with {:ok, billing_charlie = %BillingCharlie{}} <-
           billing_charlie
           |> BillingCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_billing_charlie(scope, {:updated, billing_charlie})
      {:ok, billing_charlie}
    end
  end

  @doc """
  Deletes a billing_charlie.

  ## Examples

      iex> delete_billing_charlie(scope, billing_charlie)
      {:ok, %BillingCharlie{}}

      iex> delete_billing_charlie(scope, billing_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_billing_charlie(%Scope{} = scope, %BillingCharlie{} = billing_charlie) do
    true = billing_charlie.user_id == scope.user.id

    with {:ok, billing_charlie = %BillingCharlie{}} <-
           Repo.delete(billing_charlie) do
      broadcast_billing_charlie(scope, {:deleted, billing_charlie})
      {:ok, billing_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking billing_charlie changes.

  ## Examples

      iex> change_billing_charlie(scope, billing_charlie)
      %Ecto.Changeset{data: %BillingCharlie{}}

  """
  def change_billing_charlie(%Scope{} = scope, %BillingCharlie{} = billing_charlie, attrs \\ %{}) do
    true = billing_charlie.user_id == scope.user.id

    BillingCharlie.changeset(billing_charlie, attrs, scope)
  end

  alias Shop.Billing.BillingDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any billing_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %BillingDelta{}}
    * {:updated, %BillingDelta{}}
    * {:deleted, %BillingDelta{}}

  """
  def subscribe_billing_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:billing_deltas")
  end

  defp broadcast_billing_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:billing_deltas", message)
  end

  @doc """
  Returns the list of billing_deltas.

  ## Examples

      iex> list_billing_deltas(scope)
      [%BillingDelta{}, ...]

  """
  def list_billing_deltas(%Scope{} = scope) do
    Repo.all_by(BillingDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single billing_delta.

  Raises `Ecto.NoResultsError` if the Billing delta does not exist.

  ## Examples

      iex> get_billing_delta!(scope, 123)
      %BillingDelta{}

      iex> get_billing_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_billing_delta!(%Scope{} = scope, id) do
    Repo.get_by!(BillingDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a billing_delta.

  ## Examples

      iex> create_billing_delta(scope, %{field: value})
      {:ok, %BillingDelta{}}

      iex> create_billing_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_billing_delta(%Scope{} = scope, attrs) do
    with {:ok, billing_delta = %BillingDelta{}} <-
           %BillingDelta{}
           |> BillingDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_billing_delta(scope, {:created, billing_delta})
      {:ok, billing_delta}
    end
  end

  @doc """
  Updates a billing_delta.

  ## Examples

      iex> update_billing_delta(scope, billing_delta, %{field: new_value})
      {:ok, %BillingDelta{}}

      iex> update_billing_delta(scope, billing_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_billing_delta(%Scope{} = scope, %BillingDelta{} = billing_delta, attrs) do
    true = billing_delta.user_id == scope.user.id

    with {:ok, billing_delta = %BillingDelta{}} <-
           billing_delta
           |> BillingDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_billing_delta(scope, {:updated, billing_delta})
      {:ok, billing_delta}
    end
  end

  @doc """
  Deletes a billing_delta.

  ## Examples

      iex> delete_billing_delta(scope, billing_delta)
      {:ok, %BillingDelta{}}

      iex> delete_billing_delta(scope, billing_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_billing_delta(%Scope{} = scope, %BillingDelta{} = billing_delta) do
    true = billing_delta.user_id == scope.user.id

    with {:ok, billing_delta = %BillingDelta{}} <-
           Repo.delete(billing_delta) do
      broadcast_billing_delta(scope, {:deleted, billing_delta})
      {:ok, billing_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking billing_delta changes.

  ## Examples

      iex> change_billing_delta(scope, billing_delta)
      %Ecto.Changeset{data: %BillingDelta{}}

  """
  def change_billing_delta(%Scope{} = scope, %BillingDelta{} = billing_delta, attrs \\ %{}) do
    true = billing_delta.user_id == scope.user.id

    BillingDelta.changeset(billing_delta, attrs, scope)
  end

  alias Shop.Billing.BillingEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any billing_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %BillingEcho{}}
    * {:updated, %BillingEcho{}}
    * {:deleted, %BillingEcho{}}

  """
  def subscribe_billing_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:billing_echos")
  end

  defp broadcast_billing_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:billing_echos", message)
  end

  @doc """
  Returns the list of billing_echos.

  ## Examples

      iex> list_billing_echos(scope)
      [%BillingEcho{}, ...]

  """
  def list_billing_echos(%Scope{} = scope) do
    Repo.all_by(BillingEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single billing_echo.

  Raises `Ecto.NoResultsError` if the Billing echo does not exist.

  ## Examples

      iex> get_billing_echo!(scope, 123)
      %BillingEcho{}

      iex> get_billing_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_billing_echo!(%Scope{} = scope, id) do
    Repo.get_by!(BillingEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a billing_echo.

  ## Examples

      iex> create_billing_echo(scope, %{field: value})
      {:ok, %BillingEcho{}}

      iex> create_billing_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_billing_echo(%Scope{} = scope, attrs) do
    with {:ok, billing_echo = %BillingEcho{}} <-
           %BillingEcho{}
           |> BillingEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_billing_echo(scope, {:created, billing_echo})
      {:ok, billing_echo}
    end
  end

  @doc """
  Updates a billing_echo.

  ## Examples

      iex> update_billing_echo(scope, billing_echo, %{field: new_value})
      {:ok, %BillingEcho{}}

      iex> update_billing_echo(scope, billing_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_billing_echo(%Scope{} = scope, %BillingEcho{} = billing_echo, attrs) do
    true = billing_echo.user_id == scope.user.id

    with {:ok, billing_echo = %BillingEcho{}} <-
           billing_echo
           |> BillingEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_billing_echo(scope, {:updated, billing_echo})
      {:ok, billing_echo}
    end
  end

  @doc """
  Deletes a billing_echo.

  ## Examples

      iex> delete_billing_echo(scope, billing_echo)
      {:ok, %BillingEcho{}}

      iex> delete_billing_echo(scope, billing_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_billing_echo(%Scope{} = scope, %BillingEcho{} = billing_echo) do
    true = billing_echo.user_id == scope.user.id

    with {:ok, billing_echo = %BillingEcho{}} <-
           Repo.delete(billing_echo) do
      broadcast_billing_echo(scope, {:deleted, billing_echo})
      {:ok, billing_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking billing_echo changes.

  ## Examples

      iex> change_billing_echo(scope, billing_echo)
      %Ecto.Changeset{data: %BillingEcho{}}

  """
  def change_billing_echo(%Scope{} = scope, %BillingEcho{} = billing_echo, attrs \\ %{}) do
    true = billing_echo.user_id == scope.user.id

    BillingEcho.changeset(billing_echo, attrs, scope)
  end
end
