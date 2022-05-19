defmodule PracLive.LiveHelpers do
  alias PracLive.Accounts
  alias PracLive.Accounts.User
  alias PracLive.Router.Helpers, as: Routes

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveView

  @doc """
  Renders a component inside the `AppeoWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, AppeoWeb.RoleLive.FormComponent,
        id: @role.id || :new,
        action: @live_action,
        role: @role,
        return_to: Routes.role_index_path(@socket, :index) %>
  """
  def live_modal(_socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(PracLiveWeb.ModalComponent, modal_opts)
  end
end
