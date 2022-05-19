defmodule PracLiveWeb.PageLive do
    use PracLiveWeb, :live_view

    def mount(_params, _session, socket) do
        {:ok, socket |> assign(:counter, false)}
    end

    def handle_event("counter", _params, socket) do
        {:noreply, socket |> assign(:counter, true)}
    end

end