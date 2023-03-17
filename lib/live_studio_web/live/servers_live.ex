defmodule LiveStudioWeb.ServersLive do
  use LiveStudioWeb, :live_view

  alias LiveStudio.Servers
  alias LiveStudio.Servers.Server

  def mount(_params, _session, socket) do
    servers = Servers.list_servers()

    socket =
      assign(socket,
        servers: servers,
        coffees: 0
      )

    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    server = Servers.get_server!(id)

    {:noreply, assign(socket, selected_server: server, page_title: "what's up #{server.name}?")}
  end

  def handle_params(_, _uri, socket) do
    socket =
      if socket.assigns.live_action == :new do
        changeset = Servers.change_server(%Server{})

        assign(socket,
          selected_server: nil,
          form: to_form(changeset)
        )
      else
        assign(socket,
          selected_server: hd(socket.assigns.servers)
        )
      end

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Servers</h1>
    <div id="servers">
      <div class="sidebar">
        <div class="nav">
          <.link patch={~p"/servers/new"} class="add">
            + add new Server
          </.link>
          <.link
            :for={server <- @servers}
            patch={~p"/servers/#{server}"}
            class={if server == @selected_server, do: "selected"}
          >
            <span class={server.status}></span>
            <%= server.name %>
          </.link>
        </div>
        <div class="coffees">
          <button phx-click="drink">
            <img src="/images/coffee.svg" />
            <%= @coffees %>
          </button>
        </div>
      </div>
      <div class="main">
        <div class="wrapper">
          <%= if @live_action == :new do %>
            <.form for={@form} phx-submit="save" phx-change="validate">
              <div class="field">
                <.input field={@form[:name]} placeholder="ex-name" label="Name" phx-debounce="500" />
              </div>
              <div class="field">
                <.input
                  field={@form[:framework]}
                  placeholder="Framework"
                  label="Framework"
                  phx-debounce="500"
                />
              </div>
              <div class="field">
                <.input field={@form[:size]} type="number" label="Size (MB)" />
              </div>
              <.button phx-disable-with="Saving...">
                Save
              </.button>
              <.link patch={~p"/servers"} class="cancel">
                Cancel
              </.link>
            </.form>
          <% else %>
            <.server server={@selected_server} />
          <% end %>
          <div class="links">
            <.link navigate={~p"/light"}>
              Adjust Lights
            </.link>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def server(assigns) do
    ~H"""
    <div class="server">
      <div class="header">
        <h2><%= @server.name %></h2>
        <span class={@server.status}>
          <%= @server.status %>
        </span>
      </div>
      <div class="body">
        <div class="row">
          <span>
            <%= @server.deploy_count %> deploys
          </span>
          <span>
            <%= @server.size %> MB
          </span>
          <span>
            <%= @server.framework %>
          </span>
        </div>
        <h3>Last Commit Message:</h3>
        <blockquote>
          <%= @server.last_commit_message %>
        </blockquote>
      </div>
    </div>
    """
  end

  def handle_event("validate", %{"server" => server_params}, socket) do
    changeset =
      %Server{}
      |> Servers.change_server(server_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"server" => server_params}, socket) do
    case Servers.create_server(server_params) do
      {:ok, server} ->
        socket = update(socket, :servers, fn servers -> [server | servers] end)

        socket = push_patch(socket, to: ~p"/servers?#{server}")

        socket = put_flash(socket, :info, "Server successfully created!")

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          put_flash(socket, :error, "Oops! Something went wrong, please check the errors below.")

        {:noreply, assign_form(socket, changeset)}
    end
  end

  def handle_event("drink", _, socket) do
    {:noreply, update(socket, :coffees, &(&1 + 1))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
