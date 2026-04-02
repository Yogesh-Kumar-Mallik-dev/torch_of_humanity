# core/world/world_data.lua

## Purpose

World data bootstrap module that creates the map database and registers the current set of world maps.

## Current Behavior

- Creates a new `MapDatabase` instance.
- Adds the center map and a northern neighbor as the initial world set.
- Returns the populated database for use by the game loop and map manager.

## Data Notes

- Each map is created through `core.world.map`.
- The data table currently includes id, grid, source, region, weather, BGM, and debug color fields.

## Dependencies

- `core.world.map`
- `core.world.map_database`

## Notes

- Acts as the world registry consumed by `core/game.lua`.
- Additional maps can be appended here without changing the streaming code.