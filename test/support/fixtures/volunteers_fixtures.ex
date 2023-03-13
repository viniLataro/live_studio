defmodule LiveStudio.VolunteersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveStudio.Volunteers` context.
  """

  @doc """
  Generate a volunteer.
  """
  def volunteer_fixture(attrs \\ %{}) do
    {:ok, volunteer} =
      attrs
      |> Enum.into(%{
        checked_out: true,
        name: "some name",
        phone: "some phone"
      })
      |> LiveStudio.Volunteers.create_volunteer()

    volunteer
  end
end
