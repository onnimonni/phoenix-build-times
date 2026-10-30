defmodule Shop.ContentTest do
  use Shop.DataCase

  alias Shop.Content

  describe "content_alphas" do
    alias Shop.Content.ContentAlpha

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.ContentFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_content_alphas/1 returns all scoped content_alphas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)
      other_content_alpha = content_alpha_fixture(other_scope)
      assert Content.list_content_alphas(scope) == [content_alpha]
      assert Content.list_content_alphas(other_scope) == [other_content_alpha]
    end

    test "get_content_alpha!/2 returns the content_alpha with given id" do
      scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)
      other_scope = user_scope_fixture()
      assert Content.get_content_alpha!(scope, content_alpha.id) == content_alpha

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_alpha!(other_scope, content_alpha.id)
      end
    end

    test "create_content_alpha/2 with valid data creates a content_alpha" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %ContentAlpha{} = content_alpha} =
               Content.create_content_alpha(scope, valid_attrs)

      assert content_alpha.active == true
      assert content_alpha.title == "some title"
      assert content_alpha.body == "some body"
      assert content_alpha.price == Decimal.new("120.5")
      assert content_alpha.quantity == 42
      assert content_alpha.due_on == ~D[2026-10-29]
      assert content_alpha.user_id == scope.user.id
    end

    test "create_content_alpha/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.create_content_alpha(scope, @invalid_attrs)
    end

    test "update_content_alpha/3 with valid data updates the content_alpha" do
      scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %ContentAlpha{} = content_alpha} =
               Content.update_content_alpha(scope, content_alpha, update_attrs)

      assert content_alpha.active == false
      assert content_alpha.title == "some updated title"
      assert content_alpha.body == "some updated body"
      assert content_alpha.price == Decimal.new("456.7")
      assert content_alpha.quantity == 43
      assert content_alpha.due_on == ~D[2026-10-30]
    end

    test "update_content_alpha/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)

      assert_raise MatchError, fn ->
        Content.update_content_alpha(other_scope, content_alpha, %{})
      end
    end

    test "update_content_alpha/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Content.update_content_alpha(scope, content_alpha, @invalid_attrs)

      assert content_alpha == Content.get_content_alpha!(scope, content_alpha.id)
    end

    test "delete_content_alpha/2 deletes the content_alpha" do
      scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)
      assert {:ok, %ContentAlpha{}} = Content.delete_content_alpha(scope, content_alpha)

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_alpha!(scope, content_alpha.id)
      end
    end

    test "delete_content_alpha/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)
      assert_raise MatchError, fn -> Content.delete_content_alpha(other_scope, content_alpha) end
    end

    test "change_content_alpha/2 returns a content_alpha changeset" do
      scope = user_scope_fixture()
      content_alpha = content_alpha_fixture(scope)
      assert %Ecto.Changeset{} = Content.change_content_alpha(scope, content_alpha)
    end
  end

  describe "content_bravos" do
    alias Shop.Content.ContentBravo

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.ContentFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_content_bravos/1 returns all scoped content_bravos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)
      other_content_bravo = content_bravo_fixture(other_scope)
      assert Content.list_content_bravos(scope) == [content_bravo]
      assert Content.list_content_bravos(other_scope) == [other_content_bravo]
    end

    test "get_content_bravo!/2 returns the content_bravo with given id" do
      scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Content.get_content_bravo!(scope, content_bravo.id) == content_bravo

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_bravo!(other_scope, content_bravo.id)
      end
    end

    test "create_content_bravo/2 with valid data creates a content_bravo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %ContentBravo{} = content_bravo} =
               Content.create_content_bravo(scope, valid_attrs)

      assert content_bravo.active == true
      assert content_bravo.title == "some title"
      assert content_bravo.body == "some body"
      assert content_bravo.price == Decimal.new("120.5")
      assert content_bravo.quantity == 42
      assert content_bravo.due_on == ~D[2026-10-29]
      assert content_bravo.user_id == scope.user.id
    end

    test "create_content_bravo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.create_content_bravo(scope, @invalid_attrs)
    end

    test "update_content_bravo/3 with valid data updates the content_bravo" do
      scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %ContentBravo{} = content_bravo} =
               Content.update_content_bravo(scope, content_bravo, update_attrs)

      assert content_bravo.active == false
      assert content_bravo.title == "some updated title"
      assert content_bravo.body == "some updated body"
      assert content_bravo.price == Decimal.new("456.7")
      assert content_bravo.quantity == 43
      assert content_bravo.due_on == ~D[2026-10-30]
    end

    test "update_content_bravo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)

      assert_raise MatchError, fn ->
        Content.update_content_bravo(other_scope, content_bravo, %{})
      end
    end

    test "update_content_bravo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Content.update_content_bravo(scope, content_bravo, @invalid_attrs)

      assert content_bravo == Content.get_content_bravo!(scope, content_bravo.id)
    end

    test "delete_content_bravo/2 deletes the content_bravo" do
      scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)
      assert {:ok, %ContentBravo{}} = Content.delete_content_bravo(scope, content_bravo)

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_bravo!(scope, content_bravo.id)
      end
    end

    test "delete_content_bravo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)
      assert_raise MatchError, fn -> Content.delete_content_bravo(other_scope, content_bravo) end
    end

    test "change_content_bravo/2 returns a content_bravo changeset" do
      scope = user_scope_fixture()
      content_bravo = content_bravo_fixture(scope)
      assert %Ecto.Changeset{} = Content.change_content_bravo(scope, content_bravo)
    end
  end

  describe "content_charlies" do
    alias Shop.Content.ContentCharlie

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.ContentFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_content_charlies/1 returns all scoped content_charlies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)
      other_content_charlie = content_charlie_fixture(other_scope)
      assert Content.list_content_charlies(scope) == [content_charlie]
      assert Content.list_content_charlies(other_scope) == [other_content_charlie]
    end

    test "get_content_charlie!/2 returns the content_charlie with given id" do
      scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)
      other_scope = user_scope_fixture()
      assert Content.get_content_charlie!(scope, content_charlie.id) == content_charlie

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_charlie!(other_scope, content_charlie.id)
      end
    end

    test "create_content_charlie/2 with valid data creates a content_charlie" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %ContentCharlie{} = content_charlie} =
               Content.create_content_charlie(scope, valid_attrs)

      assert content_charlie.active == true
      assert content_charlie.title == "some title"
      assert content_charlie.body == "some body"
      assert content_charlie.price == Decimal.new("120.5")
      assert content_charlie.quantity == 42
      assert content_charlie.due_on == ~D[2026-10-29]
      assert content_charlie.user_id == scope.user.id
    end

    test "create_content_charlie/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.create_content_charlie(scope, @invalid_attrs)
    end

    test "update_content_charlie/3 with valid data updates the content_charlie" do
      scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %ContentCharlie{} = content_charlie} =
               Content.update_content_charlie(scope, content_charlie, update_attrs)

      assert content_charlie.active == false
      assert content_charlie.title == "some updated title"
      assert content_charlie.body == "some updated body"
      assert content_charlie.price == Decimal.new("456.7")
      assert content_charlie.quantity == 43
      assert content_charlie.due_on == ~D[2026-10-30]
    end

    test "update_content_charlie/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Content.update_content_charlie(other_scope, content_charlie, %{})
      end
    end

    test "update_content_charlie/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Content.update_content_charlie(scope, content_charlie, @invalid_attrs)

      assert content_charlie == Content.get_content_charlie!(scope, content_charlie.id)
    end

    test "delete_content_charlie/2 deletes the content_charlie" do
      scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)
      assert {:ok, %ContentCharlie{}} = Content.delete_content_charlie(scope, content_charlie)

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_charlie!(scope, content_charlie.id)
      end
    end

    test "delete_content_charlie/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)

      assert_raise MatchError, fn ->
        Content.delete_content_charlie(other_scope, content_charlie)
      end
    end

    test "change_content_charlie/2 returns a content_charlie changeset" do
      scope = user_scope_fixture()
      content_charlie = content_charlie_fixture(scope)
      assert %Ecto.Changeset{} = Content.change_content_charlie(scope, content_charlie)
    end
  end

  describe "content_deltas" do
    alias Shop.Content.ContentDelta

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.ContentFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_content_deltas/1 returns all scoped content_deltas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)
      other_content_delta = content_delta_fixture(other_scope)
      assert Content.list_content_deltas(scope) == [content_delta]
      assert Content.list_content_deltas(other_scope) == [other_content_delta]
    end

    test "get_content_delta!/2 returns the content_delta with given id" do
      scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)
      other_scope = user_scope_fixture()
      assert Content.get_content_delta!(scope, content_delta.id) == content_delta

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_delta!(other_scope, content_delta.id)
      end
    end

    test "create_content_delta/2 with valid data creates a content_delta" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %ContentDelta{} = content_delta} =
               Content.create_content_delta(scope, valid_attrs)

      assert content_delta.active == true
      assert content_delta.title == "some title"
      assert content_delta.body == "some body"
      assert content_delta.price == Decimal.new("120.5")
      assert content_delta.quantity == 42
      assert content_delta.due_on == ~D[2026-10-29]
      assert content_delta.user_id == scope.user.id
    end

    test "create_content_delta/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.create_content_delta(scope, @invalid_attrs)
    end

    test "update_content_delta/3 with valid data updates the content_delta" do
      scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %ContentDelta{} = content_delta} =
               Content.update_content_delta(scope, content_delta, update_attrs)

      assert content_delta.active == false
      assert content_delta.title == "some updated title"
      assert content_delta.body == "some updated body"
      assert content_delta.price == Decimal.new("456.7")
      assert content_delta.quantity == 43
      assert content_delta.due_on == ~D[2026-10-30]
    end

    test "update_content_delta/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)

      assert_raise MatchError, fn ->
        Content.update_content_delta(other_scope, content_delta, %{})
      end
    end

    test "update_content_delta/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Content.update_content_delta(scope, content_delta, @invalid_attrs)

      assert content_delta == Content.get_content_delta!(scope, content_delta.id)
    end

    test "delete_content_delta/2 deletes the content_delta" do
      scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)
      assert {:ok, %ContentDelta{}} = Content.delete_content_delta(scope, content_delta)

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_delta!(scope, content_delta.id)
      end
    end

    test "delete_content_delta/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)
      assert_raise MatchError, fn -> Content.delete_content_delta(other_scope, content_delta) end
    end

    test "change_content_delta/2 returns a content_delta changeset" do
      scope = user_scope_fixture()
      content_delta = content_delta_fixture(scope)
      assert %Ecto.Changeset{} = Content.change_content_delta(scope, content_delta)
    end
  end

  describe "content_echos" do
    alias Shop.Content.ContentEcho

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.ContentFixtures

    @invalid_attrs %{active: nil, title: nil, body: nil, price: nil, quantity: nil, due_on: nil}

    test "list_content_echos/1 returns all scoped content_echos" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)
      other_content_echo = content_echo_fixture(other_scope)
      assert Content.list_content_echos(scope) == [content_echo]
      assert Content.list_content_echos(other_scope) == [other_content_echo]
    end

    test "get_content_echo!/2 returns the content_echo with given id" do
      scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)
      other_scope = user_scope_fixture()
      assert Content.get_content_echo!(scope, content_echo.id) == content_echo

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_echo!(other_scope, content_echo.id)
      end
    end

    test "create_content_echo/2 with valid data creates a content_echo" do
      valid_attrs = %{
        active: true,
        title: "some title",
        body: "some body",
        price: "120.5",
        quantity: 42,
        due_on: ~D[2026-10-29]
      }

      scope = user_scope_fixture()

      assert {:ok, %ContentEcho{} = content_echo} =
               Content.create_content_echo(scope, valid_attrs)

      assert content_echo.active == true
      assert content_echo.title == "some title"
      assert content_echo.body == "some body"
      assert content_echo.price == Decimal.new("120.5")
      assert content_echo.quantity == 42
      assert content_echo.due_on == ~D[2026-10-29]
      assert content_echo.user_id == scope.user.id
    end

    test "create_content_echo/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.create_content_echo(scope, @invalid_attrs)
    end

    test "update_content_echo/3 with valid data updates the content_echo" do
      scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)

      update_attrs = %{
        active: false,
        title: "some updated title",
        body: "some updated body",
        price: "456.7",
        quantity: 43,
        due_on: ~D[2026-10-30]
      }

      assert {:ok, %ContentEcho{} = content_echo} =
               Content.update_content_echo(scope, content_echo, update_attrs)

      assert content_echo.active == false
      assert content_echo.title == "some updated title"
      assert content_echo.body == "some updated body"
      assert content_echo.price == Decimal.new("456.7")
      assert content_echo.quantity == 43
      assert content_echo.due_on == ~D[2026-10-30]
    end

    test "update_content_echo/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)

      assert_raise MatchError, fn ->
        Content.update_content_echo(other_scope, content_echo, %{})
      end
    end

    test "update_content_echo/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Content.update_content_echo(scope, content_echo, @invalid_attrs)

      assert content_echo == Content.get_content_echo!(scope, content_echo.id)
    end

    test "delete_content_echo/2 deletes the content_echo" do
      scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)
      assert {:ok, %ContentEcho{}} = Content.delete_content_echo(scope, content_echo)

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_content_echo!(scope, content_echo.id)
      end
    end

    test "delete_content_echo/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)
      assert_raise MatchError, fn -> Content.delete_content_echo(other_scope, content_echo) end
    end

    test "change_content_echo/2 returns a content_echo changeset" do
      scope = user_scope_fixture()
      content_echo = content_echo_fixture(scope)
      assert %Ecto.Changeset{} = Content.change_content_echo(scope, content_echo)
    end
  end
end
