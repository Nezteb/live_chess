# Live Chess

## Milestones

1. UCI interface
2. Singleplayer chess with CLI/iex
3. Singleplayer chess with LiveView
4. Login with Lichess
  - https://github.com/lichess-org/api-demo/blob/master/src/auth.ts
6. Two-player chess with LiveView
7. Basic chess "AI" that makes random (legal) moves
8. Stockfish analysis

## Resources

### Other LiveView Chess Examples

- https://github.com/dberget/chesster
  - Uses Erlang binbo library: https://github.com/DOBRO/binbo
- https://github.com/djordjelacmanovic/multichess
- https://github.com/alectower/checkmate
- https://github.com/yepesasecas/live_chess

### Elixir Libs

- https://github.com/kokolegorille/stockfix
  - Uses Stockfish via port!
- https://github.com/kokolegorille/chessfold
- https://github.com/kokolegorille/chess_logic

### Stockfish

- https://github.com/official-stockfish/Stockfish
  - Could use port
    - https://hexdocs.pm/elixir/main/Port.html
  - Or NIF
    - https://andrealeopardi.com/posts/using-c-from-elixir-with-nifs/
