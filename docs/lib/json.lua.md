# lib/json.lua

## Purpose

Standalone JSON encode/decode utility used by runtime systems that load structured data files.

## Current Behavior

- Encodes Lua primitives, arrays, and object-like tables to JSON.
- Rejects circular references, sparse arrays, and invalid key type mixes.
- Decodes JSON strings into Lua values with unicode escape handling.
- Reports parse errors with line/column details.

## API

- `json.encode(value)`
- `json.decode(string)`

## Notes

- Used by tiled parsing modules for map and tileset JSON content.
- Treats Lua `nil` as JSON `null` in encode/decode flow.