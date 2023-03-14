defmodule LiveStudio.Athletes.Athlete do
  use Ecto.Schema
  import Ecto.Changeset

  schema "athletes" do
    field :emoji, :string
    field :name, :string
    field :sport, :string
    field :status, Ecto.Enum, values: [:training, :competing, :resting]

    timestamps()
  end

  @doc false
  def changeset(athlete, attrs) do
    athlete
    |> cast(attrs, [:name, :emoji, :sport, :status])
    |> validate_required([:name, :emoji, :sport, :status])
  end
end
