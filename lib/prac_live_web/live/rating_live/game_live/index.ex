defmodule PracLiveWeb.GameLive.Index do
    use PracLiveWeb, :live_view

    alias PracLive.Accounts
    alias PracLive.Catalog
    alias PracLive.Catalog.Game

    def mount(_params, %{"user_token" => user_token}, socket) do
        user = Accounts.get_user_by_session_token(user_token)
        
        {:ok,
        socket
        |> assign(:current_user, user)
        |> assign(:games, Catalog.list_games_with_user_rating(user))}
    end

    @impl true
    def handle_params(params, _url, socket) do
        {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    end

    defp apply_action(socket, :index, params) do
        games = Catalog.list_games()

        socket
        |> assign(:games, games)
    end
    
    defp apply_action(socket, :new, params) do
        socket
        |> assign(:page_title, "New Game")
        |> assign(:game, %Game{})
    end
    
    defp apply_action(socket, :edit, %{"id" => game_id}) do
        socket
        |> assign(:page_title, "Edit Game")
        |> assign(:game, Catalog.get_game!(game_id))
    end

    def handle_event("new", _, socket) do
        {:noreply, push_patch(socket, to: Routes.game_index_path(socket, :new))}
    end
    
    def handle_event("edit", %{"id" => game_id}, socket) do
        {:noreply, push_patch(socket, to: Routes.game_index_path(socket, :edit, game_id))}
    end

    def handle_event("cancel", _, socket) do
        {:noreply, push_patch(socket, to: Routes.game_index_path(socket, :index))}
    end
    
    def handle_event("to_rating", _, socket) do
        {:noreply, push_redirect(socket, to: Routes.survey_path(socket, :index))}
    end

    @impl true
    def handle_event("delete", %{"id" => game_id}, socket) do
        game = Catalog.get_game!(game_id)
        {:ok, _} = Catalog.delete_game(game)

        {:noreply, assign(socket, :games, Catalog.list_games())}
    end
end