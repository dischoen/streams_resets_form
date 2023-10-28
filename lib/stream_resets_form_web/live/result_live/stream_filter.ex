defmodule StreamResetsFormWeb.StreamFilter do
  use StreamResetsFormWeb, :live_view

  alias StreamResetsForm.Tests

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket, :filter1, Phoenix.Component.to_form(
            %{"name" => "", "city" => ""}))
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
    %{"city" => city, "name" => name} = filters
    {:noreply,
     socket
     |> stream(:results1, filter(filters, Tests.list_results()), reset: true)
     |> assign(:filter1, Phoenix.Component.to_form(
          %{"name" => name, "city" => city}))
     
    }
  end

  def filter(%{"city" => city, "name" => name}, data) do
    IO.inspect data, label: :data
    IO.inspect {name, city}, label: :streams_filter
    Enum.filter(data, fn i -> String.contains?(i.name, name) end)
    |> Enum.filter(fn i -> String.contains?(i.city, city) end)
    |> IO.inspect(label: :post)
  end
  
end
