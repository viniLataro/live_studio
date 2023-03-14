defmodule LiveStudio.AthletesTest do
  use LiveStudio.DataCase

  alias LiveStudio.Athletes

  describe "athletes" do
    alias LiveStudio.Athletes.Athlete

    import LiveStudio.AthletesFixtures

    @invalid_attrs %{emoji: nil, name: nil, sport: nil, status: nil}

    test "list_athletes/0 returns all athletes" do
      athlete = athlete_fixture()
      assert Athletes.list_athletes() == [athlete]
    end

    test "get_athlete!/1 returns the athlete with given id" do
      athlete = athlete_fixture()
      assert Athletes.get_athlete!(athlete.id) == athlete
    end

    test "create_athlete/1 with valid data creates a athlete" do
      valid_attrs = %{emoji: "some emoji", name: "some name", sport: "some sport", status: "some status"}

      assert {:ok, %Athlete{} = athlete} = Athletes.create_athlete(valid_attrs)
      assert athlete.emoji == "some emoji"
      assert athlete.name == "some name"
      assert athlete.sport == "some sport"
      assert athlete.status == "some status"
    end

    test "create_athlete/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Athletes.create_athlete(@invalid_attrs)
    end

    test "update_athlete/2 with valid data updates the athlete" do
      athlete = athlete_fixture()
      update_attrs = %{emoji: "some updated emoji", name: "some updated name", sport: "some updated sport", status: "some updated status"}

      assert {:ok, %Athlete{} = athlete} = Athletes.update_athlete(athlete, update_attrs)
      assert athlete.emoji == "some updated emoji"
      assert athlete.name == "some updated name"
      assert athlete.sport == "some updated sport"
      assert athlete.status == "some updated status"
    end

    test "update_athlete/2 with invalid data returns error changeset" do
      athlete = athlete_fixture()
      assert {:error, %Ecto.Changeset{}} = Athletes.update_athlete(athlete, @invalid_attrs)
      assert athlete == Athletes.get_athlete!(athlete.id)
    end

    test "delete_athlete/1 deletes the athlete" do
      athlete = athlete_fixture()
      assert {:ok, %Athlete{}} = Athletes.delete_athlete(athlete)
      assert_raise Ecto.NoResultsError, fn -> Athletes.get_athlete!(athlete.id) end
    end

    test "change_athlete/1 returns a athlete changeset" do
      athlete = athlete_fixture()
      assert %Ecto.Changeset{} = Athletes.change_athlete(athlete)
    end
  end
end
