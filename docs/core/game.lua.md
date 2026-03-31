# core/game.lua

## Purpose

Primary game orchestration module implementing load/update/draw lifecycle hooks
used by main runtime callbacks.

## Current Behavior

- Configures window title, size, fullscreen, and vsync from Config.
- Initializes input system through `engine.input`.
- Loads key bindings using `core.keybindings`.
- Creates a temporary default state table with `update` and `draw` handlers.
- Draws placeholder runtime text to confirm loop execution.

## API

- `Game:load()`
- `Game:update(dt)`
- `Game:draw()`

## Dependencies

- `config`
- `engine.input`
- `core.keybindings`

## Impact

- Removes empty-scaffold blocker and establishes a runnable core lifecycle shell
  for future state/gameplay integration.
