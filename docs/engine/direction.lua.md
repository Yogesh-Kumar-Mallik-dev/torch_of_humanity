# engine/direction.lua

## Purpose

Direction utility module that maps between facing values and Vector2 directions, with clockwise rotation helpers.

## Facing System

`Direction.facing` defines a 9-state enum:

- `none`
- `north`, `northeast`, `east`, `southeast`
- `south`, `southwest`, `west`, `northwest`

Values are ordered clockwise for deterministic rotation operations.

## API

### `Direction.vector(dir)`
Returns the Vector2 constant for a facing value.

### `Direction.name(dir)`
Returns the string name for a facing value.

### `Direction.from_vector(vector)`
Converts a vector to its nearest discrete facing using sign-based normalization of `x` and `y`.

### `Direction.rotate_cw(dir)`
Returns the next clockwise facing. `none` remains `none`.

### `Direction.rotate_acw(dir)`
Returns the next anticlockwise facing. `none` remains `none`.

### `Direction.opposite(dir)`
Returns the opposite facing. `none` remains `none`.

## Dependencies

- `engine.vector2`

## Notes

- Uses lookup tables for constant-time conversions.
- Rotation logic assumes facings `1..8` in clockwise order.
- Uses `Vector2` constants with underscore naming (`NORTH_EAST`, `SOUTH_EAST`, `SOUTH_WEST`, `NORTH_WEST`).
- `from_vector` mapping is aligned with screen-space Y direction (`y < 0` maps north, `y > 0` maps south).
- `Direction.name` returns underscore-style diagonal labels to match constant naming.
