# Torch of Humanity

Torch of Humanity is a 2D game project built with Lua and the LÖVE (Love2D) framework.
This repository currently contains the game bootstrap, engine utilities, and core configuration systems that will drive gameplay.

## Genre and Direction

- Engine: LÖVE 11.x
- Language: Lua
- Visual direction: pixel-art friendly rendering with virtual resolution + scaling presets
- Current phase: foundational architecture and systems scaffolding

## Current Status

The project is in active early development.

Implemented now:

- LÖVE runtime entry points in main.lua
- Centralized game configuration in config.lua
- Graphics presets (low/medium/high/ultra)
- Scaled tile/title/character sizing pipeline
- Utility modules in engine (Vector2 math, Signal event system)
- Included third-party libraries in lib (anim8, bump, STI, etc.)

In progress / next:

- Core gameplay orchestration in core/game.lua
- Player movement and world simulation
- Map loading, collisions, and content systems

## Requirements

- LÖVE 11.x installed

Check installation:

```bash
love --version
```

## Run the Game

From the project root:

```bash
love .
```

## Project Structure

```text
.
├── main.lua            # LÖVE callbacks and bootstrap
├── config.lua          # Global game settings and presets
├── core/
│   └── game.lua        # Main game orchestration (scaffold)
├── engine/
│   ├── signal.lua      # Lightweight event/signal system
│   └── vector2.lua     # 2D vector math helpers
├── lib/                # Bundled libraries (animation, collision, maps)
└── docs/               # Notes and module documentation
```

## Configuration Highlights

config.lua controls:

- Window size and title
- Virtual resolution
- Graphics quality presets
- Runtime-derived tile, title, and character render sizes

Default preset is medium. You can switch presets in code through Config:applyPresets(...).

## Development Notes

- Keep game-facing constants in config.lua to avoid hard-coded values.
- Use engine utilities for reusable logic (math/events).
- Place core gameplay flow inside core/game.lua.

## Contributing

Contributions are welcome as the game systems expand.

Suggested workflow:

1. Create a feature branch.
2. Implement focused, testable changes.
3. Always use the repository .gitmessage template when creating commits.
4. Refer to previous commits for exact message structure and formatting consistency.
5. Pull requests that do not follow this commit structure will be automatically rejected.
6. Update docs in docs/ when module behavior changes.
7. Open a pull request with a short summary and screenshots/gifs for visual changes.

## License

This project uses a custom 4-layer ownership license:

- Layer 1: Founder
- Layer 2: Core Team
- Layer 3: Contributors
- Layer 4: Community Users

See LICENSE for the full terms.
