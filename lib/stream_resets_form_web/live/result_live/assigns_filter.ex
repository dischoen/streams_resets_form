defmodule StreamResetsFormWeb.AssignsFilter do
  use StreamResetsFormWeb, :live_view

  alias StreamResetsForm.Tests

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket, :filter2, Phoenix.Component.to_form(
          %{"name" => "a", "city" => "h"}))
    |> assign(:results2, Tests.list_results())
    {:ok, socket }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Results")
    |> assign(:result, nil)
  end

  @impl true
  def handle_event("assign-filtering", filters, socket) do
    IO.inspect socket, label: :assigfilter
    %{"city" => city, "name" => name} = filters
    {:noreply,
     assign(socket, :results2, filter(filters, Tests.list_results()))
     |> assign(:filter2, Phoenix.Component.to_form(
          %{"name" => name, "city" => city}))
    }
  end

  def filter(%{"city" => city, "name" => name}, data) do
    Enum.filter(data, fn i -> String.contains?(i.name, name) end)
    |> Enum.filter(fn i -> String.contains?(i.city, city) end)
  end
  
end
