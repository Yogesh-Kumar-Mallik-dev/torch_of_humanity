# core/world/map.lua

## Purpose

Map record module that wraps identity, grid position, metadata, and runtime load state for a world region.

## Constructor

`Map:new(data)` creates a map instance from a data table containing at least `id` and `grid`.

## Current Behavior

- Stores map identity fields such as `id` and optional `name`.
- Stores `grid` coordinates as a `{ x, y }` table.
- Carries optional source, region, weather, BGM, and debug color metadata.
- Tracks runtime load state with `loaded` and `entities`.
- Provides lifecycle hooks for future load/unload behavior.

## API

- `Map:new(data)`
- `Map:onLoad()`
- `Map:onUnload()`

## Notes

- The module is designed for map streaming and future entity population.
- `onLoad()` initializes an empty entity table; `onUnload()` clears it.