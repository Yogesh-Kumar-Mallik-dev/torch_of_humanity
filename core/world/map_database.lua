local MapDatabase = {}
MapDatabase.__index = MapDatabase

local function key(x, y)
    return x .. "," .. y
end

function MapDatabase:new()
    return setmetatable({
        maps = {}
    }, MapDatabase)
end

function MapDatabase:add(map)
    local k = key(map.grid.x, map.grid.y)

    assert(not self.maps[k], "Duplicate map at " .. k)

    self.maps[k] = map
end

function MapDatabase:get(x, y)
    return self.maps[key(x, y)]
end

return MapDatabase