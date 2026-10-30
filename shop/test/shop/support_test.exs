defmodule Shop.SupportTest do
  use Shop.DataCase

  alias Shop.Support

  describe "support_alphas" do
    alias Shop.Support.SupportAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SupportFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_support_alphas/1 returns all scoped support_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)
      other_support_alpha = support_alpha_fixture(other_scope)
      assert Support.list_support_alphas(scope) == [support_alpha]
      assert Support.list_support_alphas(other_scope) == [other_support_alpha]
    end

    test "get_support_alpha!/2 returns the support_alpha with given id" do
      scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Support.get_support_alpha!(scope, support_alpha.id) == support_alpha

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_alpha!(other_scope, support_alpha.id)
      end
    end

    test "create_support_alpha/2 with valid data creates a support_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SupportAlpha{} = support_alpha} =
               Support.create_support_alpha(scope, valid_attrs)

      assert support_alpha.active == true
      assert support_alpha.title == "some title"
      assert support_alpha.body == "some body"
      assert support_alpha.price == Decimal.new("120.5")
      assert support_alpha.quantity == 42
      assert support_alpha.due_on == ~D[2026-10-29]
      assert support_alpha.user_id == scope.user.id
    end

    test "create_support_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.create_support_alpha(scope, @invalid_attrs)
    end

    test "update_support_alpha/3 with valid data updates the support_alpha" do
      scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SupportAlpha{} = support_alpha} =
               Support.update_support_alpha(scope, support_alpha, update_attrs)

      assert support_alpha.active == false
      assert support_alpha.title == "some updated title"
      assert support_alpha.body == "some updated body"
      assert support_alpha.price == Decimal.new("456.7")
      assert support_alpha.quantity == 43
      assert support_alpha.due_on == ~D[2026-10-30]
    end

    test "update_support_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Support.update_support_alpha(other_scope, support_alpha, %{})
      end
    end

    test "update_support_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Support.update_support_alpha(scope, support_alpha, @invalid_attrs)

      assert support_alpha == Support.get_support_alpha!(scope, support_alpha.id)
    end

    test "delete_support_alpha/2 deletes the support_alpha" do
      scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)
      assert {:ok, %SupportAlpha{}} = Support.delete_support_alpha(scope, support_alpha)

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_alpha!(scope, support_alpha.id)
      end
    end

    test "delete_support_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)
      assert_raise MatchError, fn -> Support.delete_support_alpha(other_scope, support_alpha) end
    end

    test "change_support_alpha/2 returns a support_alpha changeset" do
      scope = user_scope_fixture()
      support_alpha = support_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Support.change_support_alpha(scope, support_alpha)
    end
  end

  describe "support_bravos" do
    alias Shop.Support.SupportBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SupportFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_support_bravos/1 returns all scoped support_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)
      other_support_bravo = support_bravo_fixture(other_scope)
      assert Support.list_support_bravos(scope) == [support_bravo]
      assert Support.list_support_bravos(other_scope) == [other_support_bravo]
    end

    test "get_support_bravo!/2 returns the support_bravo with given id" do
      scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Support.get_support_bravo!(scope, support_bravo.id) == support_bravo

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_bravo!(other_scope, support_bravo.id)
      end
    end

    test "create_support_bravo/2 with valid data creates a support_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SupportBravo{} = support_bravo} =
               Support.create_support_bravo(scope, valid_attrs)

      assert support_bravo.active == true
      assert support_bravo.title == "some title"
      assert support_bravo.body == "some body"
      assert support_bravo.price == Decimal.new("120.5")
      assert support_bravo.quantity == 42
      assert support_bravo.due_on == ~D[2026-10-29]
      assert support_bravo.user_id == scope.user.id
    end

    test "create_support_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.create_support_bravo(scope, @invalid_attrs)
    end

    test "update_support_bravo/3 with valid data updates the support_bravo" do
      scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SupportBravo{} = support_bravo} =
               Support.update_support_bravo(scope, support_bravo, update_attrs)

      assert support_bravo.active == false
      assert support_bravo.title == "some updated title"
      assert support_bravo.body == "some updated body"
      assert support_bravo.price == Decimal.new("456.7")
      assert support_bravo.quantity == 43
      assert support_bravo.due_on == ~D[2026-10-30]
    end

    test "update_support_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Support.update_support_bravo(other_scope, support_bravo, %{})
      end
    end

    test "update_support_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Support.update_support_bravo(scope, support_bravo, @invalid_attrs)

      assert support_bravo == Support.get_support_bravo!(scope, support_bravo.id)
    end

    test "delete_support_bravo/2 deletes the support_bravo" do
      scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)
      assert {:ok, %SupportBravo{}} = Support.delete_support_bravo(scope, support_bravo)

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_bravo!(scope, support_bravo.id)
      end
    end

    test "delete_support_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)
      assert_raise MatchError, fn -> Support.delete_support_bravo(other_scope, support_bravo) end
    end

    test "change_support_bravo/2 returns a support_bravo changeset" do
      scope = user_scope_fixture()
      support_bravo = support_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Support.change_support_bravo(scope, support_bravo)
    end
  end

  describe "support_charlies" do
    alias Shop.Support.SupportCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SupportFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_support_charlies/1 returns all scoped support_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)
      other_support_charlie = support_charlie_fixture(other_scope)
      assert Support.list_support_charlies(scope) == [support_charlie]
      assert Support.list_support_charlies(other_scope) == [other_support_charlie]
    end

    test "get_support_charlie!/2 returns the support_charlie with given id" do
      scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Support.get_support_charlie!(scope, support_charlie.id) == support_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_charlie!(other_scope, support_charlie.id)
      end
    end

    test "create_support_charlie/2 with valid data creates a support_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SupportCharlie{} = support_charlie} =
               Support.create_support_charlie(scope, valid_attrs)

      assert support_charlie.active == true
      assert support_charlie.title == "some title"
      assert support_charlie.body == "some body"
      assert support_charlie.price == Decimal.new("120.5")
      assert support_charlie.quantity == 42
      assert support_charlie.due_on == ~D[2026-10-29]
      assert support_charlie.user_id == scope.user.id
    end

    test "create_support_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.create_support_charlie(scope, @invalid_attrs)
    end

    test "update_support_charlie/3 with valid data updates the support_charlie" do
      scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SupportCharlie{} = support_charlie} =
               Support.update_support_charlie(scope, support_charlie, update_attrs)

      assert support_charlie.active == false
      assert support_charlie.title == "some updated title"
      assert support_charlie.body == "some updated body"
      assert support_charlie.price == Decimal.new("456.7")
      assert support_charlie.quantity == 43
      assert support_charlie.due_on == ~D[2026-10-30]
    end

    test "update_support_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Support.update_support_charlie(other_scope, support_charlie, %{})
      end
    end

    test "update_support_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Support.update_support_charlie(scope, support_charlie, @invalid_attrs)

      assert support_charlie == Support.get_support_charlie!(scope, support_charlie.id)
    end

    test "delete_support_charlie/2 deletes the support_charlie" do
      scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)
      assert {:ok, %SupportCharlie{}} = Support.delete_support_charlie(scope, support_charlie)

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_charlie!(scope, support_charlie.id)
      end
    end

    test "delete_support_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Support.delete_support_charlie(other_scope, support_charlie)
      end
    end

    test "change_support_charlie/2 returns a support_charlie changeset" do
      scope = user_scope_fixture()
      support_charlie = support_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Support.change_support_charlie(scope, support_charlie)
    end
  end

  describe "support_deltas" do
    alias Shop.Support.SupportDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SupportFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_support_deltas/1 returns all scoped support_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)
      other_support_delta = support_delta_fixture(other_scope)
      assert Support.list_support_deltas(scope) == [support_delta]
      assert Support.list_support_deltas(other_scope) == [other_support_delta]
    end

    test "get_support_delta!/2 returns the support_delta with given id" do
      scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Support.get_support_delta!(scope, support_delta.id) == support_delta

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_delta!(other_scope, support_delta.id)
      end
    end

    test "create_support_delta/2 with valid data creates a support_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SupportDelta{} = support_delta} =
               Support.create_support_delta(scope, valid_attrs)

      assert support_delta.active == true
      assert support_delta.title == "some title"
      assert support_delta.body == "some body"
      assert support_delta.price == Decimal.new("120.5")
      assert support_delta.quantity == 42
      assert support_delta.due_on == ~D[2026-10-29]
      assert support_delta.user_id == scope.user.id
    end

    test "create_support_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.create_support_delta(scope, @invalid_attrs)
    end

    test "update_support_delta/3 with valid data updates the support_delta" do
      scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SupportDelta{} = support_delta} =
               Support.update_support_delta(scope, support_delta, update_attrs)

      assert support_delta.active == false
      assert support_delta.title == "some updated title"
      assert support_delta.body == "some updated body"
      assert support_delta.price == Decimal.new("456.7")
      assert support_delta.quantity == 43
      assert support_delta.due_on == ~D[2026-10-30]
    end

    test "update_support_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Support.update_support_delta(other_scope, support_delta, %{})
      end
    end

    test "update_support_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Support.update_support_delta(scope, support_delta, @invalid_attrs)

      assert support_delta == Support.get_support_delta!(scope, support_delta.id)
    end

    test "delete_support_delta/2 deletes the support_delta" do
      scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)
      assert {:ok, %SupportDelta{}} = Support.delete_support_delta(scope, support_delta)

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_delta!(scope, support_delta.id)
      end
    end

    test "delete_support_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)
      assert_raise MatchError, fn -> Support.delete_support_delta(other_scope, support_delta) end
    end

    test "change_support_delta/2 returns a support_delta changeset" do
      scope = user_scope_fixture()
      support_delta = support_delta_fixture(scope)
      assert %Ecto.Changeset{} = Support.change_support_delta(scope, support_delta)
    end
  end

  describe "support_echos" do
    alias Shop.Support.SupportEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SupportFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_support_echos/1 returns all scoped support_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)
      other_support_echo = support_echo_fixture(other_scope)
      assert Support.list_support_echos(scope) == [support_echo]
      assert Support.list_support_echos(other_scope) == [other_support_echo]
    end

    test "get_support_echo!/2 returns the support_echo with given id" do
      scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Support.get_support_echo!(scope, support_echo.id) == support_echo

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_echo!(other_scope, support_echo.id)
      end
    end

    test "create_support_echo/2 with valid data creates a support_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SupportEcho{} = support_echo} =
               Support.create_support_echo(scope, valid_attrs)

      assert support_echo.active == true
      assert support_echo.title == "some title"
      assert support_echo.body == "some body"
      assert support_echo.price == Decimal.new("120.5")
      assert support_echo.quantity == 42
      assert support_echo.due_on == ~D[2026-10-29]
      assert support_echo.user_id == scope.user.id
    end

    test "create_support_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.create_support_echo(scope, @invalid_attrs)
    end

    test "update_support_echo/3 with valid data updates the support_echo" do
      scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SupportEcho{} = support_echo} =
               Support.update_support_echo(scope, support_echo, update_attrs)

      assert support_echo.active == false
      assert support_echo.title == "some updated title"
      assert support_echo.body == "some updated body"
      assert support_echo.price == Decimal.new("456.7")
      assert support_echo.quantity == 43
      assert support_echo.due_on == ~D[2026-10-30]
    end

    test "update_support_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Support.update_support_echo(other_scope, support_echo, %{})
      end
    end

    test "update_support_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Support.update_support_echo(scope, support_echo, @invalid_attrs)

      assert support_echo == Support.get_support_echo!(scope, support_echo.id)
    end

    test "delete_support_echo/2 deletes the support_echo" do
      scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)
      assert {:ok, %SupportEcho{}} = Support.delete_support_echo(scope, support_echo)

      assert_raise Ecto.NoResultsError, fn ->
        Support.get_support_echo!(scope, support_echo.id)
      end
    end

    test "delete_support_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)
      assert_raise MatchError, fn -> Support.delete_support_echo(other_scope, support_echo) end
    end

    test "change_support_echo/2 returns a support_echo changeset" do
      scope = user_scope_fixture()
      support_echo = support_echo_fixture(scope)
      assert %Ecto.Changeset{} = Support.change_support_echo(scope, support_echo)
    end
  end
end
