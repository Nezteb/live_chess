defmodule LiveChessWeb.MatchLive.FormComponent do
  use LiveChessWeb, :live_component

  alias LiveChess.Chess

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage match records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="match-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:fen]} type="text" label="Fen" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Match</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{match: match} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Chess.change_match(match))
     end)}
  end

  @impl true
  def handle_event("validate", %{"match" => match_params}, socket) do
    changeset = Chess.change_match(socket.assigns.match, match_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"match" => match_params}, socket) do
    save_match(socket, socket.assigns.action, match_params)
  end

  defp save_match(socket, :edit, match_params) do
    case Chess.update_match(socket.assigns.match, match_params) do
      {:ok, match} ->
        notify_parent({:saved, match})

        {:noreply,
         socket
         |> put_flash(:info, "Match updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_match(socket, :new, match_params) do
    case Chess.create_match(match_params) do
      {:ok, match} ->
        notify_parent({:saved, match})

        {:noreply,
         socket
         |> put_flash(:info, "Match created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
