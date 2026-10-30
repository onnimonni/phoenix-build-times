defmodule Shop.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Content.ContentAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any content_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %ContentAlpha{}}
    * {:updated, %ContentAlpha{}}
    * {:deleted, %ContentAlpha{}}

  """
  def subscribe_content_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:content_alphas")
  end

  defp broadcast_content_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:content_alphas", message)
  end

  @doc """
  Returns the list of content_alphas.

  ## Examples

      iex> list_content_alphas(scope)
      [%ContentAlpha{}, ...]

  """
  def list_content_alphas(%Scope{} = scope) do
    Repo.all_by(ContentAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single content_alpha.

  Raises `Ecto.NoResultsError` if the Content alpha does not exist.

  ## Examples

      iex> get_content_alpha!(scope, 123)
      %ContentAlpha{}

      iex> get_content_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_content_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(ContentAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a content_alpha.

  ## Examples

      iex> create_content_alpha(scope, %{field: value})
      {:ok, %ContentAlpha{}}

      iex> create_content_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_alpha(%Scope{} = scope, attrs) do
    with {:ok, content_alpha = %ContentAlpha{}} <-
           %ContentAlpha{}
           |> ContentAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_content_alpha(scope, {:created, content_alpha})
      {:ok, content_alpha}
    end
  end

  @doc """
  Updates a content_alpha.

  ## Examples

      iex> update_content_alpha(scope, content_alpha, %{field: new_value})
      {:ok, %ContentAlpha{}}

      iex> update_content_alpha(scope, content_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_alpha(%Scope{} = scope, %ContentAlpha{} = content_alpha, attrs) do
    true = content_alpha.user_id == scope.user.id

    with {:ok, content_alpha = %ContentAlpha{}} <-
           content_alpha
           |> ContentAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_content_alpha(scope, {:updated, content_alpha})
      {:ok, content_alpha}
    end
  end

  @doc """
  Deletes a content_alpha.

  ## Examples

      iex> delete_content_alpha(scope, content_alpha)
      {:ok, %ContentAlpha{}}

      iex> delete_content_alpha(scope, content_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_alpha(%Scope{} = scope, %ContentAlpha{} = content_alpha) do
    true = content_alpha.user_id == scope.user.id

    with {:ok, content_alpha = %ContentAlpha{}} <-
           Repo.delete(content_alpha) do
      broadcast_content_alpha(scope, {:deleted, content_alpha})
      {:ok, content_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_alpha changes.

  ## Examples

      iex> change_content_alpha(scope, content_alpha)
      %Ecto.Changeset{data: %ContentAlpha{}}

  """
  def change_content_alpha(%Scope{} = scope, %ContentAlpha{} = content_alpha, attrs \\ %{}) do
    true = content_alpha.user_id == scope.user.id

    ContentAlpha.changeset(content_alpha, attrs, scope)
  end

  alias Shop.Content.ContentBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any content_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %ContentBravo{}}
    * {:updated, %ContentBravo{}}
    * {:deleted, %ContentBravo{}}

  """
  def subscribe_content_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:content_bravos")
  end

  defp broadcast_content_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:content_bravos", message)
  end

  @doc """
  Returns the list of content_bravos.

  ## Examples

      iex> list_content_bravos(scope)
      [%ContentBravo{}, ...]

  """
  def list_content_bravos(%Scope{} = scope) do
    Repo.all_by(ContentBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single content_bravo.

  Raises `Ecto.NoResultsError` if the Content bravo does not exist.

  ## Examples

      iex> get_content_bravo!(scope, 123)
      %ContentBravo{}

      iex> get_content_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_content_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(ContentBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a content_bravo.

  ## Examples

      iex> create_content_bravo(scope, %{field: value})
      {:ok, %ContentBravo{}}

      iex> create_content_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_bravo(%Scope{} = scope, attrs) do
    with {:ok, content_bravo = %ContentBravo{}} <-
           %ContentBravo{}
           |> ContentBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_content_bravo(scope, {:created, content_bravo})
      {:ok, content_bravo}
    end
  end

  @doc """
  Updates a content_bravo.

  ## Examples

      iex> update_content_bravo(scope, content_bravo, %{field: new_value})
      {:ok, %ContentBravo{}}

      iex> update_content_bravo(scope, content_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_bravo(%Scope{} = scope, %ContentBravo{} = content_bravo, attrs) do
    true = content_bravo.user_id == scope.user.id

    with {:ok, content_bravo = %ContentBravo{}} <-
           content_bravo
           |> ContentBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_content_bravo(scope, {:updated, content_bravo})
      {:ok, content_bravo}
    end
  end

  @doc """
  Deletes a content_bravo.

  ## Examples

      iex> delete_content_bravo(scope, content_bravo)
      {:ok, %ContentBravo{}}

      iex> delete_content_bravo(scope, content_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_bravo(%Scope{} = scope, %ContentBravo{} = content_bravo) do
    true = content_bravo.user_id == scope.user.id

    with {:ok, content_bravo = %ContentBravo{}} <-
           Repo.delete(content_bravo) do
      broadcast_content_bravo(scope, {:deleted, content_bravo})
      {:ok, content_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_bravo changes.

  ## Examples

      iex> change_content_bravo(scope, content_bravo)
      %Ecto.Changeset{data: %ContentBravo{}}

  """
  def change_content_bravo(%Scope{} = scope, %ContentBravo{} = content_bravo, attrs \\ %{}) do
    true = content_bravo.user_id == scope.user.id

    ContentBravo.changeset(content_bravo, attrs, scope)
  end

  alias Shop.Content.ContentCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any content_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %ContentCharlie{}}
    * {:updated, %ContentCharlie{}}
    * {:deleted, %ContentCharlie{}}

  """
  def subscribe_content_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:content_charlies")
  end

  defp broadcast_content_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:content_charlies", message)
  end

  @doc """
  Returns the list of content_charlies.

  ## Examples

      iex> list_content_charlies(scope)
      [%ContentCharlie{}, ...]

  """
  def list_content_charlies(%Scope{} = scope) do
    Repo.all_by(ContentCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single content_charlie.

  Raises `Ecto.NoResultsError` if the Content charlie does not exist.

  ## Examples

      iex> get_content_charlie!(scope, 123)
      %ContentCharlie{}

      iex> get_content_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_content_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(ContentCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a content_charlie.

  ## Examples

      iex> create_content_charlie(scope, %{field: value})
      {:ok, %ContentCharlie{}}

      iex> create_content_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_charlie(%Scope{} = scope, attrs) do
    with {:ok, content_charlie = %ContentCharlie{}} <-
           %ContentCharlie{}
           |> ContentCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_content_charlie(scope, {:created, content_charlie})
      {:ok, content_charlie}
    end
  end

  @doc """
  Updates a content_charlie.

  ## Examples

      iex> update_content_charlie(scope, content_charlie, %{field: new_value})
      {:ok, %ContentCharlie{}}

      iex> update_content_charlie(scope, content_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_charlie(%Scope{} = scope, %ContentCharlie{} = content_charlie, attrs) do
    true = content_charlie.user_id == scope.user.id

    with {:ok, content_charlie = %ContentCharlie{}} <-
           content_charlie
           |> ContentCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_content_charlie(scope, {:updated, content_charlie})
      {:ok, content_charlie}
    end
  end

  @doc """
  Deletes a content_charlie.

  ## Examples

      iex> delete_content_charlie(scope, content_charlie)
      {:ok, %ContentCharlie{}}

      iex> delete_content_charlie(scope, content_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_charlie(%Scope{} = scope, %ContentCharlie{} = content_charlie) do
    true = content_charlie.user_id == scope.user.id

    with {:ok, content_charlie = %ContentCharlie{}} <-
           Repo.delete(content_charlie) do
      broadcast_content_charlie(scope, {:deleted, content_charlie})
      {:ok, content_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_charlie changes.

  ## Examples

      iex> change_content_charlie(scope, content_charlie)
      %Ecto.Changeset{data: %ContentCharlie{}}

  """
  def change_content_charlie(%Scope{} = scope, %ContentCharlie{} = content_charlie, attrs \\ %{}) do
    true = content_charlie.user_id == scope.user.id

    ContentCharlie.changeset(content_charlie, attrs, scope)
  end

  alias Shop.Content.ContentDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any content_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %ContentDelta{}}
    * {:updated, %ContentDelta{}}
    * {:deleted, %ContentDelta{}}

  """
  def subscribe_content_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:content_deltas")
  end

  defp broadcast_content_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:content_deltas", message)
  end

  @doc """
  Returns the list of content_deltas.

  ## Examples

      iex> list_content_deltas(scope)
      [%ContentDelta{}, ...]

  """
  def list_content_deltas(%Scope{} = scope) do
    Repo.all_by(ContentDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single content_delta.

  Raises `Ecto.NoResultsError` if the Content delta does not exist.

  ## Examples

      iex> get_content_delta!(scope, 123)
      %ContentDelta{}

      iex> get_content_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_content_delta!(%Scope{} = scope, id) do
    Repo.get_by!(ContentDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a content_delta.

  ## Examples

      iex> create_content_delta(scope, %{field: value})
      {:ok, %ContentDelta{}}

      iex> create_content_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_delta(%Scope{} = scope, attrs) do
    with {:ok, content_delta = %ContentDelta{}} <-
           %ContentDelta{}
           |> ContentDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_content_delta(scope, {:created, content_delta})
      {:ok, content_delta}
    end
  end

  @doc """
  Updates a content_delta.

  ## Examples

      iex> update_content_delta(scope, content_delta, %{field: new_value})
      {:ok, %ContentDelta{}}

      iex> update_content_delta(scope, content_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_delta(%Scope{} = scope, %ContentDelta{} = content_delta, attrs) do
    true = content_delta.user_id == scope.user.id

    with {:ok, content_delta = %ContentDelta{}} <-
           content_delta
           |> ContentDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_content_delta(scope, {:updated, content_delta})
      {:ok, content_delta}
    end
  end

  @doc """
  Deletes a content_delta.

  ## Examples

      iex> delete_content_delta(scope, content_delta)
      {:ok, %ContentDelta{}}

      iex> delete_content_delta(scope, content_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_delta(%Scope{} = scope, %ContentDelta{} = content_delta) do
    true = content_delta.user_id == scope.user.id

    with {:ok, content_delta = %ContentDelta{}} <-
           Repo.delete(content_delta) do
      broadcast_content_delta(scope, {:deleted, content_delta})
      {:ok, content_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_delta changes.

  ## Examples

      iex> change_content_delta(scope, content_delta)
      %Ecto.Changeset{data: %ContentDelta{}}

  """
  def change_content_delta(%Scope{} = scope, %ContentDelta{} = content_delta, attrs \\ %{}) do
    true = content_delta.user_id == scope.user.id

    ContentDelta.changeset(content_delta, attrs, scope)
  end

  alias Shop.Content.ContentEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any content_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %ContentEcho{}}
    * {:updated, %ContentEcho{}}
    * {:deleted, %ContentEcho{}}

  """
  def subscribe_content_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:content_echos")
  end

  defp broadcast_content_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:content_echos", message)
  end

  @doc """
  Returns the list of content_echos.

  ## Examples

      iex> list_content_echos(scope)
      [%ContentEcho{}, ...]

  """
  def list_content_echos(%Scope{} = scope) do
    Repo.all_by(ContentEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single content_echo.

  Raises `Ecto.NoResultsError` if the Content echo does not exist.

  ## Examples

      iex> get_content_echo!(scope, 123)
      %ContentEcho{}

      iex> get_content_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_content_echo!(%Scope{} = scope, id) do
    Repo.get_by!(ContentEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a content_echo.

  ## Examples

      iex> create_content_echo(scope, %{field: value})
      {:ok, %ContentEcho{}}

      iex> create_content_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_echo(%Scope{} = scope, attrs) do
    with {:ok, content_echo = %ContentEcho{}} <-
           %ContentEcho{}
           |> ContentEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_content_echo(scope, {:created, content_echo})
      {:ok, content_echo}
    end
  end

  @doc """
  Updates a content_echo.

  ## Examples

      iex> update_content_echo(scope, content_echo, %{field: new_value})
      {:ok, %ContentEcho{}}

      iex> update_content_echo(scope, content_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_echo(%Scope{} = scope, %ContentEcho{} = content_echo, attrs) do
    true = content_echo.user_id == scope.user.id

    with {:ok, content_echo = %ContentEcho{}} <-
           content_echo
           |> ContentEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_content_echo(scope, {:updated, content_echo})
      {:ok, content_echo}
    end
  end

  @doc """
  Deletes a content_echo.

  ## Examples

      iex> delete_content_echo(scope, content_echo)
      {:ok, %ContentEcho{}}

      iex> delete_content_echo(scope, content_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_echo(%Scope{} = scope, %ContentEcho{} = content_echo) do
    true = content_echo.user_id == scope.user.id

    with {:ok, content_echo = %ContentEcho{}} <-
           Repo.delete(content_echo) do
      broadcast_content_echo(scope, {:deleted, content_echo})
      {:ok, content_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_echo changes.

  ## Examples

      iex> change_content_echo(scope, content_echo)
      %Ecto.Changeset{data: %ContentEcho{}}

  """
  def change_content_echo(%Scope{} = scope, %ContentEcho{} = content_echo, attrs \\ %{}) do
    true = content_echo.user_id == scope.user.id

    ContentEcho.changeset(content_echo, attrs, scope)
  end
end
