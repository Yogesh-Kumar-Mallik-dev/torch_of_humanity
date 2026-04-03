# core/world/tiled_loader.lua

## Purpose

Loads parsed Tiled maps into runtime render structures, caches tileset images, and handles animated tile drawing.

## Current Behavior

- Loads map data through `core.world.tiled_parser`.
- Caches image assets per path to avoid duplicate `newImage` loads.
- Builds static and animated tile render lists from tile layers.
- Updates animated tile frame progression using frame duration metadata.
- Draws tiles with support for horizontal, vertical, and diagonal flip flags.

## API

- `TiledLoader.load(path)`
- `TiledLoader.build_render(map)`
- `TiledLoader.update(map, dt)`
- `TiledLoader.draw(map, x, y)`

## Notes

- Collision build is delegated from map load flow via loader helper integration.
- Flip handling is applied at draw time per tile entry.