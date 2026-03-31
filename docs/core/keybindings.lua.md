# core/keybindings.lua

## Purpose

Defines default gameplay key-to-action bindings by loading mappings into the input system.

## API

### Keybindings.load(input)
Applies a standard set of controls using `input:bind(action, key)`.

## Default Bindings

Movement:
- `w` / `up` -> `move_up`
- `s` / `down` -> `move_down`
- `a` / `left` -> `move_left`
- `d` / `right` -> `move_right`

Combat and mobility:
- `space` -> `attack`
- `lshift` -> `dash`

UI/system actions:
- `x` -> `menu`
- `m` -> `map`
- `f` -> `interact`

Abilities:
- `1`..`0` -> `ability1`..`ability10`

## Notes

- Centralizes default controls in one module for easier future rebinding support.
- Uses action-first binding order consistent with `engine/input.lua`.
