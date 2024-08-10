defmodule LiveChess.LichessApiClient do
  use GenServer

  defmodule State do
    defstruct client: nil,
              tokens: %{}

    @type lichess_user_id :: String.t()
    @type lichess_access_token :: OAuth2.AccessToken.t()

    @type t :: %__MODULE__{
            client: OAuth2.Client.t(),
            tokens: %{lichess_user_id() => lichess_access_token()}
          }
  end

  def start_link() do
    client =
      OAuth2.Client.new(
        strategy: OAuth2.Strategy.AuthCode,
        client_id: "nezteb_live_chess",
        site: "https://lichess.org",
        redirect_uri: "https://livechess.nezteb.net"
      )

    GenServer.start_link(__MODULE__, %{client: client})
  end

  def init(state) do
    {:ok, state}
  end

  # GenServer API

  def get_redirect_url() do
    GenServer.call(__MODULE__, :get_redirect_url)
  end

  def exchange_auth_code_for_access_token(auth_code) do
    GenServer.call(__MODULE__, {:exchange_auth_code_for_access_token, auth_code})
  end

  def get_access_token_for_user(lichess_user_id, invalidate_cache \\ false) do
    GenServer.call(__MODULE__, {:get_access_token_for_user, lichess_user_id, invalidate_cache})
  end

  # GenServer Callbacks

  def handle_call(:get_redirect_url, _from, state) do
    case OAuth2.Client.authorize_url(state.client) do
      {_client, url} ->
        {:reply, {:ok, url}, state}

      _ ->
        {:reply, {:error, :authorize_url_error}, state}
    end
  end

  def handle_call({:exchange_auth_code_for_access_token, auth_code}, _from, state) do
    case OAuth2.Client.get_token(state.client, auth_code) do
      {:ok, client} ->
        {:reply, {:ok, client.token}, state}

      {:error, reason} ->
        {:reply, {:error, reason}, state}
    end
  end

  def handle_call({:get_access_token_for_user, lichess_user_id}, _from, state) do
    case Map.get(state.tokens, lichess_user_id) do
      nil ->
        {:reply, {:error, :no_access_token_for_user}, state}

      token ->
        {:reply, {:ok, token}, state}
    end
  end
end
