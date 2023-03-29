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

  def nav_links(assigns) do
    ~H"""
    <nav class="h-full px-3 mt-6">
      <div class="container h-full table">
        <.link
          navigate={~p"/app/light/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :light, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          💡 Light
        </.link>
        <.link
          navigate={~p"/app/sandbox/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :sandbox, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🏝 Sandbox
        </.link>
        <.link
          navigate={~p"/app/sales/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :sales, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          📊 Snappy Sales
        </.link>
        <.link
          navigate={~p"/app/bingo/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :bingo, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🅱️ Bingoo!
        </.link>
        <.link
          navigate={~p"/app/flights/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :flights, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          ✈️ Flights
        </.link>
        <.link
          navigate={~p"/app/vehicles/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :vehicles, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🚙 Vehicles
        </.link>
        <.link
          navigate={~p"/app/boats/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :boats, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🚤 Boats
        </.link>
        <.link
          navigate={~p"/app/athletes/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :athletes, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🏄🏾‍♀️ Athletes
        </.link>
        <.link
          navigate={~p"/app/servers/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :servers, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          👨‍💻 Servers
        </.link>
        <.link
          navigate={~p"/app/donations/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :donations, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🍞 Donations
        </.link>
        <.link
          navigate={~p"/app/pizza-orders/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :pizza_orders, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🍕 Pizza Orders
        </.link>
        <.link
          navigate={~p"/app/volunteers/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :volunteers, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🙋‍♀️ Volunteers
        </.link>
        <.link
          navigate={~p"/app/topsecret/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :topsecret, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          🕵🏼 Top Secret
        </.link>
        <.link
          navigate={~p"/app/presence/"}
          class={"text-gray-700 hover:text-gray-900  flex items-center px-3 py-4 text-md font-medium rounded-md
              #{if @active_tab == :presence, do: "bg-gray-200 text-gray-900", else: "hover:bg-gray-200"}"
            }
        >
          👀 Presence Live
        </.link>
      </div>
    </nav>
    """
  end
end
