local MapManager = {}
MapManager.__index = MapManager

function MapManager.new(database)
    local self = setmetatable({}, MapManager)

    self.database = database
    self.loaded = {}

    self.map_w = 320
    self.map_h = 180

    return self
end

-- =============================
-- Helper
-- =============================

local function key(x, y)
    return x .. "," .. y
end

-- =============================
-- Find map from grid
-- =============================

function MapManager:get_map_at(gx, gy)
    for _, map in pairs(self.database) do
        if map.grid and map.grid.x == gx and map.grid.y == gy then
            return map
        end
    end
end

-- =============================
-- Update (dynamic 3x3 loading)
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
                local k = key(gx, gy)
                needed[k] = true

                if not self.loaded[k] then
                    self.loaded[k] = {
                        data = map,
                        gx = gx,
                        gy = gy
                    }
                end
            end
        end
    end

    -- unload far maps
    for k, _ in pairs(self.loaded) do
        if not needed[k] then
            self.loaded[k] = nil
        end
    end
end

-- =============================
-- Draw ALL loaded maps
-- =============================

function MapManager:draw_world()
    for _, map in pairs(self.loaded) do
        local x = map.gx * self.map_w
        local y = map.gy * self.map_h

        love.graphics.setColor(map.data.color)
        love.graphics.rectangle("fill", x, y, self.map_w, self.map_h)
    end

    love.graphics.setColor(1,1,1)
end

-- Debug
function MapManager:draw()
    local y = 20
    love.graphics.print("Loaded maps:", 20, y)
    y = y + 20

    for k, _ in pairs(self.loaded) do
        love.graphics.print(k, 20, y)
        y = y + 20
    end
end

return MapManager