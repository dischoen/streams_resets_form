defmodule StreamResetsFormWeb.ResultLive.Index do
  use StreamResetsFormWeb, :live_view

  alias StreamResetsForm.Tests
  alias StreamResetsForm.Tests.Result

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket, :filter1, Phoenix.Component.to_form(
            %{"name" => "", "city" => ""}))
    |> assign(:filter2, Phoenix.Component.to_form(
          %{"name" => "", "city" => ""}))
    |> assign(:results2, Tests.list_results())
    |> stream(:results1, Tests.list_results())
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
  def handle_info({StreamResetsFormWeb.ResultLive.FormComponent, {:saved, result}}, socket) do
    {:noreply, stream_insert(socket, :results1, result)}
  end

  @impl true
  def handle_event("stream-filtering", filters, socket) do
    {:noreply,
     stream(socket, :results1, filter(filters, Tests.list_results()),
       reset: true)}
  end
  def handle_event("assign-filtering", filters, socket) do
    {:noreply,
     assign(socket, :results2, filter(filters, Tests.list_results()))}
  end

  def filter(%{"city" => city, "name" => name}, data) do
    Enum.filter(data, fn i -> String.contains?(i.name, name) end)
    |> Enum.filter(fn i -> String.contains?(i.city, city) end)
  end
  
end
