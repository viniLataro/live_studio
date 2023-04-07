defmodule LiveStudioWeb.Components.LeftSideBar do
  use LiveStudioWeb, :html

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

  attr :active_tab, :atom, required: true
  attr :current_user, :map, required: true

  def nav_links(assigns) do
    ~H"""
    <div class="container h-full table">
      <.nav_link path={~p"/app/light/"} tab={:light} active_tab={@active_tab}>
        💡 Light
      </.nav_link>
      <.nav_link path={~p"/app/sandbox/"} tab={:sandbox} active_tab={@active_tab}>
        🏝 Sandbox
      </.nav_link>
      <.nav_link path={~p"/app/sales/"} tab={:sales} active_tab={@active_tab}>
        📊 Snappy Sales
      </.nav_link>
      <.nav_link path={~p"/app/bingo/"} tab={:bingo} active_tab={@active_tab}>
        🅱️ Bingoo!
      </.nav_link>
      <.nav_link path={~p"/app/flights/"} tab={:flights} active_tab={@active_tab}>
        ✈️ Flights
      </.nav_link>
      <.nav_link path={~p"/app/vehicles/"} tab={:vehicles} active_tab={@active_tab}>
        🚙 Vehicles
      </.nav_link>
      <.nav_link path={~p"/app/boats/"} tab={:boats} active_tab={@active_tab}>
        🚤 Boats
      </.nav_link>
      <.nav_link path={~p"/app/athletes/"} tab={:athletes} active_tab={@active_tab}>
        🏄🏾‍♀️ Athletes
      </.nav_link>
      <.nav_link path={~p"/app/servers/"} tab={:servers} active_tab={@active_tab}>
        👨‍💻 Servers
      </.nav_link>
      <.nav_link path={~p"/app/donations/"} tab={:donations} active_tab={@active_tab}>
        🍞 Donations
      </.nav_link>
      <.nav_link path={~p"/app/pizza-orders/"} tab={:pizza_orders} active_tab={@active_tab}>
        🍕 Pizza Orders
      </.nav_link>
      <.nav_link path={~p"/app/volunteers/"} tab={:volunteers} active_tab={@active_tab}>
        🙋‍♀️ Volunteers
      </.nav_link>
      <.nav_link path={~p"/app/topsecret/"} tab={:topsecret} active_tab={@active_tab}>
        🕵🏼 Top Secret
      </.nav_link>
      <.nav_link path={~p"/app/presence/"} tab={:presence} active_tab={@active_tab}>
        👀 Presence Live
      </.nav_link>
      <.nav_link path={~p"/app/shop/"} tab={:shop} active_tab={@active_tab}>
        🛒 Shop
      </.nav_link>
      <.nav_link path={~p"/app/bookings/"} tab={:bookings} active_tab={@active_tab}>
        📅 Bookings
      </.nav_link>
      <.nav_link path={~p"/app/juggling/"} tab={:juggling} active_tab={@active_tab}>
        🤹🏻‍♂️ Juggling
      </.nav_link>
      <.nav_link path={~p"/app/desks/"} tab={:desks} active_tab={@active_tab}>
        🖥️ Desks
      </.nav_link>

      <.link
        navigate={~p"/users/settings"}
        class={"text-gray-500 flex items-center ml-0 px-2 py-2 text-md font-medium rounded-md
              #{if @active_tab == :settings, do: "bg-gray-200", else: "hover:bg-gray-200"}"
        }
      >
        <div class="text-gray-500 group-hover:text-gray-500 mr-3 flex-shrink-0 h-6 w-6">
          <.icon name="hero-adjustments-vertical" />
        </div>
        Settings
      </.link>
      <.link
        href={~p"/users/log_out"}
        method="delete"
        class={"text-gray-500 flex items-center ml-0 px-2 py-2 text-md font-medium rounded-md
              #{if @active_tab == :settings, do: "bg-gray-200", else: "hover:bg-gray-200"}"
        }
      >
        <div class="text-gray-500 group-hover:text-gray-500 mr-3 flex-shrink-0 h-6 w-6">
          <.icon name="hero-arrow-left-on-rectangle" />
        </div>
        Log out
      </.link>
    </div>
    """
  end

  def sidebar_account_dropdown(assigns) do
    ~H"""
    <.dropdown id={@id}>
      <:img src="/images/spy.svg" default_icon={:user_circle} />
      <:title><%= @current_user.email %></:title>
      <:subtitle>admin</:subtitle>
      <:link navigate={~p"/users/settings"}>Settings</:link>
      <:link href={~p"/users/log_out"} method={:delete}>Sign out</:link>
    </.dropdown>
    """
  end

  attr :path, :string, required: true
  attr :tab, :any, required: true
  attr :active_tab, :any, required: true
  slot :inner_block

  defp nav_link(assigns) do
    ~H"""
    <div class="space-y-1 group">
      <.link
        navigate={@path}
        class={"hover:text-gray-700 hover:bg-gray-200 flex items-center px-3 py-4 text-md font-medium rounded-md
            #{if @active_tab == @tab, do: "bg-gray-200 text-gray-700", else: "text-gray-500"}"
      }
      >
        <%= render_slot(@inner_block) %>
      </.link>
    </div>
    """
  end
end
