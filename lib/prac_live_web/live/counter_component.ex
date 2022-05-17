defmodule PracLiveWeb.CounterComponent do
    use PracLiveWeb, :live_component

    def update(assigns, socket) do

        {:ok, socket |> assign(:val, 0)}
    end

    def handle_event("increase", _params, socket) do
        {:noreply, socket |> assign(:val, socket.assigns.val + 1)}
    end
    
    def handle_event("decrease", _params, socket) do
        {:noreply, socket |> assign(:val, socket.assigns.val - 1)}
    end
end