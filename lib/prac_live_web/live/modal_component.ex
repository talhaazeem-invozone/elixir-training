defmodule PracLiveWeb.ModalComponent do
    use PracLiveWeb, :live_component

    @impl true
    def render(assigns) do
        ~H"""
        <div id={@id} class="phx-modal"
        phx-capture-click="close"
        phx-window-keydown="close"
        phx-key="escape"
        phx-target={"##{@id}"}
        phx-page-loading>

        <div class="phx-modal-content">

        <%= live_patch "x", to: @return_to, class: "phx-modal-close" %>
        <%= live_component @component, @opts %>

        </div>
    </div>
    """
    end

    @impl true
    def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
    end
end
