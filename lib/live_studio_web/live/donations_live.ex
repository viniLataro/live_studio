defmodule LiveStudioWeb.DonationsLive do
  use LiveStudioWeb, :live_view

  alias LiveStudio.Donations

  def mount(_params, _session, socket) do
    donations = Donations.list_donations()

    socket =
      assign(socket,
        donations: donations
      )

    {:ok, socket}
  end
end
