defmodule Nearby.Repo.Migrations.CreateMobileFoodFacilitiesTable do
  use Ecto.Migration

  def change do
    create table(:mobile_food_facilities, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :location_id, :string
      add :applicant, :string
      add :facility_type, :string
      add :zip_code, :string

      timestamps()
    end

    execute("SELECT AddGeometryColumn ('mobile_food_facilities','location',4326,'POINT',2)")

    execute(
      "CREATE INDEX mobile_food_facilities_location_index on mobile_food_facilities USING gist (location)"
    )
  end
end
