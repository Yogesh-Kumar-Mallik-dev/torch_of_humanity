# Torch of Humanity

Torch of Humanity is a 2D game project built with Lua and LOVE (Love2D).
The repository currently includes engine modules, movement/component systems,
input mapping, and configuration scaffolding for a pixel-art focused action game.

## Current Repository State (2026-03-31)

Implemented modules:

- Runtime bootstrap in main.lua
- Global configuration and preset scaling in config.lua
- Input bindings in core/keybindings.lua
- Movement component in components/movement.lua
- Engine utilities:
	- engine/vector2.lua
	- engine/signal.lua
	- engine/input.lua
	- engine/direction.lua
- Third-party libs in lib/ (anim8, bump, STI, wrappers)

Current integration blockers:

- core/game.lua is still empty, but main.lua expects Game:load, Game:update,
	Game:draw, and Game.input.
- engine/input.lua currently stores action signals in self.actions[action], but
	key events emit via self.pressed/self.released.
- engine/input.lua currently has no return Input at file end.
- core/keybindings.lua calls input:bind(key, action), while engine/input.lua
	defines Input:bind(action, key).
- engine/direction.lua currently references Vector2.zero and diagonal constants
	without underscores (for example Vector2.NORTHEAST).
- components/movement.lua currently calls :normalized(), but Vector2 exports
	:normalize().

## Requirements

- LOVE 11.x

Check installation:

```bash
love --version
```

## Run

From project root:

```bash
love .
```

Note: runtime boot may fail until the core/game.lua and input integration
blockers above are resolved.

## Repository Structure

```text
.
├── main.lua
├── config.lua
├── components/
│   └── movement.lua
├── core/
│   ├── game.lua
│   └── keybindings.lua
├── engine/
│   ├── direction.lua
│   ├── input.lua
│   ├── signal.lua
│   └── vector2.lua
├── lib/
├── docs/
├── CONTRIBUTING.md
└── LICENSE.md
```

## Configuration Highlights

config.lua includes:

- Resolution presets (low, medium, high, ultra)
- Virtual resolution and tile scaling
- Derived character movement values:
	- max_speed, acceleration, friction
	- dash_distance, dash_speed

## Contribution Standard

- Always use the .gitmessage template.
- Follow previous commit structure exactly.
- PRs that do not follow commit structure are auto-rejected.
- Mirror all meaningful code changes in docs/.

## License

This project uses a custom four-layer ownership model license.
See LICENSE.md for full terms.
