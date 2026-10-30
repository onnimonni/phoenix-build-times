defmodule Shop.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Events.EventsAlpha
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any events_alpha changes.

  The broadcasted messages match the pattern:

    * {:created, %EventsAlpha{}}
    * {:updated, %EventsAlpha{}}
    * {:deleted, %EventsAlpha{}}

  """
  def subscribe_events_alphas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:events_alphas")
  end

  defp broadcast_events_alpha(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:events_alphas", message)
  end

  @doc """
  Returns the list of events_alphas.

  ## Examples

      iex> list_events_alphas(scope)
      [%EventsAlpha{}, ...]

  """
  def list_events_alphas(%Scope{} = scope) do
    Repo.all_by(EventsAlpha, user_id: scope.user.id)
  end

  @doc """
  Gets a single events_alpha.

  Raises `Ecto.NoResultsError` if the Events alpha does not exist.

  ## Examples

      iex> get_events_alpha!(scope, 123)
      %EventsAlpha{}

      iex> get_events_alpha!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_events_alpha!(%Scope{} = scope, id) do
    Repo.get_by!(EventsAlpha, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a events_alpha.

  ## Examples

      iex> create_events_alpha(scope, %{field: value})
      {:ok, %EventsAlpha{}}

      iex> create_events_alpha(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events_alpha(%Scope{} = scope, attrs) do
    with {:ok, events_alpha = %EventsAlpha{}} <-
           %EventsAlpha{}
           |> EventsAlpha.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_events_alpha(scope, {:created, events_alpha})
      {:ok, events_alpha}
    end
  end

  @doc """
  Updates a events_alpha.

  ## Examples

      iex> update_events_alpha(scope, events_alpha, %{field: new_value})
      {:ok, %EventsAlpha{}}

      iex> update_events_alpha(scope, events_alpha, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events_alpha(%Scope{} = scope, %EventsAlpha{} = events_alpha, attrs) do
    true = events_alpha.user_id == scope.user.id

    with {:ok, events_alpha = %EventsAlpha{}} <-
           events_alpha
           |> EventsAlpha.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_events_alpha(scope, {:updated, events_alpha})
      {:ok, events_alpha}
    end
  end

  @doc """
  Deletes a events_alpha.

  ## Examples

      iex> delete_events_alpha(scope, events_alpha)
      {:ok, %EventsAlpha{}}

      iex> delete_events_alpha(scope, events_alpha)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events_alpha(%Scope{} = scope, %EventsAlpha{} = events_alpha) do
    true = events_alpha.user_id == scope.user.id

    with {:ok, events_alpha = %EventsAlpha{}} <-
           Repo.delete(events_alpha) do
      broadcast_events_alpha(scope, {:deleted, events_alpha})
      {:ok, events_alpha}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events_alpha changes.

  ## Examples

      iex> change_events_alpha(scope, events_alpha)
      %Ecto.Changeset{data: %EventsAlpha{}}

  """
  def change_events_alpha(%Scope{} = scope, %EventsAlpha{} = events_alpha, attrs \\ %{}) do
    true = events_alpha.user_id == scope.user.id

    EventsAlpha.changeset(events_alpha, attrs, scope)
  end

  alias Shop.Events.EventsBravo
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any events_bravo changes.

  The broadcasted messages match the pattern:

    * {:created, %EventsBravo{}}
    * {:updated, %EventsBravo{}}
    * {:deleted, %EventsBravo{}}

  """
  def subscribe_events_bravos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:events_bravos")
  end

  defp broadcast_events_bravo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:events_bravos", message)
  end

  @doc """
  Returns the list of events_bravos.

  ## Examples

      iex> list_events_bravos(scope)
      [%EventsBravo{}, ...]

  """
  def list_events_bravos(%Scope{} = scope) do
    Repo.all_by(EventsBravo, user_id: scope.user.id)
  end

  @doc """
  Gets a single events_bravo.

  Raises `Ecto.NoResultsError` if the Events bravo does not exist.

  ## Examples

      iex> get_events_bravo!(scope, 123)
      %EventsBravo{}

      iex> get_events_bravo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_events_bravo!(%Scope{} = scope, id) do
    Repo.get_by!(EventsBravo, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a events_bravo.

  ## Examples

      iex> create_events_bravo(scope, %{field: value})
      {:ok, %EventsBravo{}}

      iex> create_events_bravo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events_bravo(%Scope{} = scope, attrs) do
    with {:ok, events_bravo = %EventsBravo{}} <-
           %EventsBravo{}
           |> EventsBravo.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_events_bravo(scope, {:created, events_bravo})
      {:ok, events_bravo}
    end
  end

  @doc """
  Updates a events_bravo.

  ## Examples

      iex> update_events_bravo(scope, events_bravo, %{field: new_value})
      {:ok, %EventsBravo{}}

      iex> update_events_bravo(scope, events_bravo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events_bravo(%Scope{} = scope, %EventsBravo{} = events_bravo, attrs) do
    true = events_bravo.user_id == scope.user.id

    with {:ok, events_bravo = %EventsBravo{}} <-
           events_bravo
           |> EventsBravo.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_events_bravo(scope, {:updated, events_bravo})
      {:ok, events_bravo}
    end
  end

  @doc """
  Deletes a events_bravo.

  ## Examples

      iex> delete_events_bravo(scope, events_bravo)
      {:ok, %EventsBravo{}}

      iex> delete_events_bravo(scope, events_bravo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events_bravo(%Scope{} = scope, %EventsBravo{} = events_bravo) do
    true = events_bravo.user_id == scope.user.id

    with {:ok, events_bravo = %EventsBravo{}} <-
           Repo.delete(events_bravo) do
      broadcast_events_bravo(scope, {:deleted, events_bravo})
      {:ok, events_bravo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events_bravo changes.

  ## Examples

      iex> change_events_bravo(scope, events_bravo)
      %Ecto.Changeset{data: %EventsBravo{}}

  """
  def change_events_bravo(%Scope{} = scope, %EventsBravo{} = events_bravo, attrs \\ %{}) do
    true = events_bravo.user_id == scope.user.id

    EventsBravo.changeset(events_bravo, attrs, scope)
  end

  alias Shop.Events.EventsCharlie
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any events_charlie changes.

  The broadcasted messages match the pattern:

    * {:created, %EventsCharlie{}}
    * {:updated, %EventsCharlie{}}
    * {:deleted, %EventsCharlie{}}

  """
  def subscribe_events_charlies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:events_charlies")
  end

  defp broadcast_events_charlie(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:events_charlies", message)
  end

  @doc """
  Returns the list of events_charlies.

  ## Examples

      iex> list_events_charlies(scope)
      [%EventsCharlie{}, ...]

  """
  def list_events_charlies(%Scope{} = scope) do
    Repo.all_by(EventsCharlie, user_id: scope.user.id)
  end

  @doc """
  Gets a single events_charlie.

  Raises `Ecto.NoResultsError` if the Events charlie does not exist.

  ## Examples

      iex> get_events_charlie!(scope, 123)
      %EventsCharlie{}

      iex> get_events_charlie!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_events_charlie!(%Scope{} = scope, id) do
    Repo.get_by!(EventsCharlie, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a events_charlie.

  ## Examples

      iex> create_events_charlie(scope, %{field: value})
      {:ok, %EventsCharlie{}}

      iex> create_events_charlie(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events_charlie(%Scope{} = scope, attrs) do
    with {:ok, events_charlie = %EventsCharlie{}} <-
           %EventsCharlie{}
           |> EventsCharlie.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_events_charlie(scope, {:created, events_charlie})
      {:ok, events_charlie}
    end
  end

  @doc """
  Updates a events_charlie.

  ## Examples

      iex> update_events_charlie(scope, events_charlie, %{field: new_value})
      {:ok, %EventsCharlie{}}

      iex> update_events_charlie(scope, events_charlie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events_charlie(%Scope{} = scope, %EventsCharlie{} = events_charlie, attrs) do
    true = events_charlie.user_id == scope.user.id

    with {:ok, events_charlie = %EventsCharlie{}} <-
           events_charlie
           |> EventsCharlie.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_events_charlie(scope, {:updated, events_charlie})
      {:ok, events_charlie}
    end
  end

  @doc """
  Deletes a events_charlie.

  ## Examples

      iex> delete_events_charlie(scope, events_charlie)
      {:ok, %EventsCharlie{}}

      iex> delete_events_charlie(scope, events_charlie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events_charlie(%Scope{} = scope, %EventsCharlie{} = events_charlie) do
    true = events_charlie.user_id == scope.user.id

    with {:ok, events_charlie = %EventsCharlie{}} <-
           Repo.delete(events_charlie) do
      broadcast_events_charlie(scope, {:deleted, events_charlie})
      {:ok, events_charlie}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events_charlie changes.

  ## Examples

      iex> change_events_charlie(scope, events_charlie)
      %Ecto.Changeset{data: %EventsCharlie{}}

  """
  def change_events_charlie(%Scope{} = scope, %EventsCharlie{} = events_charlie, attrs \\ %{}) do
    true = events_charlie.user_id == scope.user.id

    EventsCharlie.changeset(events_charlie, attrs, scope)
  end

  alias Shop.Events.EventsDelta
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any events_delta changes.

  The broadcasted messages match the pattern:

    * {:created, %EventsDelta{}}
    * {:updated, %EventsDelta{}}
    * {:deleted, %EventsDelta{}}

  """
  def subscribe_events_deltas(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:events_deltas")
  end

  defp broadcast_events_delta(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:events_deltas", message)
  end

  @doc """
  Returns the list of events_deltas.

  ## Examples

      iex> list_events_deltas(scope)
      [%EventsDelta{}, ...]

  """
  def list_events_deltas(%Scope{} = scope) do
    Repo.all_by(EventsDelta, user_id: scope.user.id)
  end

  @doc """
  Gets a single events_delta.

  Raises `Ecto.NoResultsError` if the Events delta does not exist.

  ## Examples

      iex> get_events_delta!(scope, 123)
      %EventsDelta{}

      iex> get_events_delta!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_events_delta!(%Scope{} = scope, id) do
    Repo.get_by!(EventsDelta, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a events_delta.

  ## Examples

      iex> create_events_delta(scope, %{field: value})
      {:ok, %EventsDelta{}}

      iex> create_events_delta(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events_delta(%Scope{} = scope, attrs) do
    with {:ok, events_delta = %EventsDelta{}} <-
           %EventsDelta{}
           |> EventsDelta.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_events_delta(scope, {:created, events_delta})
      {:ok, events_delta}
    end
  end

  @doc """
  Updates a events_delta.

  ## Examples

      iex> update_events_delta(scope, events_delta, %{field: new_value})
      {:ok, %EventsDelta{}}

      iex> update_events_delta(scope, events_delta, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events_delta(%Scope{} = scope, %EventsDelta{} = events_delta, attrs) do
    true = events_delta.user_id == scope.user.id

    with {:ok, events_delta = %EventsDelta{}} <-
           events_delta
           |> EventsDelta.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_events_delta(scope, {:updated, events_delta})
      {:ok, events_delta}
    end
  end

  @doc """
  Deletes a events_delta.

  ## Examples

      iex> delete_events_delta(scope, events_delta)
      {:ok, %EventsDelta{}}

      iex> delete_events_delta(scope, events_delta)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events_delta(%Scope{} = scope, %EventsDelta{} = events_delta) do
    true = events_delta.user_id == scope.user.id

    with {:ok, events_delta = %EventsDelta{}} <-
           Repo.delete(events_delta) do
      broadcast_events_delta(scope, {:deleted, events_delta})
      {:ok, events_delta}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events_delta changes.

  ## Examples

      iex> change_events_delta(scope, events_delta)
      %Ecto.Changeset{data: %EventsDelta{}}

  """
  def change_events_delta(%Scope{} = scope, %EventsDelta{} = events_delta, attrs \\ %{}) do
    true = events_delta.user_id == scope.user.id

    EventsDelta.changeset(events_delta, attrs, scope)
  end

  alias Shop.Events.EventsEcho
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any events_echo changes.

  The broadcasted messages match the pattern:

    * {:created, %EventsEcho{}}
    * {:updated, %EventsEcho{}}
    * {:deleted, %EventsEcho{}}

  """
  def subscribe_events_echos(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:events_echos")
  end

  defp broadcast_events_echo(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:events_echos", message)
  end

  @doc """
  Returns the list of events_echos.

  ## Examples

      iex> list_events_echos(scope)
      [%EventsEcho{}, ...]

  """
  def list_events_echos(%Scope{} = scope) do
    Repo.all_by(EventsEcho, user_id: scope.user.id)
  end

  @doc """
  Gets a single events_echo.

  Raises `Ecto.NoResultsError` if the Events echo does not exist.

  ## Examples

      iex> get_events_echo!(scope, 123)
      %EventsEcho{}

      iex> get_events_echo!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_events_echo!(%Scope{} = scope, id) do
    Repo.get_by!(EventsEcho, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a events_echo.

  ## Examples

      iex> create_events_echo(scope, %{field: value})
      {:ok, %EventsEcho{}}

      iex> create_events_echo(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events_echo(%Scope{} = scope, attrs) do
    with {:ok, events_echo = %EventsEcho{}} <-
           %EventsEcho{}
           |> EventsEcho.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_events_echo(scope, {:created, events_echo})
      {:ok, events_echo}
    end
  end

  @doc """
  Updates a events_echo.

  ## Examples

      iex> update_events_echo(scope, events_echo, %{field: new_value})
      {:ok, %EventsEcho{}}

      iex> update_events_echo(scope, events_echo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events_echo(%Scope{} = scope, %EventsEcho{} = events_echo, attrs) do
    true = events_echo.user_id == scope.user.id

    with {:ok, events_echo = %EventsEcho{}} <-
           events_echo
           |> EventsEcho.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_events_echo(scope, {:updated, events_echo})
      {:ok, events_echo}
    end
  end

  @doc """
  Deletes a events_echo.

  ## Examples

      iex> delete_events_echo(scope, events_echo)
      {:ok, %EventsEcho{}}

      iex> delete_events_echo(scope, events_echo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events_echo(%Scope{} = scope, %EventsEcho{} = events_echo) do
    true = events_echo.user_id == scope.user.id

    with {:ok, events_echo = %EventsEcho{}} <-
           Repo.delete(events_echo) do
      broadcast_events_echo(scope, {:deleted, events_echo})
      {:ok, events_echo}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events_echo changes.

  ## Examples

      iex> change_events_echo(scope, events_echo)
      %Ecto.Changeset{data: %EventsEcho{}}

  """
  def change_events_echo(%Scope{} = scope, %EventsEcho{} = events_echo, attrs \\ %{}) do
    true = events_echo.user_id == scope.user.id

    EventsEcho.changeset(events_echo, attrs, scope)
  end
end
