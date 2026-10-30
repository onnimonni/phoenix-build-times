defmodule Shop.BillingTest do
  use Shop.DataCase

  alias Shop.Billing

  describe "billing_alphas" do
    alias Shop.Billing.BillingAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.BillingFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_billing_alphas/1 returns all scoped billing_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)
      other_billing_alpha = billing_alpha_fixture(other_scope)
      assert Billing.list_billing_alphas(scope) == [billing_alpha]
      assert Billing.list_billing_alphas(other_scope) == [other_billing_alpha]
    end

    test "get_billing_alpha!/2 returns the billing_alpha with given id" do
      scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Billing.get_billing_alpha!(scope, billing_alpha.id) == billing_alpha

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_alpha!(other_scope, billing_alpha.id)
      end
    end

    test "create_billing_alpha/2 with valid data creates a billing_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %BillingAlpha{} = billing_alpha} =
               Billing.create_billing_alpha(scope, valid_attrs)

      assert billing_alpha.active == true
      assert billing_alpha.title == "some title"
      assert billing_alpha.body == "some body"
      assert billing_alpha.price == Decimal.new("120.5")
      assert billing_alpha.quantity == 42
      assert billing_alpha.due_on == ~D[2026-10-29]
      assert billing_alpha.user_id == scope.user.id
    end

    test "create_billing_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.create_billing_alpha(scope, @invalid_attrs)
    end

    test "update_billing_alpha/3 with valid data updates the billing_alpha" do
      scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %BillingAlpha{} = billing_alpha} =
               Billing.update_billing_alpha(scope, billing_alpha, update_attrs)

      assert billing_alpha.active == false
      assert billing_alpha.title == "some updated title"
      assert billing_alpha.body == "some updated body"
      assert billing_alpha.price == Decimal.new("456.7")
      assert billing_alpha.quantity == 43
      assert billing_alpha.due_on == ~D[2026-10-30]
    end

    test "update_billing_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Billing.update_billing_alpha(other_scope, billing_alpha, %{})
      end
    end

    test "update_billing_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Billing.update_billing_alpha(scope, billing_alpha, @invalid_attrs)

      assert billing_alpha == Billing.get_billing_alpha!(scope, billing_alpha.id)
    end

    test "delete_billing_alpha/2 deletes the billing_alpha" do
      scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)
      assert {:ok, %BillingAlpha{}} = Billing.delete_billing_alpha(scope, billing_alpha)

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_alpha!(scope, billing_alpha.id)
      end
    end

    test "delete_billing_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)
      assert_raise MatchError, fn -> Billing.delete_billing_alpha(other_scope, billing_alpha) end
    end

    test "change_billing_alpha/2 returns a billing_alpha changeset" do
      scope = user_scope_fixture()
      billing_alpha = billing_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Billing.change_billing_alpha(scope, billing_alpha)
    end
  end

  describe "billing_bravos" do
    alias Shop.Billing.BillingBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.BillingFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_billing_bravos/1 returns all scoped billing_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)
      other_billing_bravo = billing_bravo_fixture(other_scope)
      assert Billing.list_billing_bravos(scope) == [billing_bravo]
      assert Billing.list_billing_bravos(other_scope) == [other_billing_bravo]
    end

    test "get_billing_bravo!/2 returns the billing_bravo with given id" do
      scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Billing.get_billing_bravo!(scope, billing_bravo.id) == billing_bravo

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_bravo!(other_scope, billing_bravo.id)
      end
    end

    test "create_billing_bravo/2 with valid data creates a billing_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %BillingBravo{} = billing_bravo} =
               Billing.create_billing_bravo(scope, valid_attrs)

      assert billing_bravo.active == true
      assert billing_bravo.title == "some title"
      assert billing_bravo.body == "some body"
      assert billing_bravo.price == Decimal.new("120.5")
      assert billing_bravo.quantity == 42
      assert billing_bravo.due_on == ~D[2026-10-29]
      assert billing_bravo.user_id == scope.user.id
    end

    test "create_billing_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.create_billing_bravo(scope, @invalid_attrs)
    end

    test "update_billing_bravo/3 with valid data updates the billing_bravo" do
      scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %BillingBravo{} = billing_bravo} =
               Billing.update_billing_bravo(scope, billing_bravo, update_attrs)

      assert billing_bravo.active == false
      assert billing_bravo.title == "some updated title"
      assert billing_bravo.body == "some updated body"
      assert billing_bravo.price == Decimal.new("456.7")
      assert billing_bravo.quantity == 43
      assert billing_bravo.due_on == ~D[2026-10-30]
    end

    test "update_billing_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Billing.update_billing_bravo(other_scope, billing_bravo, %{})
      end
    end

    test "update_billing_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Billing.update_billing_bravo(scope, billing_bravo, @invalid_attrs)

      assert billing_bravo == Billing.get_billing_bravo!(scope, billing_bravo.id)
    end

    test "delete_billing_bravo/2 deletes the billing_bravo" do
      scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)
      assert {:ok, %BillingBravo{}} = Billing.delete_billing_bravo(scope, billing_bravo)

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_bravo!(scope, billing_bravo.id)
      end
    end

    test "delete_billing_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)
      assert_raise MatchError, fn -> Billing.delete_billing_bravo(other_scope, billing_bravo) end
    end

    test "change_billing_bravo/2 returns a billing_bravo changeset" do
      scope = user_scope_fixture()
      billing_bravo = billing_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Billing.change_billing_bravo(scope, billing_bravo)
    end
  end

  describe "billing_charlies" do
    alias Shop.Billing.BillingCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.BillingFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_billing_charlies/1 returns all scoped billing_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)
      other_billing_charlie = billing_charlie_fixture(other_scope)
      assert Billing.list_billing_charlies(scope) == [billing_charlie]
      assert Billing.list_billing_charlies(other_scope) == [other_billing_charlie]
    end

    test "get_billing_charlie!/2 returns the billing_charlie with given id" do
      scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Billing.get_billing_charlie!(scope, billing_charlie.id) == billing_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_charlie!(other_scope, billing_charlie.id)
      end
    end

    test "create_billing_charlie/2 with valid data creates a billing_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %BillingCharlie{} = billing_charlie} =
               Billing.create_billing_charlie(scope, valid_attrs)

      assert billing_charlie.active == true
      assert billing_charlie.title == "some title"
      assert billing_charlie.body == "some body"
      assert billing_charlie.price == Decimal.new("120.5")
      assert billing_charlie.quantity == 42
      assert billing_charlie.due_on == ~D[2026-10-29]
      assert billing_charlie.user_id == scope.user.id
    end

    test "create_billing_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.create_billing_charlie(scope, @invalid_attrs)
    end

    test "update_billing_charlie/3 with valid data updates the billing_charlie" do
      scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %BillingCharlie{} = billing_charlie} =
               Billing.update_billing_charlie(scope, billing_charlie, update_attrs)

      assert billing_charlie.active == false
      assert billing_charlie.title == "some updated title"
      assert billing_charlie.body == "some updated body"
      assert billing_charlie.price == Decimal.new("456.7")
      assert billing_charlie.quantity == 43
      assert billing_charlie.due_on == ~D[2026-10-30]
    end

    test "update_billing_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Billing.update_billing_charlie(other_scope, billing_charlie, %{})
      end
    end

    test "update_billing_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Billing.update_billing_charlie(scope, billing_charlie, @invalid_attrs)

      assert billing_charlie == Billing.get_billing_charlie!(scope, billing_charlie.id)
    end

    test "delete_billing_charlie/2 deletes the billing_charlie" do
      scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)
      assert {:ok, %BillingCharlie{}} = Billing.delete_billing_charlie(scope, billing_charlie)

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_charlie!(scope, billing_charlie.id)
      end
    end

    test "delete_billing_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Billing.delete_billing_charlie(other_scope, billing_charlie)
      end
    end

    test "change_billing_charlie/2 returns a billing_charlie changeset" do
      scope = user_scope_fixture()
      billing_charlie = billing_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Billing.change_billing_charlie(scope, billing_charlie)
    end
  end

  describe "billing_deltas" do
    alias Shop.Billing.BillingDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.BillingFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_billing_deltas/1 returns all scoped billing_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)
      other_billing_delta = billing_delta_fixture(other_scope)
      assert Billing.list_billing_deltas(scope) == [billing_delta]
      assert Billing.list_billing_deltas(other_scope) == [other_billing_delta]
    end

    test "get_billing_delta!/2 returns the billing_delta with given id" do
      scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Billing.get_billing_delta!(scope, billing_delta.id) == billing_delta

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_delta!(other_scope, billing_delta.id)
      end
    end

    test "create_billing_delta/2 with valid data creates a billing_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %BillingDelta{} = billing_delta} =
               Billing.create_billing_delta(scope, valid_attrs)

      assert billing_delta.active == true
      assert billing_delta.title == "some title"
      assert billing_delta.body == "some body"
      assert billing_delta.price == Decimal.new("120.5")
      assert billing_delta.quantity == 42
      assert billing_delta.due_on == ~D[2026-10-29]
      assert billing_delta.user_id == scope.user.id
    end

    test "create_billing_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.create_billing_delta(scope, @invalid_attrs)
    end

    test "update_billing_delta/3 with valid data updates the billing_delta" do
      scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %BillingDelta{} = billing_delta} =
               Billing.update_billing_delta(scope, billing_delta, update_attrs)

      assert billing_delta.active == false
      assert billing_delta.title == "some updated title"
      assert billing_delta.body == "some updated body"
      assert billing_delta.price == Decimal.new("456.7")
      assert billing_delta.quantity == 43
      assert billing_delta.due_on == ~D[2026-10-30]
    end

    test "update_billing_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Billing.update_billing_delta(other_scope, billing_delta, %{})
      end
    end

    test "update_billing_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Billing.update_billing_delta(scope, billing_delta, @invalid_attrs)

      assert billing_delta == Billing.get_billing_delta!(scope, billing_delta.id)
    end

    test "delete_billing_delta/2 deletes the billing_delta" do
      scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)
      assert {:ok, %BillingDelta{}} = Billing.delete_billing_delta(scope, billing_delta)

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_delta!(scope, billing_delta.id)
      end
    end

    test "delete_billing_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)
      assert_raise MatchError, fn -> Billing.delete_billing_delta(other_scope, billing_delta) end
    end

    test "change_billing_delta/2 returns a billing_delta changeset" do
      scope = user_scope_fixture()
      billing_delta = billing_delta_fixture(scope)
      assert %Ecto.Changeset{} = Billing.change_billing_delta(scope, billing_delta)
    end
  end

  describe "billing_echos" do
    alias Shop.Billing.BillingEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.BillingFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_billing_echos/1 returns all scoped billing_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)
      other_billing_echo = billing_echo_fixture(other_scope)
      assert Billing.list_billing_echos(scope) == [billing_echo]
      assert Billing.list_billing_echos(other_scope) == [other_billing_echo]
    end

    test "get_billing_echo!/2 returns the billing_echo with given id" do
      scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Billing.get_billing_echo!(scope, billing_echo.id) == billing_echo

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_echo!(other_scope, billing_echo.id)
      end
    end

    test "create_billing_echo/2 with valid data creates a billing_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %BillingEcho{} = billing_echo} =
               Billing.create_billing_echo(scope, valid_attrs)

      assert billing_echo.active == true
      assert billing_echo.title == "some title"
      assert billing_echo.body == "some body"
      assert billing_echo.price == Decimal.new("120.5")
      assert billing_echo.quantity == 42
      assert billing_echo.due_on == ~D[2026-10-29]
      assert billing_echo.user_id == scope.user.id
    end

    test "create_billing_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.create_billing_echo(scope, @invalid_attrs)
    end

    test "update_billing_echo/3 with valid data updates the billing_echo" do
      scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %BillingEcho{} = billing_echo} =
               Billing.update_billing_echo(scope, billing_echo, update_attrs)

      assert billing_echo.active == false
      assert billing_echo.title == "some updated title"
      assert billing_echo.body == "some updated body"
      assert billing_echo.price == Decimal.new("456.7")
      assert billing_echo.quantity == 43
      assert billing_echo.due_on == ~D[2026-10-30]
    end

    test "update_billing_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Billing.update_billing_echo(other_scope, billing_echo, %{})
      end
    end

    test "update_billing_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Billing.update_billing_echo(scope, billing_echo, @invalid_attrs)

      assert billing_echo == Billing.get_billing_echo!(scope, billing_echo.id)
    end

    test "delete_billing_echo/2 deletes the billing_echo" do
      scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)
      assert {:ok, %BillingEcho{}} = Billing.delete_billing_echo(scope, billing_echo)

      assert_raise Ecto.NoResultsError, fn ->
        Billing.get_billing_echo!(scope, billing_echo.id)
      end
    end

    test "delete_billing_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)
      assert_raise MatchError, fn -> Billing.delete_billing_echo(other_scope, billing_echo) end
    end

    test "change_billing_echo/2 returns a billing_echo changeset" do
      scope = user_scope_fixture()
      billing_echo = billing_echo_fixture(scope)
      assert %Ecto.Changeset{} = Billing.change_billing_echo(scope, billing_echo)
    end
  end
end
