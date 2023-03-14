defmodule LiveStudio.AthletesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveStudio.Athletes` context.
  """

  @doc """
  Generate a athlete.
  """
  def athlete_fixture(attrs \\ %{}) do
    {:ok, athlete} =
      attrs
      |> Enum.into(%{
        emoji: "some emoji",
        name: "some name",
        sport: "some sport",
        status: "some status"
      })
      |> LiveStudio.Athletes.create_athlete()

    athlete
  end
end
