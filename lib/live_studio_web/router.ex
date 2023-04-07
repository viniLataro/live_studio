defmodule LiveStudioWeb.Router do
  use LiveStudioWeb, :router

  import LiveStudioWeb.UserAuth

  alias LiveStudioWeb.Live.App

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LiveStudioWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :app do
    plug :put_layout, html: {LiveStudioWeb.Layouts, :app}
    plug :fetch_current_user
  end

  pipeline :site do
    plug(:put_layout, html: {LiveStudioWeb.Layouts, :site})
  end

  scope "/app", LiveStudioWeb.Live.App do
    pipe_through [:browser, :app]

    live_session :authenticated,
      on_mount: [{LiveStudioWeb.UserAuth, :ensure_authenticated}, App.Nav] do
      live "/", LightLive, :show
      live "/light", LightLive, :show
      live "/sandbox", SandboxLive, :show
      live "/sales", SalesLive, :show
      live "/bingo", BingoLive, :show
      live "/flights", FlightsLive, :show
      live "/vehicles", VehiclesLive, :show
      live "/boats", BoatsLive, :show
      live "/athletes", AthletesLive, :show
      live "/servers", ServersLive, :show
      live "/servers/new", ServersLive, :new
      live "/servers/:id", ServersLive, :show
      live "/donations", DonationsLive, :show
      live "/pizza-orders", PizzaOrdersLive, :show
      live "/volunteers", VolunteersLive, :show
      live "/topsecret", TopSecretLive, :show
      live "/presence", PresenceLive, :show
      live "/shop", ShopLive, :show
      live "/bookings", BookingsLive, :show
      live "/juggling", JugglingLive, :show
      live "/desks", DesksLive, :show
    end
  end

  ## Site / Register / Login Routes
  scope "/", LiveStudioWeb do
    pipe_through [:browser, :site, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{LiveStudioWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/", UserLoginLive, :new
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", LiveStudioWeb do
    pipe_through [:browser, :site]

    live_session :require_authenticated_user,
      on_mount: [{LiveStudioWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{LiveStudioWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:live_studio, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveStudioWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
