defmodule LiveStudioWeb.ServerFormComponent do
  use LiveStudioWeb, :live_component

  alias LiveStudio.Servers
  alias LiveStudio.Servers.Server

  def mount(socket) do
    changeset = Servers.change_server(%Server{})

    {:ok, assign(socket, :form, to_form(changeset))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="save" phx-change="validate" phx-target={@myself}>
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
    </div>
    """
  end

  def handle_event("save", %{"server" => server_params}, socket) do
    case Servers.create_server(server_params) do
      {:ok, server} ->
        socket = push_patch(socket, to: ~p"/servers/#{server}")
        socket = put_flash(socket, :info, "Server has been succesfully created!")
        {:noreply, socket}

      {:error, changeset} ->
        socket =
          put_flash(socket, :error, "Oops! Something went wrong, please check the errors below.")

        {:noreply, assign_form(socket, changeset)}
    end
  end

  def handle_event("validate", %{"server" => server_params}, socket) do
    changeset =
      %Server{}
      |> Servers.change_server(server_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
