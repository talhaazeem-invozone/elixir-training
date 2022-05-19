defmodule PracLiveWeb.SurveyLive do
    use PracLiveWeb, :live_view

    alias PracLive.Accounts
    alias PracLive.Catalog

    def mount(_params, %{"user_token" => user_token}, socket) do
        user = Accounts.get_user_by_session_token(user_token)
        games = Catalog.list_games_with_user_rating(user)
        
        {:ok,
        socket
        |> assign(:current_user, user)
        |> assign(:games, games)}
    end


    def handle_info({:created_rating, updated_product, product_index}, socket) do
        {:noreply, handle_rating_created(socket, updated_product, product_index)}
    end

    def handle_rating_created(%{assigns: %{games: games}} = socket, updated_game, game_index) do
        socket
        |> put_flash(:info, "Rating submitted successfully")
        |> assign(:games, List.replace_at(games, game_index, updated_game)
        )
    end

    def handle_event("to_games", _, socket) do
        {:noreply, push_redirect(socket, to: Routes.game_index_path(socket, :index))}
    end
end