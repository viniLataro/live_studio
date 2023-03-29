defmodule LiveStudioWeb.Live.App.LightLive do
  use LiveStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(brightness: 10, temp: "3000")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>💡 Light</h1>
    <div id="light">
      <.meter brightness={@brightness} temp={@temp} />
      <.button_control />
      <.slide_control brightness={@brightness} phx-debounce="250" />
      <.temp_control temp={@temp} />
    </div>
    """
  end

  attr :brightness, :integer, required: true
  attr :temp, :string, required: true

  def meter(assigns) do
    ~H"""
    <div class="meter">
      <span style={"width: #{@brightness}%; background: #{temp_color(@temp)}"}>
        <%= @brightness %>%
      </span>
    </div>
    """
  end

  def button_control(assigns) do
    ~H"""
    <button phx-click="off"><img src="/images/light-off.svg" /></button>
    <button phx-click="down"><img src="/images/down.svg" /></button>
    <button phx-click="rando"><img src="/images/fire.svg" /></button>
    <button phx-click="up"><img src="/images/up.svg" /></button>
    <button phx-click="on"><img src="/images/light-on.svg" /></button>
    """
  end

  attr :brightness, :integer, required: true
  attr :rest, :global

  def slide_control(assigns) do
    ~H"""
    <form phx-change="slide">
      <input type="range" min="0" max="100" name="brightness" value={@brightness} {@rest} />
    </form>
    """
  end

  attr :temp, :string, required: true

  def temp_control(assigns) do
    ~H"""
    <form phx-change="change-temp">
      <div class="temps">
        <%= for temp <- ["3000", "4000", "5000"] do %>
          <div>
            <input type="radio" id={temp} name="temp" value={temp} checked={temp == @temp} />
            <label for="temp"><%= temp %></label>
          </div>
        <% end %>
      </div>
    </form>
    """
  end

  def handle_event("change-temp", %{"temp" => temp}, socket) do
    socket = assign(socket, temp: temp)
    {:noreply, socket}
  end

  def handle_event("slide", %{"brightness" => brightness}, socket) do
    socket = assign(socket, :brightness, String.to_integer(brightness))
    {:noreply, socket}
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, brightness: 100)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("rando", _, socket) do
    socket = assign(socket, :brightness, Enum.random(0..100))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end

  defp temp_color("3000"), do: "#F1C40D"
  defp temp_color("4000"), do: "#FEFF66"
  defp temp_color("5000"), do: "#99CCFF"
end
