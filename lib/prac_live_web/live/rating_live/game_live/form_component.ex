defmodule PracLiveWeb.GameLive.FormComponent do
    use PracLiveWeb, :live_component

    alias PracLive.Accounts
    alias PracLive.Catalog


    def update(%{game: game, action: action} = assigns, socket) do
        socket =
        socket
        |> assign(assigns)

        changeset = Catalog.change_game(game)

        {:ok,
        socket
        |> assign(:changeset, changeset)}
    end


    def handle_event("validate", %{"game" => game_params}, socket) do
        changeset =
            socket.assigns.game
            |> Catalog.change_game(game_params)
            |> Map.put(:action, :validate)
    
        {:noreply, assign(socket, :changeset, changeset)}
    end
    
    def handle_event("save", %{"game" => game_params}, socket) do
        save_game(socket, socket.assigns.action, game_params)
    end
    
    defp save_game({:error, error}, socket, _, _) do
        {:noreply, put_flash(socket, :error, error)}
    end
    
    defp save_game(socket, :edit, game_params) do
        case Catalog.update_game(socket.assigns.game, game_params) do
            {:ok, _game} ->
            {:noreply,
                socket
                |> put_flash(:info, gettext("Game updated successfully"))
                |> push_redirect(to: socket.assigns.return_to)}

            {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, :changeset, changeset)}
        end
    end
    
    defp save_game(socket, :new, game_params) do
        case Catalog.create_game(game_params) do
            {:ok, _game} ->
            {:noreply,
                socket
                |> put_flash(:info, gettext("Game created successfully"))
                |> push_redirect(to: socket.assigns.return_to)}

            {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, changeset: changeset)}
        end
    end
end