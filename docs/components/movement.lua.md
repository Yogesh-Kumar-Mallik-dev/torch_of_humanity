# components/movement.lua

## Purpose

Movement component implementing directional movement, dash behavior, control-state overrides, and facing updates for entities.

## Dependencies

- `engine.vector2`
- `engine.direction`
- `engine.signal`

## Constructor

### `Movement.new(config)`
Initializes movement parameters from config:

- `max_speed`, `acceleration`, `friction`
- Dash parameters (`dash_speed`, `dash_distance`, `dash_cooldown`)
- Control flags (`stunned`, `frozen`) and knockback state
- `facing_signal` for movement/facing state notifications

## Control API

- `apply_stun(state)`
- `apply_freeze(state)`
- `apply_knockback(dir, force, duration)`

Control states are applied with priority over normal movement logic.

## Direction and Input

### `get_input_direction(input)`
Builds 8-way movement direction from action inputs:

- `move_up`, `move_down`, `move_left`, `move_right`
- Opposing directions cancel each other
- Returns Vector2 directional constants or zero vector

## Update Flow

### `update(entity, input, dt)`
Per-frame update pipeline:

1. Read input direction.
2. Apply control priority:
- frozen/stunned: stop movement and emit state.
- knockback: apply knockback velocity and facing.
3. Handle dash cooldown and trigger (`dash` action).
4. Execute distance-based dash with cubic ease-out speed falloff.
5. Execute standard movement with acceleration/friction when not dashing.
6. Clamp non-dash velocity to max speed.
7. Apply position integration.
8. Update facing from velocity.
9. Emit state and facing through `facing_signal`.

## Emitted States

- `idle`
- `moving`
- `dashing`
- `knockback`
- `frozen`
- `stunned`

## Notes

- Designed for tile-scaled movement values supplied by config.
- Uses signal-based state emission to keep movement consumers decoupled.
- Dash now completes by traveled distance instead of fixed timer duration.
