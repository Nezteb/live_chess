defmodule LiveChessWeb.MatchLive.Index do
  use LiveChessWeb, :live_view

  alias LiveChess.Chess
  alias LiveChess.Chess.Match

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :matches, Chess.list_matches())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Match")
    |> assign(:match, Chess.get_match!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Match")
    |> assign(:match, %Match{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Matches")
    |> assign(:match, nil)
  end

  @impl true
  def handle_info({LiveChessWeb.MatchLive.FormComponent, {:saved, match}}, socket) do
    {:noreply, stream_insert(socket, :matches, match)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    match = Chess.get_match!(id)
    {:ok, _} = Chess.delete_match(match)

    {:noreply, stream_delete(socket, :matches, match)}
  end
end
