defmodule LiveChessWeb.Router do
  use LiveChessWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveChessWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveChessWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/players", PlayerLive.Index, :index
    live "/players/new", PlayerLive.Index, :new
    live "/players/:id/edit", PlayerLive.Index, :edit

    live "/players/:id", PlayerLive.Show, :show
    live "/players/:id/show/edit", PlayerLive.Show, :edit

    live "/matches", MatchLive.Index, :index
    live "/matches/new", MatchLive.Index, :new
    live "/matches/:id/edit", MatchLive.Index, :edit

    live "/matches/:id", MatchLive.Show, :show
    live "/matches/:id/show/edit", MatchLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveChessWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:live_chess, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveChessWeb.Telemetry
    end
  end
end
