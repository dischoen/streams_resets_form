defmodule StreamResetsForm.TestsTest do
  use StreamResetsForm.DataCase

  alias StreamResetsForm.Tests

  describe "results" do
    alias StreamResetsForm.Tests.Result

    import StreamResetsForm.TestsFixtures

    @invalid_attrs %{city: nil, name: nil}

    test "list_results/0 returns all results" do
      result = result_fixture()
      assert Tests.list_results() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = result_fixture()
      assert Tests.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      valid_attrs = %{city: "some city", name: "some name"}

      assert {:ok, %Result{} = result} = Tests.create_result(valid_attrs)
      assert result.city == "some city"
      assert result.name == "some name"
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tests.create_result(@invalid_attrs)
    end

    test "update_result/2 with valid data updates the result" do
      result = result_fixture()
      update_attrs = %{city: "some updated city", name: "some updated name"}

      assert {:ok, %Result{} = result} = Tests.update_result(result, update_attrs)
      assert result.city == "some updated city"
      assert result.name == "some updated name"
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = result_fixture()
      assert {:error, %Ecto.Changeset{}} = Tests.update_result(result, @invalid_attrs)
      assert result == Tests.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = result_fixture()
      assert {:ok, %Result{}} = Tests.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Tests.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = result_fixture()
      assert %Ecto.Changeset{} = Tests.change_result(result)
    end
  end
end
