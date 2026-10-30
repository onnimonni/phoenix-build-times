defmodule Shop.CrmTest do
  use Shop.DataCase

  alias Shop.Crm

  describe "crm_alphas" do
    alias Shop.Crm.CrmAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CrmFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_crm_alphas/1 returns all scoped crm_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)
      other_crm_alpha = crm_alpha_fixture(other_scope)
      assert Crm.list_crm_alphas(scope) == [crm_alpha]
      assert Crm.list_crm_alphas(other_scope) == [other_crm_alpha]
    end

    test "get_crm_alpha!/2 returns the crm_alpha with given id" do
      scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Crm.get_crm_alpha!(scope, crm_alpha.id) == crm_alpha
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_alpha!(other_scope, crm_alpha.id) end
    end

    test "create_crm_alpha/2 with valid data creates a crm_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CrmAlpha{} = crm_alpha} = Crm.create_crm_alpha(scope, valid_attrs)
      assert crm_alpha.active == true
      assert crm_alpha.title == "some title"
      assert crm_alpha.body == "some body"
      assert crm_alpha.price == Decimal.new("120.5")
      assert crm_alpha.quantity == 42
      assert crm_alpha.due_on == ~D[2026-10-29]
      assert crm_alpha.user_id == scope.user.id
    end

    test "create_crm_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Crm.create_crm_alpha(scope, @invalid_attrs)
    end

    test "update_crm_alpha/3 with valid data updates the crm_alpha" do
      scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CrmAlpha{} = crm_alpha} = Crm.update_crm_alpha(scope, crm_alpha, update_attrs)
      assert crm_alpha.active == false
      assert crm_alpha.title == "some updated title"
      assert crm_alpha.body == "some updated body"
      assert crm_alpha.price == Decimal.new("456.7")
      assert crm_alpha.quantity == 43
      assert crm_alpha.due_on == ~D[2026-10-30]
    end

    test "update_crm_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Crm.update_crm_alpha(other_scope, crm_alpha, %{})
      end
    end

    test "update_crm_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Crm.update_crm_alpha(scope, crm_alpha, @invalid_attrs)
      assert crm_alpha == Crm.get_crm_alpha!(scope, crm_alpha.id)
    end

    test "delete_crm_alpha/2 deletes the crm_alpha" do
      scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)
      assert {:ok, %CrmAlpha{}} = Crm.delete_crm_alpha(scope, crm_alpha)
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_alpha!(scope, crm_alpha.id) end
    end

    test "delete_crm_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)
      assert_raise MatchError, fn -> Crm.delete_crm_alpha(other_scope, crm_alpha) end
    end

    test "change_crm_alpha/2 returns a crm_alpha changeset" do
      scope = user_scope_fixture()
      crm_alpha = crm_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Crm.change_crm_alpha(scope, crm_alpha)
    end
  end

  describe "crm_bravos" do
    alias Shop.Crm.CrmBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CrmFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_crm_bravos/1 returns all scoped crm_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)
      other_crm_bravo = crm_bravo_fixture(other_scope)
      assert Crm.list_crm_bravos(scope) == [crm_bravo]
      assert Crm.list_crm_bravos(other_scope) == [other_crm_bravo]
    end

    test "get_crm_bravo!/2 returns the crm_bravo with given id" do
      scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Crm.get_crm_bravo!(scope, crm_bravo.id) == crm_bravo
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_bravo!(other_scope, crm_bravo.id) end
    end

    test "create_crm_bravo/2 with valid data creates a crm_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CrmBravo{} = crm_bravo} = Crm.create_crm_bravo(scope, valid_attrs)
      assert crm_bravo.active == true
      assert crm_bravo.title == "some title"
      assert crm_bravo.body == "some body"
      assert crm_bravo.price == Decimal.new("120.5")
      assert crm_bravo.quantity == 42
      assert crm_bravo.due_on == ~D[2026-10-29]
      assert crm_bravo.user_id == scope.user.id
    end

    test "create_crm_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Crm.create_crm_bravo(scope, @invalid_attrs)
    end

    test "update_crm_bravo/3 with valid data updates the crm_bravo" do
      scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CrmBravo{} = crm_bravo} = Crm.update_crm_bravo(scope, crm_bravo, update_attrs)
      assert crm_bravo.active == false
      assert crm_bravo.title == "some updated title"
      assert crm_bravo.body == "some updated body"
      assert crm_bravo.price == Decimal.new("456.7")
      assert crm_bravo.quantity == 43
      assert crm_bravo.due_on == ~D[2026-10-30]
    end

    test "update_crm_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Crm.update_crm_bravo(other_scope, crm_bravo, %{})
      end
    end

    test "update_crm_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Crm.update_crm_bravo(scope, crm_bravo, @invalid_attrs)
      assert crm_bravo == Crm.get_crm_bravo!(scope, crm_bravo.id)
    end

    test "delete_crm_bravo/2 deletes the crm_bravo" do
      scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)
      assert {:ok, %CrmBravo{}} = Crm.delete_crm_bravo(scope, crm_bravo)
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_bravo!(scope, crm_bravo.id) end
    end

    test "delete_crm_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)
      assert_raise MatchError, fn -> Crm.delete_crm_bravo(other_scope, crm_bravo) end
    end

    test "change_crm_bravo/2 returns a crm_bravo changeset" do
      scope = user_scope_fixture()
      crm_bravo = crm_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Crm.change_crm_bravo(scope, crm_bravo)
    end
  end

  describe "crm_charlies" do
    alias Shop.Crm.CrmCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CrmFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_crm_charlies/1 returns all scoped crm_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)
      other_crm_charlie = crm_charlie_fixture(other_scope)
      assert Crm.list_crm_charlies(scope) == [crm_charlie]
      assert Crm.list_crm_charlies(other_scope) == [other_crm_charlie]
    end

    test "get_crm_charlie!/2 returns the crm_charlie with given id" do
      scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Crm.get_crm_charlie!(scope, crm_charlie.id) == crm_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Crm.get_crm_charlie!(other_scope, crm_charlie.id)
      end
    end

    test "create_crm_charlie/2 with valid data creates a crm_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CrmCharlie{} = crm_charlie} = Crm.create_crm_charlie(scope, valid_attrs)
      assert crm_charlie.active == true
      assert crm_charlie.title == "some title"
      assert crm_charlie.body == "some body"
      assert crm_charlie.price == Decimal.new("120.5")
      assert crm_charlie.quantity == 42
      assert crm_charlie.due_on == ~D[2026-10-29]
      assert crm_charlie.user_id == scope.user.id
    end

    test "create_crm_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Crm.create_crm_charlie(scope, @invalid_attrs)
    end

    test "update_crm_charlie/3 with valid data updates the crm_charlie" do
      scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CrmCharlie{} = crm_charlie} =
               Crm.update_crm_charlie(scope, crm_charlie, update_attrs)

      assert crm_charlie.active == false
      assert crm_charlie.title == "some updated title"
      assert crm_charlie.body == "some updated body"
      assert crm_charlie.price == Decimal.new("456.7")
      assert crm_charlie.quantity == 43
      assert crm_charlie.due_on == ~D[2026-10-30]
    end

    test "update_crm_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Crm.update_crm_charlie(other_scope, crm_charlie, %{})
      end
    end

    test "update_crm_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Crm.update_crm_charlie(scope, crm_charlie, @invalid_attrs)

      assert crm_charlie == Crm.get_crm_charlie!(scope, crm_charlie.id)
    end

    test "delete_crm_charlie/2 deletes the crm_charlie" do
      scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)
      assert {:ok, %CrmCharlie{}} = Crm.delete_crm_charlie(scope, crm_charlie)
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_charlie!(scope, crm_charlie.id) end
    end

    test "delete_crm_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)
      assert_raise MatchError, fn -> Crm.delete_crm_charlie(other_scope, crm_charlie) end
    end

    test "change_crm_charlie/2 returns a crm_charlie changeset" do
      scope = user_scope_fixture()
      crm_charlie = crm_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Crm.change_crm_charlie(scope, crm_charlie)
    end
  end

  describe "crm_deltas" do
    alias Shop.Crm.CrmDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CrmFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_crm_deltas/1 returns all scoped crm_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)
      other_crm_delta = crm_delta_fixture(other_scope)
      assert Crm.list_crm_deltas(scope) == [crm_delta]
      assert Crm.list_crm_deltas(other_scope) == [other_crm_delta]
    end

    test "get_crm_delta!/2 returns the crm_delta with given id" do
      scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Crm.get_crm_delta!(scope, crm_delta.id) == crm_delta
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_delta!(other_scope, crm_delta.id) end
    end

    test "create_crm_delta/2 with valid data creates a crm_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CrmDelta{} = crm_delta} = Crm.create_crm_delta(scope, valid_attrs)
      assert crm_delta.active == true
      assert crm_delta.title == "some title"
      assert crm_delta.body == "some body"
      assert crm_delta.price == Decimal.new("120.5")
      assert crm_delta.quantity == 42
      assert crm_delta.due_on == ~D[2026-10-29]
      assert crm_delta.user_id == scope.user.id
    end

    test "create_crm_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Crm.create_crm_delta(scope, @invalid_attrs)
    end

    test "update_crm_delta/3 with valid data updates the crm_delta" do
      scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CrmDelta{} = crm_delta} = Crm.update_crm_delta(scope, crm_delta, update_attrs)
      assert crm_delta.active == false
      assert crm_delta.title == "some updated title"
      assert crm_delta.body == "some updated body"
      assert crm_delta.price == Decimal.new("456.7")
      assert crm_delta.quantity == 43
      assert crm_delta.due_on == ~D[2026-10-30]
    end

    test "update_crm_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Crm.update_crm_delta(other_scope, crm_delta, %{})
      end
    end

    test "update_crm_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Crm.update_crm_delta(scope, crm_delta, @invalid_attrs)
      assert crm_delta == Crm.get_crm_delta!(scope, crm_delta.id)
    end

    test "delete_crm_delta/2 deletes the crm_delta" do
      scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)
      assert {:ok, %CrmDelta{}} = Crm.delete_crm_delta(scope, crm_delta)
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_delta!(scope, crm_delta.id) end
    end

    test "delete_crm_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)
      assert_raise MatchError, fn -> Crm.delete_crm_delta(other_scope, crm_delta) end
    end

    test "change_crm_delta/2 returns a crm_delta changeset" do
      scope = user_scope_fixture()
      crm_delta = crm_delta_fixture(scope)
      assert %Ecto.Changeset{} = Crm.change_crm_delta(scope, crm_delta)
    end
  end

  describe "crm_echos" do
    alias Shop.Crm.CrmEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CrmFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_crm_echos/1 returns all scoped crm_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)
      other_crm_echo = crm_echo_fixture(other_scope)
      assert Crm.list_crm_echos(scope) == [crm_echo]
      assert Crm.list_crm_echos(other_scope) == [other_crm_echo]
    end

    test "get_crm_echo!/2 returns the crm_echo with given id" do
      scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Crm.get_crm_echo!(scope, crm_echo.id) == crm_echo
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_echo!(other_scope, crm_echo.id) end
    end

    test "create_crm_echo/2 with valid data creates a crm_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CrmEcho{} = crm_echo} = Crm.create_crm_echo(scope, valid_attrs)
      assert crm_echo.active == true
      assert crm_echo.title == "some title"
      assert crm_echo.body == "some body"
      assert crm_echo.price == Decimal.new("120.5")
      assert crm_echo.quantity == 42
      assert crm_echo.due_on == ~D[2026-10-29]
      assert crm_echo.user_id == scope.user.id
    end

    test "create_crm_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Crm.create_crm_echo(scope, @invalid_attrs)
    end

    test "update_crm_echo/3 with valid data updates the crm_echo" do
      scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CrmEcho{} = crm_echo} = Crm.update_crm_echo(scope, crm_echo, update_attrs)
      assert crm_echo.active == false
      assert crm_echo.title == "some updated title"
      assert crm_echo.body == "some updated body"
      assert crm_echo.price == Decimal.new("456.7")
      assert crm_echo.quantity == 43
      assert crm_echo.due_on == ~D[2026-10-30]
    end

    test "update_crm_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Crm.update_crm_echo(other_scope, crm_echo, %{})
      end
    end

    test "update_crm_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Crm.update_crm_echo(scope, crm_echo, @invalid_attrs)
      assert crm_echo == Crm.get_crm_echo!(scope, crm_echo.id)
    end

    test "delete_crm_echo/2 deletes the crm_echo" do
      scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)
      assert {:ok, %CrmEcho{}} = Crm.delete_crm_echo(scope, crm_echo)
      assert_raise Ecto.NoResultsError, fn -> Crm.get_crm_echo!(scope, crm_echo.id) end
    end

    test "delete_crm_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)
      assert_raise MatchError, fn -> Crm.delete_crm_echo(other_scope, crm_echo) end
    end

    test "change_crm_echo/2 returns a crm_echo changeset" do
      scope = user_scope_fixture()
      crm_echo = crm_echo_fixture(scope)
      assert %Ecto.Changeset{} = Crm.change_crm_echo(scope, crm_echo)
    end
  end
end
