defmodule NearbyWeb.Router do
  use NearbyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NearbyWeb do
    pipe_through :api

    ## query_params: cur_lat= , cur_lng= , radius=
    get "/mobile_food_facility/nearby", MobileFoodFacilityController, :nearby
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
