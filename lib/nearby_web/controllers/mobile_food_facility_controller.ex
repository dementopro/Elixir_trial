defmodule NearbyWeb.MobileFoodFacilityController do
  use NearbyWeb, :controller

  alias Nearby.MobileFoodFacilities

  action_fallback NearbyWeb.FallbackController

  def nearby(conn, params) do
    with {:ok, mobile_food_facilities} <- MobileFoodFacilities.fetch_nearby(params) do
      conn
      |> put_status(:ok)
      |> json(%{
        mobile_food_facilities: mobile_food_facilities
      })
    end
  end
end
