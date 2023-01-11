defmodule Nearby.MobileFoodFacilityPermits do
  alias Nearby.Repo
  alias Nearby.MobileFoodFacilityPermit
  import Ecto.Query

  def create(attrs) do
    %MobileFoodFacilityPermit{}
    |> MobileFoodFacilityPermit.changeset(attrs)
    |> Repo.insert()
  end

  def get_by(params, preload \\ []) do
    params = params |> Keyword.new()

    MobileFoodFacilityPermit
    |> preload(^preload)
    |> Repo.get_by(params)
  end
end
