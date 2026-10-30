defmodule Shop.Sales do
  @moduledoc """
  The Sales context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Sales.SalesAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any sales_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %SalesAlpha{}}
    * {:updated, %SalesAlpha{}}
    * {:deleted, %SalesAlpha{}}

  """
  def subscribe_sales_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:sales_alphas")
  end

  defp broadcast_sales_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:sales_alphas", message)
  end

  @doc """
  Returns the list of sales_alphas.

  ## Examples

      iex> list_sales_alphas(scope)
      [%SalesAlpha{}, ...]

  """
  def list_sales_alphas(%Scope{} = scope) do
    Repo.all_by(SalesAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single sales_alpha.

  Raises `Ecto.NoResultsError` if the Sales alpha does not exist.

  ## Examples

      iex> get_sales_alpha!(scope, 123)
      %SalesAlpha{}

      iex> get_sales_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_sales_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(SalesAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a sales_alpha.

  ## Examples

      iex> create_sales_alpha(scope, %{field: value})
      {:ok, %SalesAlpha{}}

      iex> create_sales_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales_alpha(%Scope{} = scope, attrs) do
    with {:ok, sales_alpha = %SalesAlpha{}} <-
           %SalesAlpha{}
           |> SalesAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_sales_alpha(scope, {:created, sales_alpha})
      {:ok, sales_alpha}
    end
  end

  @doc """
  Updates a sales_alpha.

  ## Examples

      iex> update_sales_alpha(scope, sales_alpha, %{field: new_value})
      {:ok, %SalesAlpha{}}

      iex> update_sales_alpha(scope, sales_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales_alpha(%Scope{} = scope, %SalesAlpha{} = sales_alpha, attrs) do
    true = sales_alpha.user_id == scope.user.id

    with {:ok, sales_alpha = %SalesAlpha{}} <-
           sales_alpha
           |> SalesAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_sales_alpha(scope, {:updated, sales_alpha})
      {:ok, sales_alpha}
    end
  end

  @doc """
  Deletes a sales_alpha.

  ## Examples

      iex> delete_sales_alpha(scope, sales_alpha)
      {:ok, %SalesAlpha{}}

      iex> delete_sales_alpha(scope, sales_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales_alpha(%Scope{} = scope, %SalesAlpha{} = sales_alpha) do
    true = sales_alpha.user_id == scope.user.id

    with {:ok, sales_alpha = %SalesAlpha{}} <-
           Repo.delete(sales_alpha) do
      broadcast_sales_alpha(scope, {:deleted, sales_alpha})
      {:ok, sales_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales_alpha changes.

  ## Examples

      iex> change_sales_alpha(scope, sales_alpha)
      %Ecto.Changeset{data: %SalesAlpha{}}

  """
  def change_sales_alpha(%Scope{} = scope, %SalesAlpha{} = sales_alpha, attrs \\ %{}) do
    true = sales_alpha.user_id == scope.user.id

    SalesAlpha.changeset(sales_alpha, attrs, scope)
  end

  alias Shop.Sales.SalesBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any sales_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %SalesBravo{}}
    * {:updated, %SalesBravo{}}
    * {:deleted, %SalesBravo{}}

  """
  def subscribe_sales_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:sales_bravos")
  end

  defp broadcast_sales_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:sales_bravos", message)
  end

  @doc """
  Returns the list of sales_bravos.

  ## Examples

      iex> list_sales_bravos(scope)
      [%SalesBravo{}, ...]

  """
  def list_sales_bravos(%Scope{} = scope) do
    Repo.all_by(SalesBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single sales_bravo.

  Raises `Ecto.NoResultsError` if the Sales bravo does not exist.

  ## Examples

      iex> get_sales_bravo!(scope, 123)
      %SalesBravo{}

      iex> get_sales_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_sales_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(SalesBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a sales_bravo.

  ## Examples

      iex> create_sales_bravo(scope, %{field: value})
      {:ok, %SalesBravo{}}

      iex> create_sales_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales_bravo(%Scope{} = scope, attrs) do
    with {:ok, sales_bravo = %SalesBravo{}} <-
           %SalesBravo{}
           |> SalesBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_sales_bravo(scope, {:created, sales_bravo})
      {:ok, sales_bravo}
    end
  end

  @doc """
  Updates a sales_bravo.

  ## Examples

      iex> update_sales_bravo(scope, sales_bravo, %{field: new_value})
      {:ok, %SalesBravo{}}

      iex> update_sales_bravo(scope, sales_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales_bravo(%Scope{} = scope, %SalesBravo{} = sales_bravo, attrs) do
    true = sales_bravo.user_id == scope.user.id

    with {:ok, sales_bravo = %SalesBravo{}} <-
           sales_bravo
           |> SalesBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_sales_bravo(scope, {:updated, sales_bravo})
      {:ok, sales_bravo}
    end
  end

  @doc """
  Deletes a sales_bravo.

  ## Examples

      iex> delete_sales_bravo(scope, sales_bravo)
      {:ok, %SalesBravo{}}

      iex> delete_sales_bravo(scope, sales_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales_bravo(%Scope{} = scope, %SalesBravo{} = sales_bravo) do
    true = sales_bravo.user_id == scope.user.id

    with {:ok, sales_bravo = %SalesBravo{}} <-
           Repo.delete(sales_bravo) do
      broadcast_sales_bravo(scope, {:deleted, sales_bravo})
      {:ok, sales_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales_bravo changes.

  ## Examples

      iex> change_sales_bravo(scope, sales_bravo)
      %Ecto.Changeset{data: %SalesBravo{}}

  """
  def change_sales_bravo(%Scope{} = scope, %SalesBravo{} = sales_bravo, attrs \\ %{}) do
    true = sales_bravo.user_id == scope.user.id

    SalesBravo.changeset(sales_bravo, attrs, scope)
  end

  alias Shop.Sales.SalesCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any sales_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %SalesCharlie{}}
    * {:updated, %SalesCharlie{}}
    * {:deleted, %SalesCharlie{}}

  """
  def subscribe_sales_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:sales_charlies")
  end

  defp broadcast_sales_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:sales_charlies", message)
  end

  @doc """
  Returns the list of sales_charlies.

  ## Examples

      iex> list_sales_charlies(scope)
      [%SalesCharlie{}, ...]

  """
  def list_sales_charlies(%Scope{} = scope) do
    Repo.all_by(SalesCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single sales_charlie.

  Raises `Ecto.NoResultsError` if the Sales charlie does not exist.

  ## Examples

      iex> get_sales_charlie!(scope, 123)
      %SalesCharlie{}

      iex> get_sales_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_sales_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(SalesCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a sales_charlie.

  ## Examples

      iex> create_sales_charlie(scope, %{field: value})
      {:ok, %SalesCharlie{}}

      iex> create_sales_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales_charlie(%Scope{} = scope, attrs) do
    with {:ok, sales_charlie = %SalesCharlie{}} <-
           %SalesCharlie{}
           |> SalesCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_sales_charlie(scope, {:created, sales_charlie})
      {:ok, sales_charlie}
    end
  end

  @doc """
  Updates a sales_charlie.

  ## Examples

      iex> update_sales_charlie(scope, sales_charlie, %{field: new_value})
      {:ok, %SalesCharlie{}}

      iex> update_sales_charlie(scope, sales_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales_charlie(%Scope{} = scope, %SalesCharlie{} = sales_charlie, attrs) do
    true = sales_charlie.user_id == scope.user.id

    with {:ok, sales_charlie = %SalesCharlie{}} <-
           sales_charlie
           |> SalesCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_sales_charlie(scope, {:updated, sales_charlie})
      {:ok, sales_charlie}
    end
  end

  @doc """
  Deletes a sales_charlie.

  ## Examples

      iex> delete_sales_charlie(scope, sales_charlie)
      {:ok, %SalesCharlie{}}

      iex> delete_sales_charlie(scope, sales_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales_charlie(%Scope{} = scope, %SalesCharlie{} = sales_charlie) do
    true = sales_charlie.user_id == scope.user.id

    with {:ok, sales_charlie = %SalesCharlie{}} <-
           Repo.delete(sales_charlie) do
      broadcast_sales_charlie(scope, {:deleted, sales_charlie})
      {:ok, sales_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales_charlie changes.

  ## Examples

      iex> change_sales_charlie(scope, sales_charlie)
      %Ecto.Changeset{data: %SalesCharlie{}}

  """
  def change_sales_charlie(%Scope{} = scope, %SalesCharlie{} = sales_charlie, attrs \\ %{}) do
    true = sales_charlie.user_id == scope.user.id

    SalesCharlie.changeset(sales_charlie, attrs, scope)
  end

  alias Shop.Sales.SalesDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any sales_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %SalesDelta{}}
    * {:updated, %SalesDelta{}}
    * {:deleted, %SalesDelta{}}

  """
  def subscribe_sales_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:sales_deltas")
  end

  defp broadcast_sales_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:sales_deltas", message)
  end

  @doc """
  Returns the list of sales_deltas.

  ## Examples

      iex> list_sales_deltas(scope)
      [%SalesDelta{}, ...]

  """
  def list_sales_deltas(%Scope{} = scope) do
    Repo.all_by(SalesDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single sales_delta.

  Raises `Ecto.NoResultsError` if the Sales delta does not exist.

  ## Examples

      iex> get_sales_delta!(scope, 123)
      %SalesDelta{}

      iex> get_sales_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_sales_delta!(%Scope{} = scope, id) do
    Repo.get_by!(SalesDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a sales_delta.

  ## Examples

      iex> create_sales_delta(scope, %{field: value})
      {:ok, %SalesDelta{}}

      iex> create_sales_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales_delta(%Scope{} = scope, attrs) do
    with {:ok, sales_delta = %SalesDelta{}} <-
           %SalesDelta{}
           |> SalesDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_sales_delta(scope, {:created, sales_delta})
      {:ok, sales_delta}
    end
  end

  @doc """
  Updates a sales_delta.

  ## Examples

      iex> update_sales_delta(scope, sales_delta, %{field: new_value})
      {:ok, %SalesDelta{}}

      iex> update_sales_delta(scope, sales_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales_delta(%Scope{} = scope, %SalesDelta{} = sales_delta, attrs) do
    true = sales_delta.user_id == scope.user.id

    with {:ok, sales_delta = %SalesDelta{}} <-
           sales_delta
           |> SalesDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_sales_delta(scope, {:updated, sales_delta})
      {:ok, sales_delta}
    end
  end

  @doc """
  Deletes a sales_delta.

  ## Examples

      iex> delete_sales_delta(scope, sales_delta)
      {:ok, %SalesDelta{}}

      iex> delete_sales_delta(scope, sales_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales_delta(%Scope{} = scope, %SalesDelta{} = sales_delta) do
    true = sales_delta.user_id == scope.user.id

    with {:ok, sales_delta = %SalesDelta{}} <-
           Repo.delete(sales_delta) do
      broadcast_sales_delta(scope, {:deleted, sales_delta})
      {:ok, sales_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales_delta changes.

  ## Examples

      iex> change_sales_delta(scope, sales_delta)
      %Ecto.Changeset{data: %SalesDelta{}}

  """
  def change_sales_delta(%Scope{} = scope, %SalesDelta{} = sales_delta, attrs \\ %{}) do
    true = sales_delta.user_id == scope.user.id

    SalesDelta.changeset(sales_delta, attrs, scope)
  end

  alias Shop.Sales.SalesEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any sales_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %SalesEcho{}}
    * {:updated, %SalesEcho{}}
    * {:deleted, %SalesEcho{}}

  """
  def subscribe_sales_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:sales_echos")
  end

  defp broadcast_sales_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:sales_echos", message)
  end

  @doc """
  Returns the list of sales_echos.

  ## Examples

      iex> list_sales_echos(scope)
      [%SalesEcho{}, ...]

  """
  def list_sales_echos(%Scope{} = scope) do
    Repo.all_by(SalesEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single sales_echo.

  Raises `Ecto.NoResultsError` if the Sales echo does not exist.

  ## Examples

      iex> get_sales_echo!(scope, 123)
      %SalesEcho{}

      iex> get_sales_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_sales_echo!(%Scope{} = scope, id) do
    Repo.get_by!(SalesEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a sales_echo.

  ## Examples

      iex> create_sales_echo(scope, %{field: value})
      {:ok, %SalesEcho{}}

      iex> create_sales_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sales_echo(%Scope{} = scope, attrs) do
    with {:ok, sales_echo = %SalesEcho{}} <-
           %SalesEcho{}
           |> SalesEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_sales_echo(scope, {:created, sales_echo})
      {:ok, sales_echo}
    end
  end

  @doc """
  Updates a sales_echo.

  ## Examples

      iex> update_sales_echo(scope, sales_echo, %{field: new_value})
      {:ok, %SalesEcho{}}

      iex> update_sales_echo(scope, sales_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sales_echo(%Scope{} = scope, %SalesEcho{} = sales_echo, attrs) do
    true = sales_echo.user_id == scope.user.id

    with {:ok, sales_echo = %SalesEcho{}} <-
           sales_echo
           |> SalesEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_sales_echo(scope, {:updated, sales_echo})
      {:ok, sales_echo}
    end
  end

  @doc """
  Deletes a sales_echo.

  ## Examples

      iex> delete_sales_echo(scope, sales_echo)
      {:ok, %SalesEcho{}}

      iex> delete_sales_echo(scope, sales_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sales_echo(%Scope{} = scope, %SalesEcho{} = sales_echo) do
    true = sales_echo.user_id == scope.user.id

    with {:ok, sales_echo = %SalesEcho{}} <-
           Repo.delete(sales_echo) do
      broadcast_sales_echo(scope, {:deleted, sales_echo})
      {:ok, sales_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sales_echo changes.

  ## Examples

      iex> change_sales_echo(scope, sales_echo)
      %Ecto.Changeset{data: %SalesEcho{}}

  """
  def change_sales_echo(%Scope{} = scope, %SalesEcho{} = sales_echo, attrs \\ %{}) do
    true = sales_echo.user_id == scope.user.id

    SalesEcho.changeset(sales_echo, attrs, scope)
  end
end
