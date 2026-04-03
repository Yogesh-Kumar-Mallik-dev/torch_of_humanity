# core/world/map.lua

## Purpose

Map record module that wraps identity, grid position, metadata, and runtime load state for a world region.

## Constructor

`Map:new(data)` creates a map instance from a data table containing at least `id` and `grid`.

## Current Behavior

- Stores map identity fields such as `id` and optional `name`.
- Stores `grid` coordinates as a `{ x, y }` table.
- Carries optional source, region, weather, BGM, and debug color metadata.
- Tracks runtime load state with `loaded`, `entities`, and parsed tiled map data.
- Loads tiled map data on demand and builds render/collision structures.
- Advances animated tile state during update.
- Draws loaded tile layers at world chunk offsets.

## API

- `Map:new(data)`
- `Map:onLoad(world)`
- `Map:onUnload()`
- `Map:update(dt)`
- `Map:draw(map_w, map_h)`

## Notes

- The module is designed for map streaming and future entity population.
- Tiled loading activates when `source` points to a `.json` map resource path.
- `onLoad()` initializes entities and map runtime data; `onUnload()` clears both.