# core/game.lua

## Purpose

Primary game orchestration module implementing load/update/draw lifecycle hooks
used by main runtime callbacks.

## Current Behavior

- Configures window title, size, fullscreen, and vsync from Config.
- Initializes input system through `engine.input`.
- Loads key bindings using `core.keybindings`.
- Creates a `Player` entity positioned at the center of the current window.
- Updates player simulation each frame with input and delta time.
- Draws the player each frame during render pass.

## API

- `Game:load()`
- `Game:update(dt)`
- `Game:draw()`

## Dependencies

- `config`
- `engine.input`
- `core.keybindings`
- `entity.player.player`

## Impact

- Replaces placeholder game-loop behavior with a concrete entity-driven runtime
  flow, establishing baseline gameplay update/render orchestration.
