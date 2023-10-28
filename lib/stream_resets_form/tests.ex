defmodule StreamResetsForm.Tests do
  @moduledoc """
  The Tests context.
  """

  alias StreamResetsForm.Tests.Result

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%Result{}, ...]

  """
  def list_results do
    [
      %{id: 0, name: "alpha", city: "here"},
      %{id: 1, name: "beta",  city: "there"},
      %{id: 2, name: "gamma", city: "anywhere"},
      %{id: 3, name: "delta", city: "nowhere"}
    ]
  end

end
