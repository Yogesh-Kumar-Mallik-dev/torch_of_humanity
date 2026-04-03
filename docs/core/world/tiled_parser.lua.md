# core/world/tiled_parser.lua

## Purpose

Parses Tiled map and tileset JSON files into runtime Lua tables with normalized asset paths and decoded flip metadata.

## Current Behavior

- Normalizes map, tileset, and image paths into repository asset conventions.
- Parses tileset JSON files and indexes optional per-tile metadata by tile id.
- Parses tile layers and object layers from map JSON files.
- Decodes Tiled flip flags (horizontal, vertical, diagonal) from gid bit masks.
- Resolves each tile gid to the matching tileset and local tile id.

## API

- `TiledParser.parse_tileset(path)`
- `TiledParser.get_tileset(tile_id, tilesets)`
- `TiledParser.parse_map(path)`

## Dependencies

- `lib.json`

## Notes

- Input files are read via LÖVE filesystem APIs.
- Parser output is consumed by `core.world.tiled_loader`.