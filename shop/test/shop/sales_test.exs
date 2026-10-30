defmodule Shop.SalesTest do
  use Shop.DataCase

  alias Shop.Sales

  describe "sales_alphas" do
    alias Shop.Sales.SalesAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SalesFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_sales_alphas/1 returns all scoped sales_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)
      other_sales_alpha = sales_alpha_fixture(other_scope)
      assert Sales.list_sales_alphas(scope) == [sales_alpha]
      assert Sales.list_sales_alphas(other_scope) == [other_sales_alpha]
    end

    test "get_sales_alpha!/2 returns the sales_alpha with given id" do
      scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Sales.get_sales_alpha!(scope, sales_alpha.id) == sales_alpha

      assert_raise Ecto.NoResultsError, fn ->
        Sales.get_sales_alpha!(other_scope, sales_alpha.id)
      end
    end

    test "create_sales_alpha/2 with valid data creates a sales_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SalesAlpha{} = sales_alpha} = Sales.create_sales_alpha(scope, valid_attrs)
      assert sales_alpha.active == true
      assert sales_alpha.title == "some title"
      assert sales_alpha.body == "some body"
      assert sales_alpha.price == Decimal.new("120.5")
      assert sales_alpha.quantity == 42
      assert sales_alpha.due_on == ~D[2026-10-29]
      assert sales_alpha.user_id == scope.user.id
    end

    test "create_sales_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.create_sales_alpha(scope, @invalid_attrs)
    end

    test "update_sales_alpha/3 with valid data updates the sales_alpha" do
      scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SalesAlpha{} = sales_alpha} =
               Sales.update_sales_alpha(scope, sales_alpha, update_attrs)

      assert sales_alpha.active == false
      assert sales_alpha.title == "some updated title"
      assert sales_alpha.body == "some updated body"
      assert sales_alpha.price == Decimal.new("456.7")
      assert sales_alpha.quantity == 43
      assert sales_alpha.due_on == ~D[2026-10-30]
    end

    test "update_sales_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Sales.update_sales_alpha(other_scope, sales_alpha, %{})
      end
    end

    test "update_sales_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Sales.update_sales_alpha(scope, sales_alpha, @invalid_attrs)

      assert sales_alpha == Sales.get_sales_alpha!(scope, sales_alpha.id)
    end

    test "delete_sales_alpha/2 deletes the sales_alpha" do
      scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)
      assert {:ok, %SalesAlpha{}} = Sales.delete_sales_alpha(scope, sales_alpha)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_sales_alpha!(scope, sales_alpha.id) end
    end

    test "delete_sales_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)
      assert_raise MatchError, fn -> Sales.delete_sales_alpha(other_scope, sales_alpha) end
    end

    test "change_sales_alpha/2 returns a sales_alpha changeset" do
      scope = user_scope_fixture()
      sales_alpha = sales_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Sales.change_sales_alpha(scope, sales_alpha)
    end
  end

  describe "sales_bravos" do
    alias Shop.Sales.SalesBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SalesFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_sales_bravos/1 returns all scoped sales_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)
      other_sales_bravo = sales_bravo_fixture(other_scope)
      assert Sales.list_sales_bravos(scope) == [sales_bravo]
      assert Sales.list_sales_bravos(other_scope) == [other_sales_bravo]
    end

    test "get_sales_bravo!/2 returns the sales_bravo with given id" do
      scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Sales.get_sales_bravo!(scope, sales_bravo.id) == sales_bravo

      assert_raise Ecto.NoResultsError, fn ->
        Sales.get_sales_bravo!(other_scope, sales_bravo.id)
      end
    end

    test "create_sales_bravo/2 with valid data creates a sales_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SalesBravo{} = sales_bravo} = Sales.create_sales_bravo(scope, valid_attrs)
      assert sales_bravo.active == true
      assert sales_bravo.title == "some title"
      assert sales_bravo.body == "some body"
      assert sales_bravo.price == Decimal.new("120.5")
      assert sales_bravo.quantity == 42
      assert sales_bravo.due_on == ~D[2026-10-29]
      assert sales_bravo.user_id == scope.user.id
    end

    test "create_sales_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.create_sales_bravo(scope, @invalid_attrs)
    end

    test "update_sales_bravo/3 with valid data updates the sales_bravo" do
      scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SalesBravo{} = sales_bravo} =
               Sales.update_sales_bravo(scope, sales_bravo, update_attrs)

      assert sales_bravo.active == false
      assert sales_bravo.title == "some updated title"
      assert sales_bravo.body == "some updated body"
      assert sales_bravo.price == Decimal.new("456.7")
      assert sales_bravo.quantity == 43
      assert sales_bravo.due_on == ~D[2026-10-30]
    end

    test "update_sales_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Sales.update_sales_bravo(other_scope, sales_bravo, %{})
      end
    end

    test "update_sales_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Sales.update_sales_bravo(scope, sales_bravo, @invalid_attrs)

      assert sales_bravo == Sales.get_sales_bravo!(scope, sales_bravo.id)
    end

    test "delete_sales_bravo/2 deletes the sales_bravo" do
      scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)
      assert {:ok, %SalesBravo{}} = Sales.delete_sales_bravo(scope, sales_bravo)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_sales_bravo!(scope, sales_bravo.id) end
    end

    test "delete_sales_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)
      assert_raise MatchError, fn -> Sales.delete_sales_bravo(other_scope, sales_bravo) end
    end

    test "change_sales_bravo/2 returns a sales_bravo changeset" do
      scope = user_scope_fixture()
      sales_bravo = sales_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Sales.change_sales_bravo(scope, sales_bravo)
    end
  end

  describe "sales_charlies" do
    alias Shop.Sales.SalesCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SalesFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_sales_charlies/1 returns all scoped sales_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)
      other_sales_charlie = sales_charlie_fixture(other_scope)
      assert Sales.list_sales_charlies(scope) == [sales_charlie]
      assert Sales.list_sales_charlies(other_scope) == [other_sales_charlie]
    end

    test "get_sales_charlie!/2 returns the sales_charlie with given id" do
      scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Sales.get_sales_charlie!(scope, sales_charlie.id) == sales_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Sales.get_sales_charlie!(other_scope, sales_charlie.id)
      end
    end

    test "create_sales_charlie/2 with valid data creates a sales_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SalesCharlie{} = sales_charlie} =
               Sales.create_sales_charlie(scope, valid_attrs)

      assert sales_charlie.active == true
      assert sales_charlie.title == "some title"
      assert sales_charlie.body == "some body"
      assert sales_charlie.price == Decimal.new("120.5")
      assert sales_charlie.quantity == 42
      assert sales_charlie.due_on == ~D[2026-10-29]
      assert sales_charlie.user_id == scope.user.id
    end

    test "create_sales_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.create_sales_charlie(scope, @invalid_attrs)
    end

    test "update_sales_charlie/3 with valid data updates the sales_charlie" do
      scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SalesCharlie{} = sales_charlie} =
               Sales.update_sales_charlie(scope, sales_charlie, update_attrs)

      assert sales_charlie.active == false
      assert sales_charlie.title == "some updated title"
      assert sales_charlie.body == "some updated body"
      assert sales_charlie.price == Decimal.new("456.7")
      assert sales_charlie.quantity == 43
      assert sales_charlie.due_on == ~D[2026-10-30]
    end

    test "update_sales_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Sales.update_sales_charlie(other_scope, sales_charlie, %{})
      end
    end

    test "update_sales_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Sales.update_sales_charlie(scope, sales_charlie, @invalid_attrs)

      assert sales_charlie == Sales.get_sales_charlie!(scope, sales_charlie.id)
    end

    test "delete_sales_charlie/2 deletes the sales_charlie" do
      scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)
      assert {:ok, %SalesCharlie{}} = Sales.delete_sales_charlie(scope, sales_charlie)

      assert_raise Ecto.NoResultsError, fn ->
        Sales.get_sales_charlie!(scope, sales_charlie.id)
      end
    end

    test "delete_sales_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)
      assert_raise MatchError, fn -> Sales.delete_sales_charlie(other_scope, sales_charlie) end
    end

    test "change_sales_charlie/2 returns a sales_charlie changeset" do
      scope = user_scope_fixture()
      sales_charlie = sales_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Sales.change_sales_charlie(scope, sales_charlie)
    end
  end

  describe "sales_deltas" do
    alias Shop.Sales.SalesDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SalesFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_sales_deltas/1 returns all scoped sales_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)
      other_sales_delta = sales_delta_fixture(other_scope)
      assert Sales.list_sales_deltas(scope) == [sales_delta]
      assert Sales.list_sales_deltas(other_scope) == [other_sales_delta]
    end

    test "get_sales_delta!/2 returns the sales_delta with given id" do
      scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Sales.get_sales_delta!(scope, sales_delta.id) == sales_delta

      assert_raise Ecto.NoResultsError, fn ->
        Sales.get_sales_delta!(other_scope, sales_delta.id)
      end
    end

    test "create_sales_delta/2 with valid data creates a sales_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SalesDelta{} = sales_delta} = Sales.create_sales_delta(scope, valid_attrs)
      assert sales_delta.active == true
      assert sales_delta.title == "some title"
      assert sales_delta.body == "some body"
      assert sales_delta.price == Decimal.new("120.5")
      assert sales_delta.quantity == 42
      assert sales_delta.due_on == ~D[2026-10-29]
      assert sales_delta.user_id == scope.user.id
    end

    test "create_sales_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.create_sales_delta(scope, @invalid_attrs)
    end

    test "update_sales_delta/3 with valid data updates the sales_delta" do
      scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SalesDelta{} = sales_delta} =
               Sales.update_sales_delta(scope, sales_delta, update_attrs)

      assert sales_delta.active == false
      assert sales_delta.title == "some updated title"
      assert sales_delta.body == "some updated body"
      assert sales_delta.price == Decimal.new("456.7")
      assert sales_delta.quantity == 43
      assert sales_delta.due_on == ~D[2026-10-30]
    end

    test "update_sales_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Sales.update_sales_delta(other_scope, sales_delta, %{})
      end
    end

    test "update_sales_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Sales.update_sales_delta(scope, sales_delta, @invalid_attrs)

      assert sales_delta == Sales.get_sales_delta!(scope, sales_delta.id)
    end

    test "delete_sales_delta/2 deletes the sales_delta" do
      scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)
      assert {:ok, %SalesDelta{}} = Sales.delete_sales_delta(scope, sales_delta)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_sales_delta!(scope, sales_delta.id) end
    end

    test "delete_sales_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)
      assert_raise MatchError, fn -> Sales.delete_sales_delta(other_scope, sales_delta) end
    end

    test "change_sales_delta/2 returns a sales_delta changeset" do
      scope = user_scope_fixture()
      sales_delta = sales_delta_fixture(scope)
      assert %Ecto.Changeset{} = Sales.change_sales_delta(scope, sales_delta)
    end
  end

  describe "sales_echos" do
    alias Shop.Sales.SalesEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.SalesFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_sales_echos/1 returns all scoped sales_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)
      other_sales_echo = sales_echo_fixture(other_scope)
      assert Sales.list_sales_echos(scope) == [sales_echo]
      assert Sales.list_sales_echos(other_scope) == [other_sales_echo]
    end

    test "get_sales_echo!/2 returns the sales_echo with given id" do
      scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Sales.get_sales_echo!(scope, sales_echo.id) == sales_echo

      assert_raise Ecto.NoResultsError, fn ->
        Sales.get_sales_echo!(other_scope, sales_echo.id)
      end
    end

    test "create_sales_echo/2 with valid data creates a sales_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %SalesEcho{} = sales_echo} = Sales.create_sales_echo(scope, valid_attrs)
      assert sales_echo.active == true
      assert sales_echo.title == "some title"
      assert sales_echo.body == "some body"
      assert sales_echo.price == Decimal.new("120.5")
      assert sales_echo.quantity == 42
      assert sales_echo.due_on == ~D[2026-10-29]
      assert sales_echo.user_id == scope.user.id
    end

    test "create_sales_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.create_sales_echo(scope, @invalid_attrs)
    end

    test "update_sales_echo/3 with valid data updates the sales_echo" do
      scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %SalesEcho{} = sales_echo} =
               Sales.update_sales_echo(scope, sales_echo, update_attrs)

      assert sales_echo.active == false
      assert sales_echo.title == "some updated title"
      assert sales_echo.body == "some updated body"
      assert sales_echo.price == Decimal.new("456.7")
      assert sales_echo.quantity == 43
      assert sales_echo.due_on == ~D[2026-10-30]
    end

    test "update_sales_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Sales.update_sales_echo(other_scope, sales_echo, %{})
      end
    end

    test "update_sales_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Sales.update_sales_echo(scope, sales_echo, @invalid_attrs)

      assert sales_echo == Sales.get_sales_echo!(scope, sales_echo.id)
    end

    test "delete_sales_echo/2 deletes the sales_echo" do
      scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)
      assert {:ok, %SalesEcho{}} = Sales.delete_sales_echo(scope, sales_echo)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_sales_echo!(scope, sales_echo.id) end
    end

    test "delete_sales_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)
      assert_raise MatchError, fn -> Sales.delete_sales_echo(other_scope, sales_echo) end
    end

    test "change_sales_echo/2 returns a sales_echo changeset" do
      scope = user_scope_fixture()
      sales_echo = sales_echo_fixture(scope)
      assert %Ecto.Changeset{} = Sales.change_sales_echo(scope, sales_echo)
    end
  end
end
