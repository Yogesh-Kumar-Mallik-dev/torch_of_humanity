# engine/input.lua

## Purpose

Engine-level input abstraction module providing action-based key binding and state tracking with Signal event emission.

## Current State

- Full Input class implementation with lifecycle and query API.
- Dependency: requires engine.signal for event dispatch.

## API

### `Input.new()`
Creates a new Input system instance with empty bindings and action state tracking.

### `Input:bind(action, key)`
Binds a string action name to a keyboard key. Creates Signal emitters for `pressed` and `released` events.

### `Input:keypressed(key)` and `Input:keyreleased(key)`
LÖVE callbacks for keyboard events. Updates action state and emits the corresponding Signal for connected listeners.

### Query Methods
- `is_action_pressed(action)`: Returns true if action is currently held down.
- `is_action_just_pressed(action)`: Returns true only on the first frame of press.
- `is_action_just_released(action)`: Returns true only on the first frame of release.

### `Input:update()`
Called each frame to snapshot current action state into previous state for frame-boundary queries.

## Architecture Notes

- Signal-based event emission allows decoupled gameplay code to listen to input changes.
- Action state is tracked separately from raw key bindings for abstraction.
- Frame-boundary detection supports frame-sensitive logic (e.g. jump input, menu transitions).
