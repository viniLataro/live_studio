defmodule LiveStudioWeb.Live.App.Nav do
  @moduledoc false

  import Phoenix.LiveView
  use Phoenix.Component

  alias LiveStudioWeb.Live.App

  def on_mount(:default, _params, __session, socket) do
    {:cont,
     socket
     |> assign(:active_tab, :light)
     |> attach_hook(:active_tab, :handle_params, &handle_active_tab_params/3)}
  end

  defp handle_active_tab_params(_params, _url, socket) do
    active_tab =
      case {socket.view, socket.assigns.live_action} do
        {App.LightLive, _} ->
          :light

        {App.SandboxLive, _} ->
          :sandbox

        {App.SalesLive, _} ->
          :sales

        {App.BingoLive, _} ->
          :bingo

        {App.FlightsLive, _} ->
          :flights

        {App.VehiclesLive, _} ->
          :vehicles

        {App.BoatsLive, _} ->
          :boats

        {App.AthletesLive, _} ->
          :athletes

        {App.ServersLive, _} ->
          :servers

        {App.DonationsLive, _} ->
          :donations

        {App.PizzaOrdersLive, _} ->
          :pizza_orders

        {App.VolunteersLive, _} ->
          :volunteers

        {App.TopSecretLive, _} ->
          :topsecret

        {App.PresenceLive, _} ->
          :presence

        {App.ShopLive, _} ->
          :shop

        {App.BookingsLive, _} ->
          :bookings

        {App.JugglingLive, _} ->
          :juggling

        {App.DesksLive, _} ->
          :desks

        {_, _} ->
          :any
      end

    {:cont, assign(socket, active_tab: active_tab)}
  end
end
