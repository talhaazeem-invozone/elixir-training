defmodule PracLiveWeb.PageController do
  use PracLiveWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
