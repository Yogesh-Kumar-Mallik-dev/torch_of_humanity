local Loader = require("core.world.tiled_loader")

local Map = {}
Map.__index = Map

function Map:new(data)
    assert(data.id, "Map must have id")
    assert(data.grid, "Map must have grid")

    return setmetatable({
        id = data.id,
        name = data.name or data.id,

        grid = {
            x = data.grid.x,
            y = data.grid.y
        },

        source = data.source,

        region = data.region or "default",
        weathers = data.weathers or {"clear"},
        bgm = data.bgm or nil,

        color = data.color or {1,1,1},

        loaded = false,
        entities = nil,

        map = nil -- 🔥 runtime tiled data
    }, Map)
end

function Map:onLoad(world)
    self.loaded = true
    self.entities = {}

    if self.source and self.source:match("%.json$") then
        self.map = Loader.load(self.source)

        Loader.build_render(self.map)
        Loader.build_collision(self.map, world)
    end
end

function Map:onUnload()
    self.loaded = false
    self.entities = nil
    self.map = nil
end

function Map:update(dt)
    if self.map then
        Loader.update(self.map, dt)
    end
end

function Map:draw(map_w, map_h)
    if not self.map then return end

    local base_x = self.grid.x * map_w
    local base_y = self.grid.y * map_h

    Loader.draw(self.map, base_x, base_y)
end

return Map