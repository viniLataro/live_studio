defmodule LiveStudioWeb.Components.LeftSideBar do
  use LiveStudioWeb, :html

  def sidebar_nav_links(assigns) do
    ~H"""
    <div class="container h-full table">
      <.nav_link path={~p"/light"}>💡 Light</.nav_link>
      <.nav_link path={~p"/sandbox"}>🏝 Sandbox</.nav_link>
      <.nav_link path={~p"/sales"}>📊 Snappy Sales</.nav_link>
      <.nav_link path={~p"/bingo"}>🅱️ Bingoo!</.nav_link>
      <.nav_link path={~p"/flights"}>✈️ Flights</.nav_link>
      <.nav_link path={~p"/vehicles"}>🚙 Vehicles</.nav_link>
      <.nav_link path={~p"/boats"}>🚤 Boats</.nav_link>
      <.nav_link path={~p"/athletes"}>🏄🏾‍♀️ Athletes</.nav_link>
      <.nav_link path={~p"/servers"}>👨‍💻 Servers</.nav_link>
      <.nav_link path={~p"/donations"}>🍞 Donations</.nav_link>
      <.nav_link path={~p"/pizza-orders"}>🍕 Pizza Orders</.nav_link>
      <.nav_link path={~p"/volunteers"}>🙋‍♀️ Volunteers</.nav_link>
      <.nav_link path={~p"/topsecret"}>🕵🏼 Top Secret</.nav_link>
      <.nav_link path={~p"/presence"}>👀 Presence Live</.nav_link>
    </div>
    """
  end

  attr :current_user, :map, required: true

  def sidebar_user_info(assigns) do
    ~H"""
    <div class="px-6 mt-6 relative inline-block text-left">
      <ul class="">
        <%= if @current_user do %>
          <li class="text-gray-900 text-sm font-medium truncate"><%= @current_user.email %></li>
          <li>
            <.link
              href={~p"/users/settings"}
              class="block px-2 py-1 text-sm text-gray-700 hover:bg-gray-100 focus:outline-none"
            >
              Settings
            </.link>
          </li>
          <li>
            <.link
              href={~p"/users/log_out"}
              method="delete"
              class="block px-2 py-1 text-sm text-gray-700 hover:bg-gray-100"
            >
              Log out
            </.link>
          </li>
        <% else %>
          <li>
            <.link
              href={~p"/users/register"}
              class="text-gray-900 text-sm font-medium truncate hover:text-zinc-700"
            >
              Register
            </.link>
          </li>
          <li>
            <.link
              href={~p"/users/log_in"}
              class="text-gray-900 text-sm font-medium truncate hover:text-zinc-700"
            >
              Log in
            </.link>
          </li>
        <% end %>
      </ul>
    </div>
    """
  end
end
