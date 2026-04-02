local Map = {}
Map.__index = Map

function Map:new(data)
    assert(data.id, "Map must have id")
    assert(data.grid, "Map must have grid")

    return setmetatable({

        -- =========================
        -- IDENTITY
        -- =========================
        id = data.id,
        name = data.name or data.id,

        -- =========================
        -- POSITION
        -- =========================
        grid = {
            x = data.grid.x,
            y = data.grid.y
        },

        -- =========================
        -- DATA SOURCE
        -- =========================
        source = data.source, -- tiled / procedural / table

        -- =========================
        -- GAMEPLAY
        -- =========================
        region = data.region or "default",
        weathers = data.weathers or {"clear"},
        bgm = data.bgm or nil,

        -- =========================
        -- DEBUG / TEMP
        -- =========================
        color = data.color or {1,1,1},

        -- =========================
        -- RUNTIME STATE
        -- =========================
        loaded = false,
        entities = nil,

    }, Map)
end

-- =========================
-- LIFECYCLE (future use)
-- =========================

function Map:onLoad()
    self.loaded = true
    self.entities = {}
end

function Map:onUnload()
    self.loaded = false
    self.entities = nil
end

return Map