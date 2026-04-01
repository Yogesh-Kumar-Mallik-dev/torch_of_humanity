# core/world/map_database.lua

## Purpose

Static data-based world map table used by the map manager for grid lookup and rendering metadata.

## Current Behavior

- Defines map records keyed by map id.
- Includes per-map `id`, `color`, and `grid` coordinates.
- Provides center, cardinal, and diagonal map entries around `(0, 0)`.

## Data Shape

Each map entry follows:

- `id`: unique map identifier
- `color`: RGB table used for background rendering
- `grid`: table with `x` and `y` integer coordinates

## Notes

- Serves as the source of truth for data-driven map placement.
- Consumed by `core/world/map_manager.lua`.
