defmodule Shop.EventsTest do
  use Shop.DataCase

  alias Shop.Events

  describe "events_alphas" do
    alias Shop.Events.EventsAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.EventsFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_events_alphas/1 returns all scoped events_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)
      other_events_alpha = events_alpha_fixture(other_scope)
      assert Events.list_events_alphas(scope) == [events_alpha]
      assert Events.list_events_alphas(other_scope) == [other_events_alpha]
    end

    test "get_events_alpha!/2 returns the events_alpha with given id" do
      scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Events.get_events_alpha!(scope, events_alpha.id) == events_alpha

      assert_raise Ecto.NoResultsError, fn ->
        Events.get_events_alpha!(other_scope, events_alpha.id)
      end
    end

    test "create_events_alpha/2 with valid data creates a events_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %EventsAlpha{} = events_alpha} = Events.create_events_alpha(scope, valid_attrs)
      assert events_alpha.active == true
      assert events_alpha.title == "some title"
      assert events_alpha.body == "some body"
      assert events_alpha.price == Decimal.new("120.5")
      assert events_alpha.quantity == 42
      assert events_alpha.due_on == ~D[2026-10-29]
      assert events_alpha.user_id == scope.user.id
    end

    test "create_events_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.create_events_alpha(scope, @invalid_attrs)
    end

    test "update_events_alpha/3 with valid data updates the events_alpha" do
      scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %EventsAlpha{} = events_alpha} =
               Events.update_events_alpha(scope, events_alpha, update_attrs)

      assert events_alpha.active == false
      assert events_alpha.title == "some updated title"
      assert events_alpha.body == "some updated body"
      assert events_alpha.price == Decimal.new("456.7")
      assert events_alpha.quantity == 43
      assert events_alpha.due_on == ~D[2026-10-30]
    end

    test "update_events_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Events.update_events_alpha(other_scope, events_alpha, %{})
      end
    end

    test "update_events_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Events.update_events_alpha(scope, events_alpha, @invalid_attrs)

      assert events_alpha == Events.get_events_alpha!(scope, events_alpha.id)
    end

    test "delete_events_alpha/2 deletes the events_alpha" do
      scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)
      assert {:ok, %EventsAlpha{}} = Events.delete_events_alpha(scope, events_alpha)
      assert_raise Ecto.NoResultsError, fn -> Events.get_events_alpha!(scope, events_alpha.id) end
    end

    test "delete_events_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)
      assert_raise MatchError, fn -> Events.delete_events_alpha(other_scope, events_alpha) end
    end

    test "change_events_alpha/2 returns a events_alpha changeset" do
      scope = user_scope_fixture()
      events_alpha = events_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Events.change_events_alpha(scope, events_alpha)
    end
  end

  describe "events_bravos" do
    alias Shop.Events.EventsBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.EventsFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_events_bravos/1 returns all scoped events_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)
      other_events_bravo = events_bravo_fixture(other_scope)
      assert Events.list_events_bravos(scope) == [events_bravo]
      assert Events.list_events_bravos(other_scope) == [other_events_bravo]
    end

    test "get_events_bravo!/2 returns the events_bravo with given id" do
      scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Events.get_events_bravo!(scope, events_bravo.id) == events_bravo

      assert_raise Ecto.NoResultsError, fn ->
        Events.get_events_bravo!(other_scope, events_bravo.id)
      end
    end

    test "create_events_bravo/2 with valid data creates a events_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %EventsBravo{} = events_bravo} = Events.create_events_bravo(scope, valid_attrs)
      assert events_bravo.active == true
      assert events_bravo.title == "some title"
      assert events_bravo.body == "some body"
      assert events_bravo.price == Decimal.new("120.5")
      assert events_bravo.quantity == 42
      assert events_bravo.due_on == ~D[2026-10-29]
      assert events_bravo.user_id == scope.user.id
    end

    test "create_events_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.create_events_bravo(scope, @invalid_attrs)
    end

    test "update_events_bravo/3 with valid data updates the events_bravo" do
      scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %EventsBravo{} = events_bravo} =
               Events.update_events_bravo(scope, events_bravo, update_attrs)

      assert events_bravo.active == false
      assert events_bravo.title == "some updated title"
      assert events_bravo.body == "some updated body"
      assert events_bravo.price == Decimal.new("456.7")
      assert events_bravo.quantity == 43
      assert events_bravo.due_on == ~D[2026-10-30]
    end

    test "update_events_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Events.update_events_bravo(other_scope, events_bravo, %{})
      end
    end

    test "update_events_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Events.update_events_bravo(scope, events_bravo, @invalid_attrs)

      assert events_bravo == Events.get_events_bravo!(scope, events_bravo.id)
    end

    test "delete_events_bravo/2 deletes the events_bravo" do
      scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)
      assert {:ok, %EventsBravo{}} = Events.delete_events_bravo(scope, events_bravo)
      assert_raise Ecto.NoResultsError, fn -> Events.get_events_bravo!(scope, events_bravo.id) end
    end

    test "delete_events_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)
      assert_raise MatchError, fn -> Events.delete_events_bravo(other_scope, events_bravo) end
    end

    test "change_events_bravo/2 returns a events_bravo changeset" do
      scope = user_scope_fixture()
      events_bravo = events_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Events.change_events_bravo(scope, events_bravo)
    end
  end

  describe "events_charlies" do
    alias Shop.Events.EventsCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.EventsFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_events_charlies/1 returns all scoped events_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)
      other_events_charlie = events_charlie_fixture(other_scope)
      assert Events.list_events_charlies(scope) == [events_charlie]
      assert Events.list_events_charlies(other_scope) == [other_events_charlie]
    end

    test "get_events_charlie!/2 returns the events_charlie with given id" do
      scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Events.get_events_charlie!(scope, events_charlie.id) == events_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Events.get_events_charlie!(other_scope, events_charlie.id)
      end
    end

    test "create_events_charlie/2 with valid data creates a events_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %EventsCharlie{} = events_charlie} =
               Events.create_events_charlie(scope, valid_attrs)

      assert events_charlie.active == true
      assert events_charlie.title == "some title"
      assert events_charlie.body == "some body"
      assert events_charlie.price == Decimal.new("120.5")
      assert events_charlie.quantity == 42
      assert events_charlie.due_on == ~D[2026-10-29]
      assert events_charlie.user_id == scope.user.id
    end

    test "create_events_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.create_events_charlie(scope, @invalid_attrs)
    end

    test "update_events_charlie/3 with valid data updates the events_charlie" do
      scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %EventsCharlie{} = events_charlie} =
               Events.update_events_charlie(scope, events_charlie, update_attrs)

      assert events_charlie.active == false
      assert events_charlie.title == "some updated title"
      assert events_charlie.body == "some updated body"
      assert events_charlie.price == Decimal.new("456.7")
      assert events_charlie.quantity == 43
      assert events_charlie.due_on == ~D[2026-10-30]
    end

    test "update_events_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Events.update_events_charlie(other_scope, events_charlie, %{})
      end
    end

    test "update_events_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Events.update_events_charlie(scope, events_charlie, @invalid_attrs)

      assert events_charlie == Events.get_events_charlie!(scope, events_charlie.id)
    end

    test "delete_events_charlie/2 deletes the events_charlie" do
      scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)
      assert {:ok, %EventsCharlie{}} = Events.delete_events_charlie(scope, events_charlie)

      assert_raise Ecto.NoResultsError, fn ->
        Events.get_events_charlie!(scope, events_charlie.id)
      end
    end

    test "delete_events_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)
      assert_raise MatchError, fn -> Events.delete_events_charlie(other_scope, events_charlie) end
    end

    test "change_events_charlie/2 returns a events_charlie changeset" do
      scope = user_scope_fixture()
      events_charlie = events_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Events.change_events_charlie(scope, events_charlie)
    end
  end

  describe "events_deltas" do
    alias Shop.Events.EventsDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.EventsFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_events_deltas/1 returns all scoped events_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)
      other_events_delta = events_delta_fixture(other_scope)
      assert Events.list_events_deltas(scope) == [events_delta]
      assert Events.list_events_deltas(other_scope) == [other_events_delta]
    end

    test "get_events_delta!/2 returns the events_delta with given id" do
      scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Events.get_events_delta!(scope, events_delta.id) == events_delta

      assert_raise Ecto.NoResultsError, fn ->
        Events.get_events_delta!(other_scope, events_delta.id)
      end
    end

    test "create_events_delta/2 with valid data creates a events_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %EventsDelta{} = events_delta} = Events.create_events_delta(scope, valid_attrs)
      assert events_delta.active == true
      assert events_delta.title == "some title"
      assert events_delta.body == "some body"
      assert events_delta.price == Decimal.new("120.5")
      assert events_delta.quantity == 42
      assert events_delta.due_on == ~D[2026-10-29]
      assert events_delta.user_id == scope.user.id
    end

    test "create_events_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.create_events_delta(scope, @invalid_attrs)
    end

    test "update_events_delta/3 with valid data updates the events_delta" do
      scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %EventsDelta{} = events_delta} =
               Events.update_events_delta(scope, events_delta, update_attrs)

      assert events_delta.active == false
      assert events_delta.title == "some updated title"
      assert events_delta.body == "some updated body"
      assert events_delta.price == Decimal.new("456.7")
      assert events_delta.quantity == 43
      assert events_delta.due_on == ~D[2026-10-30]
    end

    test "update_events_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Events.update_events_delta(other_scope, events_delta, %{})
      end
    end

    test "update_events_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Events.update_events_delta(scope, events_delta, @invalid_attrs)

      assert events_delta == Events.get_events_delta!(scope, events_delta.id)
    end

    test "delete_events_delta/2 deletes the events_delta" do
      scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)
      assert {:ok, %EventsDelta{}} = Events.delete_events_delta(scope, events_delta)
      assert_raise Ecto.NoResultsError, fn -> Events.get_events_delta!(scope, events_delta.id) end
    end

    test "delete_events_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)
      assert_raise MatchError, fn -> Events.delete_events_delta(other_scope, events_delta) end
    end

    test "change_events_delta/2 returns a events_delta changeset" do
      scope = user_scope_fixture()
      events_delta = events_delta_fixture(scope)
      assert %Ecto.Changeset{} = Events.change_events_delta(scope, events_delta)
    end
  end

  describe "events_echos" do
    alias Shop.Events.EventsEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.EventsFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_events_echos/1 returns all scoped events_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)
      other_events_echo = events_echo_fixture(other_scope)
      assert Events.list_events_echos(scope) == [events_echo]
      assert Events.list_events_echos(other_scope) == [other_events_echo]
    end

    test "get_events_echo!/2 returns the events_echo with given id" do
      scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Events.get_events_echo!(scope, events_echo.id) == events_echo

      assert_raise Ecto.NoResultsError, fn ->
        Events.get_events_echo!(other_scope, events_echo.id)
      end
    end

    test "create_events_echo/2 with valid data creates a events_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %EventsEcho{} = events_echo} = Events.create_events_echo(scope, valid_attrs)
      assert events_echo.active == true
      assert events_echo.title == "some title"
      assert events_echo.body == "some body"
      assert events_echo.price == Decimal.new("120.5")
      assert events_echo.quantity == 42
      assert events_echo.due_on == ~D[2026-10-29]
      assert events_echo.user_id == scope.user.id
    end

    test "create_events_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.create_events_echo(scope, @invalid_attrs)
    end

    test "update_events_echo/3 with valid data updates the events_echo" do
      scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %EventsEcho{} = events_echo} =
               Events.update_events_echo(scope, events_echo, update_attrs)

      assert events_echo.active == false
      assert events_echo.title == "some updated title"
      assert events_echo.body == "some updated body"
      assert events_echo.price == Decimal.new("456.7")
      assert events_echo.quantity == 43
      assert events_echo.due_on == ~D[2026-10-30]
    end

    test "update_events_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Events.update_events_echo(other_scope, events_echo, %{})
      end
    end

    test "update_events_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Events.update_events_echo(scope, events_echo, @invalid_attrs)

      assert events_echo == Events.get_events_echo!(scope, events_echo.id)
    end

    test "delete_events_echo/2 deletes the events_echo" do
      scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)
      assert {:ok, %EventsEcho{}} = Events.delete_events_echo(scope, events_echo)
      assert_raise Ecto.NoResultsError, fn -> Events.get_events_echo!(scope, events_echo.id) end
    end

    test "delete_events_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)
      assert_raise MatchError, fn -> Events.delete_events_echo(other_scope, events_echo) end
    end

    test "change_events_echo/2 returns a events_echo changeset" do
      scope = user_scope_fixture()
      events_echo = events_echo_fixture(scope)
      assert %Ecto.Changeset{} = Events.change_events_echo(scope, events_echo)
    end
  end
end
