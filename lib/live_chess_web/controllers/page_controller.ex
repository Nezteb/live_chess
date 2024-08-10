defmodule LiveChessWeb.PageController do
  use LiveChessWeb, :controller

  def home(conn, _params) do
    auth_code = conn.query_params["code"]
    _token = LiveChess.LichessApiClient.exchange_auth_code_for_access_token(auth_code)

    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
