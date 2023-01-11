defmodule Mix.Tasks.PopulateMobileFoodFacilityPermit do
  use Mix.Task

  alias Nearby.MobileFoodFacilities

  def run(_) do
    Mix.Task.run("app.start", [])
    # remove first line from csv file that contains headers
    File.stream!("#{File.cwd!()}/priv/data/mobile_food_facility_permit.csv")
    |> CSV.decode()
    |> Enum.to_list()
    |> Enum.each(&create_mobile_food_facility_data/1)
  end

  def create_mobile_food_facility_data({:ok, data}) do
    IO.inspect(data, label: "DATA")

    location_id = data |> Enum.at(0)
    applicant = data |> Enum.at(1)
    facility_type = data |> Enum.at(2)
    lat = data |> Enum.at(14) |> to_float()
    lon = data |> Enum.at(15) |> to_float()
    coordinates = {lat, lon}
    location = %Geo.Point{coordinates: coordinates, srid: 4326}
    zip_code = data |> Enum.at(27)

    attrs = %{
      "location_id" => location_id,
      "applicant" => applicant,
      "facility_type" => facility_type,
      "location" => location,
      "zip_code" => zip_code
    }

    with {:fetch_mobile_food_facility, nil} <-
           {:fetch_mobile_food_facility,
            MobileFoodFacilities.get_by(%{location_id: location_id, applicant: applicant})},
         {:ok, mobile_food_facility} <- MobileFoodFacilities.create(attrs) do
      IO.puts("MobileFoodFacility #{mobile_food_facility.applicant} created")
    else
      {:fetch_mobile_food_facility, mobile_food_facility} ->
        IO.puts("ALREADY PRESENT: MobileFoodFacility #{mobile_food_facility.applicant}")

      {:error, changeset} ->
        IO.puts("FAILED TO STORE: MobileFoodFacility #{inspect(changeset)}")
    end
  end

  defp to_float(value) do
    case Float.parse(value) do
      {float_val, _} -> float_val
      :error -> 0.0
    end
  end
end
