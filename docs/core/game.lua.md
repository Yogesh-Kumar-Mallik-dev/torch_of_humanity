# core/game.lua

## Purpose

Primary game orchestration module implementing load/update/draw lifecycle hooks
used by main runtime callbacks.

## Current Behavior

- Configures window title, size, fullscreen, and vsync from Config.
- Initializes input system through `engine.input`.
- Loads key bindings using `core.keybindings`.
- Creates a `Player` entity in world-space at `(0, 0)`.
- Initializes map systems through `core.world.map_manager` and `core.world.map_database`.
- Initializes camera system through `core.camera`.
- Updates player simulation each frame with input and delta time.
- Updates map loading window around player position through map manager.
- Moves camera to follow player position each frame.
- Draws world-space maps and player under camera transform.
- Draws map-manager debug data in screen-space after camera is cleared.

## API

- `Game:load()`
- `Game:update(dt)`
- `Game:draw()`

## Dependencies

- `config`
- `engine.input`
- `core.keybindings`
- `entity.player.player`
- `core.world.map_manager`
- `core.world.map_database`
- `core.camera`

## Impact

- Provides a world-space render/update flow where camera tracking and dynamic map streaming are coordinated through the game loop.
