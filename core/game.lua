local Config = require("config")
local Input = require("engine.input")
local Keybindings = require("core.keybindings")
local Player = require("entity.player.player")

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

    -- Input
    self.input = Input:new()
    Keybindings.load(self.input)

    -- 🔥 CREATE PLAYER (REAL GAME STARTS HERE)
    self.player = Player.new(
        Config.window.width / 2,
        Config.window.height / 2,
        Config.character
    )
end

function Game:update(dt)
    -- 🔥 UPDATE PLAYER
    self.player:update(self.input, dt)

    self.input:update()
end

function Game:draw()
    -- 🔥 DRAW PLAYER
    self.player:draw()
end

return Game