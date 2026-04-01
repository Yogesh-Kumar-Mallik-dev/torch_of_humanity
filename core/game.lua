local Config = require("config")
local Input = require("engine.input")
local Keybindings = require("core.keybindings")
local Player = require("entity.player.player")
local MapManager = require("core.world.map_manager")
local MapDB = require("core.world.map_database")
local Camera = require("core.camera")

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

    -- player now in world space
    self.player = Player.new(0, 0, Config.character)

    self.map_manager = MapManager.new(MapDB)
    self.camera = Camera.new()
end

function Game:update(dt)
    self.player:update(self.input, dt)

    -- 🔥 dynamic loading
    self.map_manager:update(self.player)

    -- camera
    self.camera:follow(self.player)

    self.input:update()
end

function Game:draw()
    self.camera:apply()

    self.map_manager:draw_world()
    self.player:draw()

    self.camera:clear()

    self.map_manager:draw()
end

return Game