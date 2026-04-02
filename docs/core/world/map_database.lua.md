# core/world/map_database.lua

## Purpose

Map database object that stores world maps by grid coordinate for lookup by the streaming manager.

## Current Behavior

- Stores maps in an internal table keyed by `x,y` grid strings.
- Rejects duplicate grid coordinates when adding a map.
- Returns a map instance directly from `get(x, y)` when present.

## API

- `MapDatabase:new()`
- `MapDatabase:add(map)`
- `MapDatabase:get(x, y)`

## Notes

- Intended to be populated by `core/world/world_data.lua`.
- Consumed by `core/world/map_manager.lua`.
