defmodule LiveStudioWeb.LayoutComponent do
  @moduledoc """
  Component for rendering content inside layout without full DOM patch.
  """
  use LiveStudioWeb, :live_component

  def show_modal(module, attrs) do
    send_update(__MODULE__, id: "layout", show: Enum.into(attrs, %{module: module}))
  end

  def hide_modal do
    send_update(__MODULE__, id: "layout", show: nil)
  end

  def update(%{id: id} = assigns, socket) do
    show =
      case assigns[:show] do
        %{module: _module, confirm: {text, attrs}} = show ->
          show
          |> Map.put_new(:title, show[:title])
          |> Map.put_new(:on_cancel, show[:on_cancel] || %JS{})
          |> Map.put_new(:on_confirm, show[:on_confirm] || %JS{})
          |> Map.put_new(:patch, nil)
          |> Map.put_new(:navigate, nil)
          |> Map.merge(%{confirm_text: text, confirm_attrs: attrs})

        nil ->
          nil
      end

    {:ok, assign(socket, id: id, show: show)}
  end

  def render(assigns) do
    ~H"""
    <div class={unless @show, do: "hidden"}>
      <%= if @show do %>
        <.modal
          show
          id={@id}
          navigate={@show.navigate}
          patch={@show.patch}
          on_cancel={@show.on_cancel}
          on_confirm={@show.on_confirm}
        >
          <:title><%= @show.title %></:title>
          <.live_component module={@show.module} {@show} />
          <:cancel>Cancel</:cancel>
          <:confirm {@show.confirm_attrs}><%= @show.confirm_text %></:confirm>
        </.modal>
      <% end %>
    </div>
    """
  end
end
