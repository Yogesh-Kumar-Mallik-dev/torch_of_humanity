# core/camera.lua

## Purpose

Minimal world camera utility that follows a target and applies/removes a world-to-screen transform.

## Current Behavior

- Stores camera world position (`x`, `y`).
- Follows a target by reading `target.position.x` and `target.position.y`.
- Applies transform by translating the world so camera center aligns to screen center.
- Clears transform by restoring graphics stack.

## API

- `Camera.new()`
- `Camera:follow(target)`
- `Camera:apply()`
- `Camera:clear()`

## Dependencies

- LÖVE graphics APIs: `love.graphics.push`, `love.graphics.translate`, `love.graphics.pop`, `love.graphics.getWidth`, `love.graphics.getHeight`

## Notes

- Intended for world-space drawing before UI/debug overlays.
