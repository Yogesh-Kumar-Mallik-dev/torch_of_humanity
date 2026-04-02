local Config = require("config")

local MapManager = {}
MapManager.__index = MapManager

function MapManager.new(database)
    local self = setmetatable({}, MapManager)

    self.database = database
    self.loaded = {}

    self.map_w = Config.world.chunk_width
    self.map_h = Config.world.chunk_height

    return self
end

-- =============================
-- O(1) lookup
-- =============================
function MapManager:get_map_at(gx, gy)
    return self.database:get(gx, gy)
end

-- =============================
-- Update (3x3 streaming)
-- =============================
function MapManager:update(player)
    local px = player.position.x
    local py = player.position.y

    local cx = math.floor(px / self.map_w)
    local cy = math.floor(py / self.map_h)

    local needed = {}

    for dx = -1, 1 do
        for dy = -1, 1 do
            local gx = cx + dx
            local gy = cy + dy

            local map = self:get_map_at(gx, gy)

            if map then
                local key = gx .. "," .. gy
                needed[key] = true

                if not self.loaded[key] then
                    map:onLoad()
                    self.loaded[key] = map
                end
            end
        end
    end

    -- unload unused
    for key, map in pairs(self.loaded) do
        if not needed[key] then
            map:onUnload()
            self.loaded[key] = nil
        end
    end
end

-- =============================
-- Draw world
-- =============================
function MapManager:draw_world()
    for _, map in pairs(self.loaded) do
        local x = map.grid.x * self.map_w
        local y = map.grid.y * self.map_h

        love.graphics.setColor(map.color)
        love.graphics.rectangle("fill", x, y, self.map_w, self.map_h)
    end

    love.graphics.setColor(1,1,1)
end

-- =============================
-- Debug
-- =============================
function MapManager:draw()
    local y = 20
    love.graphics.print("Loaded maps:", 20, y)
    y = y + 20

    for k, map in pairs(self.loaded) do
        love.graphics.print(k .. " (" .. map.id .. ")", 20, y)
        y = y + 20
    end
end

return MapManager