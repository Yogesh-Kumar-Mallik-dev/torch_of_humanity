# core/world/map_manager.lua

## Purpose

Runtime world streaming manager that loads and unloads map chunks around the player position.

## Current Behavior

- Stores a map database instance and a loaded-map cache keyed by grid coordinates.
- Uses config-driven chunk dimensions (`Config.world.chunk_width`, `Config.world.chunk_height`) for world partitioning.
- Computes the player's current grid cell from world position.
- Loads a dynamic 3x3 set of maps centered on the player cell.
- Calls `onLoad()` when a map enters the active window and `onUnload()` when it leaves.
- Draws all loaded map chunks in world-space using each map color.
- Prints currently loaded grid keys for debug visibility.

## API

- `MapManager.new(map_database)`
- `MapManager:get_map_at(gx, gy)`
- `MapManager:update(player)`
- `MapManager:draw_world()`
- `MapManager:draw()`

## Notes

- Grid keys are encoded as `"x,y"` strings.
- Database maps are discovered by matching `map.grid.x` and `map.grid.y`.
- Missing grid lookups return `nil` explicitly.
