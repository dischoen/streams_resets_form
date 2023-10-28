defmodule StreamResetsForm.TestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StreamResetsForm.Tests` context.
  """

  @doc """
  Generate a result.
  """
  def result_fixture(attrs \\ %{}) do
    {:ok, result} =
      attrs
      |> Enum.into(%{
        city: "some city",
        name: "some name"
      })
      |> StreamResetsForm.Tests.create_result()

    result
  end
end
