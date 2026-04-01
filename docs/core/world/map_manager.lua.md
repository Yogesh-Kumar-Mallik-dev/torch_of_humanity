# core/world/map_manager.lua

## Purpose

Runtime world streaming manager that loads and unloads map chunks around the player position.

## Current Behavior

- Stores map database and a loaded-map cache keyed by grid coordinates.
- Uses fixed chunk dimensions (`map_w = 320`, `map_h = 180`) for world partitioning.
- Computes player's current grid cell from world position.
- Loads a dynamic 3x3 set of maps centered on the player cell.
- Unloads maps that leave the required 3x3 window.
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
