defmodule NearbyWeb.MobileFoodFacilityControllerTest do
  use NearbyWeb.ConnCase, async: true

  alias Nearby.MobileFoodFacilities

  describe "nearby" do
    test "list food truck within the radius", %{conn: conn} do
      lat = 37.79236678688307
      lon = -122.40014830676716
      coordinates = {lat, lon}
      location = %Geo.Point{coordinates: coordinates, srid: 4326}

      attrs = %{
        "location_id" => "1",
        "applicant" => "test Truck",
        "facility_type" => "Truck",
        "location" => location,
        "zip_code" => "28854"
      }

      {:ok, mobile_food_facility} = MobileFoodFacilities.create(attrs)

      response =
        conn
        |> get(Routes.mobile_food_facility_path(conn, :nearby), %{
          current_lat: lat,
          current_lng: lon
        })
        |> json_response(200)

      assert %{"mobile_food_facilities" => [mobile_food_facilities]} = response
      assert mobile_food_facility.location_id == mobile_food_facilities["location_id"]
      assert lat == mobile_food_facilities["latitude"]
      assert lon == mobile_food_facilities["longitude"]
    end
  end
end
