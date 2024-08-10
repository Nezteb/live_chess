defmodule LiveChess.Server do
  use GenServer

  defmodule State do
    defstruct matches: nil

    @type t :: %__MODULE__{
            matches: list(LiveChess.Chess.Match.t())
          }
  end

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  # TODO: Create CRUD functions for matches

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set_state, new_state}, state) do
    {:noreply, new_state}
  end
end
