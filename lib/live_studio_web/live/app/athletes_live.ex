defmodule LiveStudioWeb.Live.App.AthletesLive do
  use LiveStudioWeb, :live_view

  alias LiveStudio.Athletes
  alias LiveStudio.Athletes.Athlete

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        filter: %{sport: "", status: ""},
        athletes: Athletes.list_athletes()
      )

    {:ok, socket, temporary_assigns: [athletes: []]}
  end

  def render(assigns) do
    ~H"""
    <h1>🏄🏾‍♀️ Athletes</h1>
    <div id="athletes">
      <.filter_form filter={@filter} />

      <div class="athletes">
        <.athlete :for={athlete <- @athletes} athlete={athlete} />
      </div>
    </div>
    """
  end

  attr :filter, :map, default: %{sport: "", status: ""}

  def filter_form(assigns) do
    ~H"""
    <form phx-change="filter">
      <div class="filters">
        <select name="sport">
          <%= Phoenix.HTML.Form.options_for_select(
            sport_options(),
            @filter.sport
          ) %>
        </select>
        <select name="status">
          <%= Phoenix.HTML.Form.options_for_select(
            status_options(),
            @filter.status
          ) %>
        </select>
      </div>
    </form>
    """
  end

  attr :athlete, Athlete, required: true

  def athlete(assigns) do
    ~H"""
    <div class="athlete">
      <div class="emoji">
        <%= @athlete.emoji %>
      </div>
      <div class="name">
        <%= @athlete.name %>
      </div>
      <div class="details">
        <span class="sport">
          <%= @athlete.sport %>
        </span>
        <span class="status">
          <%= @athlete.status %>
        </span>
      </div>
    </div>
    """
  end

  def handle_event("filter", %{"sport" => sport, "status" => status}, socket) do
    filter = %{sport: sport, status: status}

    athletes = Athletes.list_athletes(filter)

    socket =
      assign(socket,
        filter: filter,
        athletes: athletes
      )

    {:noreply, socket}
  end

  defp sport_options do
    [
      "All Sports": "",
      Surfing: "Surfing",
      Rowing: "Rowing",
      Swimming: "Swimming"
    ]
  end

  defp status_options do
    [
      "All Statuses": "",
      Training: :training,
      Competing: :competing,
      Resting: :resting
    ]
  end
end
