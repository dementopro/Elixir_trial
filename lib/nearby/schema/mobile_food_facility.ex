defmodule Nearby.MobileFoodFacility do
  use Ecto.Schema

  alias Nearby.MobileFoodFacility
  import Ecto.Changeset
  import Ecto.Query

  ## in meters
  @default_radius 500
  @srid 4326

  @derive Jason.Encoder
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "mobile_food_facilities" do
    field :location_id, :string
    field :applicant, :string
    field :facility_type, :string
    field :location, Geo.PostGIS.Geometry
    field :zip_code, :string

    timestamps()
  end

  @fields [
    :location_id,
    :applicant,
    :facility_type,
    :location,
    :zip_code
  ]

  @doc false
  def changeset(mobile_food_facilities, attrs) do
    mobile_food_facilities
    |> cast(attrs, @fields)
  end

  def mobile_food_facilities_query(params) do
    mobile_food_facilities = MobileFoodFacility

    radius = Map.get(params, "radius", @default_radius) |> to_integer()
    current_lat = Map.get(params, "current_lat") |> to_float()
    current_lng = Map.get(params, "current_lng") |> to_float()

    if is_nil(current_lat) or is_nil(current_lng) do
      mobile_food_facilities
    else
      mobile_food_facilities
      |> where(
        [m],
        fragment(
          "ST_DWithin(?::geography, ST_SetSRID(ST_MakePoint(?, ?), ?), ?)",
          m.location,
          ^current_lat,
          ^current_lng,
          ^@srid,
          ^radius
        )
      )
    end
  end

  defp to_float(nil), do: nil

  defp to_float(value) do
    case Float.parse(value) do
      {float_val, _} -> float_val
      :error -> 0.0
    end
  end

  defp to_integer(value) when is_integer(value), do: value

  defp to_integer(value) do
    case Integer.parse(value) do
      {int_val, _} -> int_val
      :error -> 0
    end
  end
end
