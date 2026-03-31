# engine/vector2.lua

Status: utility module expanded with directional constants, math helpers, and operators.

## Summary
- Added immutable predefined vectors: `ZERO`, cardinal directions, diagonal normalized directions, and aliases (`UP`, `DOWN`, `LEFT`, `RIGHT`, etc.).
- Added core methods for copy, normalization, length, distance, direction, dot product, angle, rotate, lerp, and clamping.
- Added operator overload support for vector arithmetic and comparisons.

## Feature Groups
- Constructors and constants:
	- `new`, `copy`, `ZERO`, `NORTH/SOUTH/EAST/WEST`, diagonals, direction aliases.
- Scalar and vector math:
	- `length`, `length_squared`, `normalize`, `normalized` (alias), `dot`, `angle`, `rotate`, `lerp`, `clamped`.
- Spatial relations:
	- `distance_to`, `distance_squared_to`, `direction_to`, `is_zero`.
- Operator overloads:
	- `__add` (`add`), `__sub` (`sub`), `__mul` (`mul`), `__div` (`div`), `__unm` (`negate`), `__eq` (`equals`).

## Impact
- Provides a complete reusable vector math primitive for movement, direction, and engine-level calculations.
