defmodule NearbyWeb.MobileFoodFacilityController do
  use NearbyWeb, :controller

  alias Nearby.MobileFoodFacilities

  action_fallback NearbyWeb.FallbackController

  def nearby(conn, %{"current_lat" => _, "current_lng" => _} = params) do
    with mobile_food_facilities when is_list(mobile_food_facilities) <-
           MobileFoodFacilities.fetch_nearby(params) do
      conn
      |> put_status(:ok)
      |> json(%{
        mobile_food_facilities: mobile_food_facilities
      })
    end
  end

  def nearby(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{
      error: "missing current_lat and current_lng"
    })
  end
end
