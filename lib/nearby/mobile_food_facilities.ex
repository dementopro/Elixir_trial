defmodule Nearby.MobileFoodFacilities do
  alias Nearby.Repo
  alias Nearby.MobileFoodFacility
  import Ecto.Query

  def create(attrs) do
    %MobileFoodFacility{}
    |> MobileFoodFacility.changeset(attrs)
    |> Repo.insert()
  end

  def get_by(params, preload \\ []) do
    params = params |> Keyword.new()

    MobileFoodFacility
    |> preload(^preload)
    |> Repo.get_by(params)
  end

  def fetch_nearby(params) do
    params
    |> MobileFoodFacility.mobile_food_facilities_query()
    |> Repo.all()
    |> Enum.map(&format_mobile_food_facility/1)
  end

  def format_mobile_food_facility(mobile_food_facility) do
    %Geo.Point{coordinates: {lat, lng}} = mobile_food_facility.location

    mobile_food_facility
    |> Map.drop([:location, :__meta__, :__struct__])
    |> Map.put(:latitude, lat)
    |> Map.put(:longitude, lng)
  end
end
