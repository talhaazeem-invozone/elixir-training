defmodule PracLive.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PracLive.Catalog` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PracLive.Catalog.create_game()

    game
  end
end
