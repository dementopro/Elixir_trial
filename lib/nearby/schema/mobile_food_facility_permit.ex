defmodule Nearby.MobileFoodFacilityPermit do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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
end
