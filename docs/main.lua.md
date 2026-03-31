# main.lua

Status: runtime bootstrap wired, dependent on unfinished core game module.

## Summary
- Added LÖVE entry wiring to `core.game`.
- Implemented lifecycle callbacks:
  - `love.load()` -> `Game:load()`
  - `love.update(dt)` -> `Game:update(dt)`
  - `love.draw()` -> `Game:draw()`
- Routed input callbacks to game input subsystem:
  - `love.keypressed(key)` -> `Game.input:keypressed(key)`
  - `love.keyreleased(key)` -> `Game.input:keyreleased(key)`

## Current Dependency State
- `core/game.lua` is currently empty, so required methods/fields are not yet provided.
- Runtime execution depends on implementing `Game:load`, `Game:update`, `Game:draw`, and `Game.input`.

## Impact
- Defines the project entry pipeline but is not runnable until core game orchestration is implemented.
