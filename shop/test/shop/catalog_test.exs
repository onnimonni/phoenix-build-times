defmodule Shop.CatalogTest do
  use Shop.DataCase

  alias Shop.Catalog

  describe "catalog_alphas" do
    alias Shop.Catalog.CatalogAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CatalogFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_catalog_alphas/1 returns all scoped catalog_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)
      other_catalog_alpha = catalog_alpha_fixture(other_scope)
      assert Catalog.list_catalog_alphas(scope) == [catalog_alpha]
      assert Catalog.list_catalog_alphas(other_scope) == [other_catalog_alpha]
    end

    test "get_catalog_alpha!/2 returns the catalog_alpha with given id" do
      scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Catalog.get_catalog_alpha!(scope, catalog_alpha.id) == catalog_alpha

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_alpha!(other_scope, catalog_alpha.id)
      end
    end

    test "create_catalog_alpha/2 with valid data creates a catalog_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CatalogAlpha{} = catalog_alpha} =
               Catalog.create_catalog_alpha(scope, valid_attrs)

      assert catalog_alpha.active == true
      assert catalog_alpha.title == "some title"
      assert catalog_alpha.body == "some body"
      assert catalog_alpha.price == Decimal.new("120.5")
      assert catalog_alpha.quantity == 42
      assert catalog_alpha.due_on == ~D[2026-10-29]
      assert catalog_alpha.user_id == scope.user.id
    end

    test "create_catalog_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.create_catalog_alpha(scope, @invalid_attrs)
    end

    test "update_catalog_alpha/3 with valid data updates the catalog_alpha" do
      scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CatalogAlpha{} = catalog_alpha} =
               Catalog.update_catalog_alpha(scope, catalog_alpha, update_attrs)

      assert catalog_alpha.active == false
      assert catalog_alpha.title == "some updated title"
      assert catalog_alpha.body == "some updated body"
      assert catalog_alpha.price == Decimal.new("456.7")
      assert catalog_alpha.quantity == 43
      assert catalog_alpha.due_on == ~D[2026-10-30]
    end

    test "update_catalog_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Catalog.update_catalog_alpha(other_scope, catalog_alpha, %{})
      end
    end

    test "update_catalog_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Catalog.update_catalog_alpha(scope, catalog_alpha, @invalid_attrs)

      assert catalog_alpha == Catalog.get_catalog_alpha!(scope, catalog_alpha.id)
    end

    test "delete_catalog_alpha/2 deletes the catalog_alpha" do
      scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)
      assert {:ok, %CatalogAlpha{}} = Catalog.delete_catalog_alpha(scope, catalog_alpha)

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_alpha!(scope, catalog_alpha.id)
      end
    end

    test "delete_catalog_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)
      assert_raise MatchError, fn -> Catalog.delete_catalog_alpha(other_scope, catalog_alpha) end
    end

    test "change_catalog_alpha/2 returns a catalog_alpha changeset" do
      scope = user_scope_fixture()
      catalog_alpha = catalog_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Catalog.change_catalog_alpha(scope, catalog_alpha)
    end
  end

  describe "catalog_bravos" do
    alias Shop.Catalog.CatalogBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CatalogFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_catalog_bravos/1 returns all scoped catalog_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)
      other_catalog_bravo = catalog_bravo_fixture(other_scope)
      assert Catalog.list_catalog_bravos(scope) == [catalog_bravo]
      assert Catalog.list_catalog_bravos(other_scope) == [other_catalog_bravo]
    end

    test "get_catalog_bravo!/2 returns the catalog_bravo with given id" do
      scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Catalog.get_catalog_bravo!(scope, catalog_bravo.id) == catalog_bravo

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_bravo!(other_scope, catalog_bravo.id)
      end
    end

    test "create_catalog_bravo/2 with valid data creates a catalog_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CatalogBravo{} = catalog_bravo} =
               Catalog.create_catalog_bravo(scope, valid_attrs)

      assert catalog_bravo.active == true
      assert catalog_bravo.title == "some title"
      assert catalog_bravo.body == "some body"
      assert catalog_bravo.price == Decimal.new("120.5")
      assert catalog_bravo.quantity == 42
      assert catalog_bravo.due_on == ~D[2026-10-29]
      assert catalog_bravo.user_id == scope.user.id
    end

    test "create_catalog_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.create_catalog_bravo(scope, @invalid_attrs)
    end

    test "update_catalog_bravo/3 with valid data updates the catalog_bravo" do
      scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CatalogBravo{} = catalog_bravo} =
               Catalog.update_catalog_bravo(scope, catalog_bravo, update_attrs)

      assert catalog_bravo.active == false
      assert catalog_bravo.title == "some updated title"
      assert catalog_bravo.body == "some updated body"
      assert catalog_bravo.price == Decimal.new("456.7")
      assert catalog_bravo.quantity == 43
      assert catalog_bravo.due_on == ~D[2026-10-30]
    end

    test "update_catalog_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Catalog.update_catalog_bravo(other_scope, catalog_bravo, %{})
      end
    end

    test "update_catalog_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Catalog.update_catalog_bravo(scope, catalog_bravo, @invalid_attrs)

      assert catalog_bravo == Catalog.get_catalog_bravo!(scope, catalog_bravo.id)
    end

    test "delete_catalog_bravo/2 deletes the catalog_bravo" do
      scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)
      assert {:ok, %CatalogBravo{}} = Catalog.delete_catalog_bravo(scope, catalog_bravo)

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_bravo!(scope, catalog_bravo.id)
      end
    end

    test "delete_catalog_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)
      assert_raise MatchError, fn -> Catalog.delete_catalog_bravo(other_scope, catalog_bravo) end
    end

    test "change_catalog_bravo/2 returns a catalog_bravo changeset" do
      scope = user_scope_fixture()
      catalog_bravo = catalog_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Catalog.change_catalog_bravo(scope, catalog_bravo)
    end
  end

  describe "catalog_charlies" do
    alias Shop.Catalog.CatalogCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CatalogFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_catalog_charlies/1 returns all scoped catalog_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)
      other_catalog_charlie = catalog_charlie_fixture(other_scope)
      assert Catalog.list_catalog_charlies(scope) == [catalog_charlie]
      assert Catalog.list_catalog_charlies(other_scope) == [other_catalog_charlie]
    end

    test "get_catalog_charlie!/2 returns the catalog_charlie with given id" do
      scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Catalog.get_catalog_charlie!(scope, catalog_charlie.id) == catalog_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_charlie!(other_scope, catalog_charlie.id)
      end
    end

    test "create_catalog_charlie/2 with valid data creates a catalog_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CatalogCharlie{} = catalog_charlie} =
               Catalog.create_catalog_charlie(scope, valid_attrs)

      assert catalog_charlie.active == true
      assert catalog_charlie.title == "some title"
      assert catalog_charlie.body == "some body"
      assert catalog_charlie.price == Decimal.new("120.5")
      assert catalog_charlie.quantity == 42
      assert catalog_charlie.due_on == ~D[2026-10-29]
      assert catalog_charlie.user_id == scope.user.id
    end

    test "create_catalog_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.create_catalog_charlie(scope, @invalid_attrs)
    end

    test "update_catalog_charlie/3 with valid data updates the catalog_charlie" do
      scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CatalogCharlie{} = catalog_charlie} =
               Catalog.update_catalog_charlie(scope, catalog_charlie, update_attrs)

      assert catalog_charlie.active == false
      assert catalog_charlie.title == "some updated title"
      assert catalog_charlie.body == "some updated body"
      assert catalog_charlie.price == Decimal.new("456.7")
      assert catalog_charlie.quantity == 43
      assert catalog_charlie.due_on == ~D[2026-10-30]
    end

    test "update_catalog_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Catalog.update_catalog_charlie(other_scope, catalog_charlie, %{})
      end
    end

    test "update_catalog_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Catalog.update_catalog_charlie(scope, catalog_charlie, @invalid_attrs)

      assert catalog_charlie == Catalog.get_catalog_charlie!(scope, catalog_charlie.id)
    end

    test "delete_catalog_charlie/2 deletes the catalog_charlie" do
      scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)
      assert {:ok, %CatalogCharlie{}} = Catalog.delete_catalog_charlie(scope, catalog_charlie)

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_charlie!(scope, catalog_charlie.id)
      end
    end

    test "delete_catalog_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Catalog.delete_catalog_charlie(other_scope, catalog_charlie)
      end
    end

    test "change_catalog_charlie/2 returns a catalog_charlie changeset" do
      scope = user_scope_fixture()
      catalog_charlie = catalog_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Catalog.change_catalog_charlie(scope, catalog_charlie)
    end
  end

  describe "catalog_deltas" do
    alias Shop.Catalog.CatalogDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CatalogFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_catalog_deltas/1 returns all scoped catalog_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)
      other_catalog_delta = catalog_delta_fixture(other_scope)
      assert Catalog.list_catalog_deltas(scope) == [catalog_delta]
      assert Catalog.list_catalog_deltas(other_scope) == [other_catalog_delta]
    end

    test "get_catalog_delta!/2 returns the catalog_delta with given id" do
      scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Catalog.get_catalog_delta!(scope, catalog_delta.id) == catalog_delta

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_delta!(other_scope, catalog_delta.id)
      end
    end

    test "create_catalog_delta/2 with valid data creates a catalog_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CatalogDelta{} = catalog_delta} =
               Catalog.create_catalog_delta(scope, valid_attrs)

      assert catalog_delta.active == true
      assert catalog_delta.title == "some title"
      assert catalog_delta.body == "some body"
      assert catalog_delta.price == Decimal.new("120.5")
      assert catalog_delta.quantity == 42
      assert catalog_delta.due_on == ~D[2026-10-29]
      assert catalog_delta.user_id == scope.user.id
    end

    test "create_catalog_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.create_catalog_delta(scope, @invalid_attrs)
    end

    test "update_catalog_delta/3 with valid data updates the catalog_delta" do
      scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CatalogDelta{} = catalog_delta} =
               Catalog.update_catalog_delta(scope, catalog_delta, update_attrs)

      assert catalog_delta.active == false
      assert catalog_delta.title == "some updated title"
      assert catalog_delta.body == "some updated body"
      assert catalog_delta.price == Decimal.new("456.7")
      assert catalog_delta.quantity == 43
      assert catalog_delta.due_on == ~D[2026-10-30]
    end

    test "update_catalog_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Catalog.update_catalog_delta(other_scope, catalog_delta, %{})
      end
    end

    test "update_catalog_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Catalog.update_catalog_delta(scope, catalog_delta, @invalid_attrs)

      assert catalog_delta == Catalog.get_catalog_delta!(scope, catalog_delta.id)
    end

    test "delete_catalog_delta/2 deletes the catalog_delta" do
      scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)
      assert {:ok, %CatalogDelta{}} = Catalog.delete_catalog_delta(scope, catalog_delta)

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_delta!(scope, catalog_delta.id)
      end
    end

    test "delete_catalog_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)
      assert_raise MatchError, fn -> Catalog.delete_catalog_delta(other_scope, catalog_delta) end
    end

    test "change_catalog_delta/2 returns a catalog_delta changeset" do
      scope = user_scope_fixture()
      catalog_delta = catalog_delta_fixture(scope)
      assert %Ecto.Changeset{} = Catalog.change_catalog_delta(scope, catalog_delta)
    end
  end

  describe "catalog_echos" do
    alias Shop.Catalog.CatalogEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.CatalogFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_catalog_echos/1 returns all scoped catalog_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)
      other_catalog_echo = catalog_echo_fixture(other_scope)
      assert Catalog.list_catalog_echos(scope) == [catalog_echo]
      assert Catalog.list_catalog_echos(other_scope) == [other_catalog_echo]
    end

    test "get_catalog_echo!/2 returns the catalog_echo with given id" do
      scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Catalog.get_catalog_echo!(scope, catalog_echo.id) == catalog_echo

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_echo!(other_scope, catalog_echo.id)
      end
    end

    test "create_catalog_echo/2 with valid data creates a catalog_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %CatalogEcho{} = catalog_echo} =
               Catalog.create_catalog_echo(scope, valid_attrs)

      assert catalog_echo.active == true
      assert catalog_echo.title == "some title"
      assert catalog_echo.body == "some body"
      assert catalog_echo.price == Decimal.new("120.5")
      assert catalog_echo.quantity == 42
      assert catalog_echo.due_on == ~D[2026-10-29]
      assert catalog_echo.user_id == scope.user.id
    end

    test "create_catalog_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.create_catalog_echo(scope, @invalid_attrs)
    end

    test "update_catalog_echo/3 with valid data updates the catalog_echo" do
      scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %CatalogEcho{} = catalog_echo} =
               Catalog.update_catalog_echo(scope, catalog_echo, update_attrs)

      assert catalog_echo.active == false
      assert catalog_echo.title == "some updated title"
      assert catalog_echo.body == "some updated body"
      assert catalog_echo.price == Decimal.new("456.7")
      assert catalog_echo.quantity == 43
      assert catalog_echo.due_on == ~D[2026-10-30]
    end

    test "update_catalog_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Catalog.update_catalog_echo(other_scope, catalog_echo, %{})
      end
    end

    test "update_catalog_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Catalog.update_catalog_echo(scope, catalog_echo, @invalid_attrs)

      assert catalog_echo == Catalog.get_catalog_echo!(scope, catalog_echo.id)
    end

    test "delete_catalog_echo/2 deletes the catalog_echo" do
      scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)
      assert {:ok, %CatalogEcho{}} = Catalog.delete_catalog_echo(scope, catalog_echo)

      assert_raise Ecto.NoResultsError, fn ->
        Catalog.get_catalog_echo!(scope, catalog_echo.id)
      end
    end

    test "delete_catalog_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)
      assert_raise MatchError, fn -> Catalog.delete_catalog_echo(other_scope, catalog_echo) end
    end

    test "change_catalog_echo/2 returns a catalog_echo changeset" do
      scope = user_scope_fixture()
      catalog_echo = catalog_echo_fixture(scope)
      assert %Ecto.Changeset{} = Catalog.change_catalog_echo(scope, catalog_echo)
    end
  end
end
