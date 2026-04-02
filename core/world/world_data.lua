-- world_data.lua
local Map = require("core.world.map")
local MapDatabase = require("core.world.map_database")

local db = MapDatabase:new()

db:add(Map:new({
    id = "center",
    name = "Central Plains",
    grid = {x = 0, y = 0},

    source = "maps/center.lua",

    region = "grassland",
    weathers = {"clear", "rain"},
    bgm = "plains_theme",

    color = {0.2, 0.2, 0.2}
}))

db:add(Map:new({
    id = "north",
    grid = {x = 0, y = -1},
    region = "mountain",
    weathers = {"snow"},
    bgm = "mountain_theme",
    color = {0.2, 0.4, 1}
}))

-- keep adding...

return db