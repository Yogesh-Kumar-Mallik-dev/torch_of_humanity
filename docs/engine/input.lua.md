# engine/input.lua

## Purpose

Engine-level input abstraction module providing action-based key binding and state tracking with Signal event emission.

## Current State

- Module defines Input constructor, binding table, action state tracking,
  per-frame state snapshot logic, and key event handlers.
- Dependency: requires engine.signal for event dispatch.
- Module now returns `Input` at the end for proper `require(...)` consumption.

## API

### `Input.new()`
Creates a new Input system instance with empty bindings and action state tracking.

### `Input:bind(action, key)`
Binds an action name to a key through `self.bindings[key] = action`.
When first binding an action, initializes `self.actions[action]` with
`pressed` and `released` signals plus current/previous state.

### `Input:keypressed(key)` and `Input:keyreleased(key)`
LÖVE callbacks for keyboard events. Updates action state and attempts to emit signals.

Current behavior note:
- Signals are created under `self.actions[action]`, but emit calls currently
	use `self.pressed` and `self.released` fields, which are not initialized.

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

## Known Integration Issues

- Signal emission path references fields that are not currently initialized
	(`self.pressed` and `self.released`).
- Binding signature currently differs from caller usage in `core/keybindings.lua`.
