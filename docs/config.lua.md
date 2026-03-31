# config.lua

Status: configured and initialized.

## Summary
- Added centralized `Config` module for game-wide settings.
- Defined graphics presets: `low`, `medium`, `high`, `ultra`.
- Added window, tile, title, character, world, and virtual resolution sections.
- Implemented `Config:applyPresets(preset)` to propagate scaling and derived values.
- Switched character movement tuning to tile-based inputs (`tiles_per_second`, `accel_time`, `stop_time`) with computed runtime values.
- Added tile-based dash tuning (`dash_distance_tiles`, `dash_time`) with computed runtime values (`dash_distance`, `dash_speed`).
- Applied default preset with `Config:applyPresets(Config.presets.medium)`.

## Key Fields
- `Config.window`: title, resolution, fullscreen, vsync.
- `Config.tile`: base tile size, runtime scale, render size.
- `Config.title`: base font size and scaled render size.
- `Config.character`: tile-based movement and dash controls plus computed `max_speed`, `acceleration`, `friction`, `dash_distance`, and `dash_speed` derived during preset application.
- `Config.world`: computed visible tile counts from virtual size and tile render size.
- `Config.virtual`: fixed virtual resolution for pixel-perfect flow.

## Impact
- Establishes a single source of truth for resolution, scaling behavior, and character movement derivation across presets.
