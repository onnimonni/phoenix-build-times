defmodule Shop.InventoryTest do
  use Shop.DataCase

  alias Shop.Inventory

  describe "inventory_alphas" do
    alias Shop.Inventory.InventoryAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.InventoryFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_inventory_alphas/1 returns all scoped inventory_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)
      other_inventory_alpha = inventory_alpha_fixture(other_scope)
      assert Inventory.list_inventory_alphas(scope) == [inventory_alpha]
      assert Inventory.list_inventory_alphas(other_scope) == [other_inventory_alpha]
    end

    test "get_inventory_alpha!/2 returns the inventory_alpha with given id" do
      scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Inventory.get_inventory_alpha!(scope, inventory_alpha.id) == inventory_alpha

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_alpha!(other_scope, inventory_alpha.id)
      end
    end

    test "create_inventory_alpha/2 with valid data creates a inventory_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %InventoryAlpha{} = inventory_alpha} =
               Inventory.create_inventory_alpha(scope, valid_attrs)

      assert inventory_alpha.active == true
      assert inventory_alpha.title == "some title"
      assert inventory_alpha.body == "some body"
      assert inventory_alpha.price == Decimal.new("120.5")
      assert inventory_alpha.quantity == 42
      assert inventory_alpha.due_on == ~D[2026-10-29]
      assert inventory_alpha.user_id == scope.user.id
    end

    test "create_inventory_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.create_inventory_alpha(scope, @invalid_attrs)
    end

    test "update_inventory_alpha/3 with valid data updates the inventory_alpha" do
      scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %InventoryAlpha{} = inventory_alpha} =
               Inventory.update_inventory_alpha(scope, inventory_alpha, update_attrs)

      assert inventory_alpha.active == false
      assert inventory_alpha.title == "some updated title"
      assert inventory_alpha.body == "some updated body"
      assert inventory_alpha.price == Decimal.new("456.7")
      assert inventory_alpha.quantity == 43
      assert inventory_alpha.due_on == ~D[2026-10-30]
    end

    test "update_inventory_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.update_inventory_alpha(other_scope, inventory_alpha, %{})
      end
    end

    test "update_inventory_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Inventory.update_inventory_alpha(scope, inventory_alpha, @invalid_attrs)

      assert inventory_alpha == Inventory.get_inventory_alpha!(scope, inventory_alpha.id)
    end

    test "delete_inventory_alpha/2 deletes the inventory_alpha" do
      scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)
      assert {:ok, %InventoryAlpha{}} = Inventory.delete_inventory_alpha(scope, inventory_alpha)

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_alpha!(scope, inventory_alpha.id)
      end
    end

    test "delete_inventory_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.delete_inventory_alpha(other_scope, inventory_alpha)
      end
    end

    test "change_inventory_alpha/2 returns a inventory_alpha changeset" do
      scope = user_scope_fixture()
      inventory_alpha = inventory_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Inventory.change_inventory_alpha(scope, inventory_alpha)
    end
  end

  describe "inventory_bravos" do
    alias Shop.Inventory.InventoryBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.InventoryFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_inventory_bravos/1 returns all scoped inventory_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)
      other_inventory_bravo = inventory_bravo_fixture(other_scope)
      assert Inventory.list_inventory_bravos(scope) == [inventory_bravo]
      assert Inventory.list_inventory_bravos(other_scope) == [other_inventory_bravo]
    end

    test "get_inventory_bravo!/2 returns the inventory_bravo with given id" do
      scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Inventory.get_inventory_bravo!(scope, inventory_bravo.id) == inventory_bravo

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_bravo!(other_scope, inventory_bravo.id)
      end
    end

    test "create_inventory_bravo/2 with valid data creates a inventory_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %InventoryBravo{} = inventory_bravo} =
               Inventory.create_inventory_bravo(scope, valid_attrs)

      assert inventory_bravo.active == true
      assert inventory_bravo.title == "some title"
      assert inventory_bravo.body == "some body"
      assert inventory_bravo.price == Decimal.new("120.5")
      assert inventory_bravo.quantity == 42
      assert inventory_bravo.due_on == ~D[2026-10-29]
      assert inventory_bravo.user_id == scope.user.id
    end

    test "create_inventory_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.create_inventory_bravo(scope, @invalid_attrs)
    end

    test "update_inventory_bravo/3 with valid data updates the inventory_bravo" do
      scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %InventoryBravo{} = inventory_bravo} =
               Inventory.update_inventory_bravo(scope, inventory_bravo, update_attrs)

      assert inventory_bravo.active == false
      assert inventory_bravo.title == "some updated title"
      assert inventory_bravo.body == "some updated body"
      assert inventory_bravo.price == Decimal.new("456.7")
      assert inventory_bravo.quantity == 43
      assert inventory_bravo.due_on == ~D[2026-10-30]
    end

    test "update_inventory_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.update_inventory_bravo(other_scope, inventory_bravo, %{})
      end
    end

    test "update_inventory_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Inventory.update_inventory_bravo(scope, inventory_bravo, @invalid_attrs)

      assert inventory_bravo == Inventory.get_inventory_bravo!(scope, inventory_bravo.id)
    end

    test "delete_inventory_bravo/2 deletes the inventory_bravo" do
      scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)
      assert {:ok, %InventoryBravo{}} = Inventory.delete_inventory_bravo(scope, inventory_bravo)

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_bravo!(scope, inventory_bravo.id)
      end
    end

    test "delete_inventory_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.delete_inventory_bravo(other_scope, inventory_bravo)
      end
    end

    test "change_inventory_bravo/2 returns a inventory_bravo changeset" do
      scope = user_scope_fixture()
      inventory_bravo = inventory_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Inventory.change_inventory_bravo(scope, inventory_bravo)
    end
  end

  describe "inventory_charlies" do
    alias Shop.Inventory.InventoryCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.InventoryFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_inventory_charlies/1 returns all scoped inventory_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)
      other_inventory_charlie = inventory_charlie_fixture(other_scope)
      assert Inventory.list_inventory_charlies(scope) == [inventory_charlie]
      assert Inventory.list_inventory_charlies(other_scope) == [other_inventory_charlie]
    end

    test "get_inventory_charlie!/2 returns the inventory_charlie with given id" do
      scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Inventory.get_inventory_charlie!(scope, inventory_charlie.id) == inventory_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_charlie!(other_scope, inventory_charlie.id)
      end
    end

    test "create_inventory_charlie/2 with valid data creates a inventory_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %InventoryCharlie{} = inventory_charlie} =
               Inventory.create_inventory_charlie(scope, valid_attrs)

      assert inventory_charlie.active == true
      assert inventory_charlie.title == "some title"
      assert inventory_charlie.body == "some body"
      assert inventory_charlie.price == Decimal.new("120.5")
      assert inventory_charlie.quantity == 42
      assert inventory_charlie.due_on == ~D[2026-10-29]
      assert inventory_charlie.user_id == scope.user.id
    end

    test "create_inventory_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Inventory.create_inventory_charlie(scope, @invalid_attrs)
    end

    test "update_inventory_charlie/3 with valid data updates the inventory_charlie" do
      scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %InventoryCharlie{} = inventory_charlie} =
               Inventory.update_inventory_charlie(scope, inventory_charlie, update_attrs)

      assert inventory_charlie.active == false
      assert inventory_charlie.title == "some updated title"
      assert inventory_charlie.body == "some updated body"
      assert inventory_charlie.price == Decimal.new("456.7")
      assert inventory_charlie.quantity == 43
      assert inventory_charlie.due_on == ~D[2026-10-30]
    end

    test "update_inventory_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.update_inventory_charlie(other_scope, inventory_charlie, %{})
      end
    end

    test "update_inventory_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Inventory.update_inventory_charlie(scope, inventory_charlie, @invalid_attrs)

      assert inventory_charlie == Inventory.get_inventory_charlie!(scope, inventory_charlie.id)
    end

    test "delete_inventory_charlie/2 deletes the inventory_charlie" do
      scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)

      assert {:ok, %InventoryCharlie{}} =
               Inventory.delete_inventory_charlie(scope, inventory_charlie)

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_charlie!(scope, inventory_charlie.id)
      end
    end

    test "delete_inventory_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.delete_inventory_charlie(other_scope, inventory_charlie)
      end
    end

    test "change_inventory_charlie/2 returns a inventory_charlie changeset" do
      scope = user_scope_fixture()
      inventory_charlie = inventory_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Inventory.change_inventory_charlie(scope, inventory_charlie)
    end
  end

  describe "inventory_deltas" do
    alias Shop.Inventory.InventoryDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.InventoryFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_inventory_deltas/1 returns all scoped inventory_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)
      other_inventory_delta = inventory_delta_fixture(other_scope)
      assert Inventory.list_inventory_deltas(scope) == [inventory_delta]
      assert Inventory.list_inventory_deltas(other_scope) == [other_inventory_delta]
    end

    test "get_inventory_delta!/2 returns the inventory_delta with given id" do
      scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Inventory.get_inventory_delta!(scope, inventory_delta.id) == inventory_delta

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_delta!(other_scope, inventory_delta.id)
      end
    end

    test "create_inventory_delta/2 with valid data creates a inventory_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %InventoryDelta{} = inventory_delta} =
               Inventory.create_inventory_delta(scope, valid_attrs)

      assert inventory_delta.active == true
      assert inventory_delta.title == "some title"
      assert inventory_delta.body == "some body"
      assert inventory_delta.price == Decimal.new("120.5")
      assert inventory_delta.quantity == 42
      assert inventory_delta.due_on == ~D[2026-10-29]
      assert inventory_delta.user_id == scope.user.id
    end

    test "create_inventory_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.create_inventory_delta(scope, @invalid_attrs)
    end

    test "update_inventory_delta/3 with valid data updates the inventory_delta" do
      scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %InventoryDelta{} = inventory_delta} =
               Inventory.update_inventory_delta(scope, inventory_delta, update_attrs)

      assert inventory_delta.active == false
      assert inventory_delta.title == "some updated title"
      assert inventory_delta.body == "some updated body"
      assert inventory_delta.price == Decimal.new("456.7")
      assert inventory_delta.quantity == 43
      assert inventory_delta.due_on == ~D[2026-10-30]
    end

    test "update_inventory_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.update_inventory_delta(other_scope, inventory_delta, %{})
      end
    end

    test "update_inventory_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Inventory.update_inventory_delta(scope, inventory_delta, @invalid_attrs)

      assert inventory_delta == Inventory.get_inventory_delta!(scope, inventory_delta.id)
    end

    test "delete_inventory_delta/2 deletes the inventory_delta" do
      scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)
      assert {:ok, %InventoryDelta{}} = Inventory.delete_inventory_delta(scope, inventory_delta)

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_delta!(scope, inventory_delta.id)
      end
    end

    test "delete_inventory_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.delete_inventory_delta(other_scope, inventory_delta)
      end
    end

    test "change_inventory_delta/2 returns a inventory_delta changeset" do
      scope = user_scope_fixture()
      inventory_delta = inventory_delta_fixture(scope)
      assert %Ecto.Changeset{} = Inventory.change_inventory_delta(scope, inventory_delta)
    end
  end

  describe "inventory_echos" do
    alias Shop.Inventory.InventoryEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.InventoryFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_inventory_echos/1 returns all scoped inventory_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)
      other_inventory_echo = inventory_echo_fixture(other_scope)
      assert Inventory.list_inventory_echos(scope) == [inventory_echo]
      assert Inventory.list_inventory_echos(other_scope) == [other_inventory_echo]
    end

    test "get_inventory_echo!/2 returns the inventory_echo with given id" do
      scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Inventory.get_inventory_echo!(scope, inventory_echo.id) == inventory_echo

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_echo!(other_scope, inventory_echo.id)
      end
    end

    test "create_inventory_echo/2 with valid data creates a inventory_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %InventoryEcho{} = inventory_echo} =
               Inventory.create_inventory_echo(scope, valid_attrs)

      assert inventory_echo.active == true
      assert inventory_echo.title == "some title"
      assert inventory_echo.body == "some body"
      assert inventory_echo.price == Decimal.new("120.5")
      assert inventory_echo.quantity == 42
      assert inventory_echo.due_on == ~D[2026-10-29]
      assert inventory_echo.user_id == scope.user.id
    end

    test "create_inventory_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.create_inventory_echo(scope, @invalid_attrs)
    end

    test "update_inventory_echo/3 with valid data updates the inventory_echo" do
      scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %InventoryEcho{} = inventory_echo} =
               Inventory.update_inventory_echo(scope, inventory_echo, update_attrs)

      assert inventory_echo.active == false
      assert inventory_echo.title == "some updated title"
      assert inventory_echo.body == "some updated body"
      assert inventory_echo.price == Decimal.new("456.7")
      assert inventory_echo.quantity == 43
      assert inventory_echo.due_on == ~D[2026-10-30]
    end

    test "update_inventory_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.update_inventory_echo(other_scope, inventory_echo, %{})
      end
    end

    test "update_inventory_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Inventory.update_inventory_echo(scope, inventory_echo, @invalid_attrs)

      assert inventory_echo == Inventory.get_inventory_echo!(scope, inventory_echo.id)
    end

    test "delete_inventory_echo/2 deletes the inventory_echo" do
      scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)
      assert {:ok, %InventoryEcho{}} = Inventory.delete_inventory_echo(scope, inventory_echo)

      assert_raise Ecto.NoResultsError, fn ->
        Inventory.get_inventory_echo!(scope, inventory_echo.id)
      end
    end

    test "delete_inventory_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Inventory.delete_inventory_echo(other_scope, inventory_echo)
      end
    end

    test "change_inventory_echo/2 returns a inventory_echo changeset" do
      scope = user_scope_fixture()
      inventory_echo = inventory_echo_fixture(scope)
      assert %Ecto.Changeset{} = Inventory.change_inventory_echo(scope, inventory_echo)
    end
  end
end
