# core/game.lua

## Purpose

Primary game orchestration module implementing load/update/draw lifecycle hooks
used by main runtime callbacks.

## Current Behavior

- Configures window title, size, fullscreen, and vsync from Config.
- Initializes input system through `engine.input`.
- Loads key bindings using `core.keybindings`.
- Initializes a Bump physics world for tile collision registration.
- Creates a `Player` entity in world-space at `(0, 0)`.
- Initializes world systems through `core.world.world_data` and `core.world.map_manager`.
- Initializes camera system through `core.camera`.
- Updates player simulation each frame with input and delta time.
- Updates map streaming and animated tile state through map manager.
- Moves camera with smooth dt-based follow each frame.
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
- `core.world.world_data`
- `core.camera`
- `lib.bump`

## Impact

- Provides a world-space flow where camera tracking, streamed maps, and collision-aware tile loading are coordinated through the game loop.
