local Config = require("config")
local Input = require("engine.input")
local Keybindings = require("core.keybindings")
local Player = require("entity.player.player")

local MapManager = require("core.world.map_manager")
local WorldDB = require("core.world.world_data")

local Camera = require("core.camera")

local bump = require("lib.bump")

local Game = {}

function Game:load()
    love.window.setTitle(Config.window.title)
    love.window.setMode(
        Config.window.width,
        Config.window.height,
        {
            fullscreen = Config.window.fullscreen,
            vsync = Config.window.vsync
        }
    )

    self.input = Input:new()
    Keybindings.load(self.input)

    -- 🧱 BUMP WORLD (CRITICAL)
    self.world = bump.newWorld(16)

    -- player in world space
    self.player = Player.new(0, 0, Config.character)

    -- 🔥 PASS WORLD INTO MAP MANAGER
    self.map_manager = MapManager.new(WorldDB, self.world)

    self.camera = Camera.new()
end

function Game:update(dt)
    self.player:update(self.input, dt)

    -- 🔥 streaming + animation update
    self.map_manager:update(self.player, dt)

    -- camera follow
    self.camera:follow(self.player, dt)

    self.input:update()
end

function Game:draw()
    self.camera:apply()

    -- 🌍 world rendering (now real tiles, not rectangles)
    self.map_manager:draw_world()

    -- 👤 player
    self.player:draw()

    self.camera:clear()

    -- debug
    self.map_manager:draw()
end

return Game