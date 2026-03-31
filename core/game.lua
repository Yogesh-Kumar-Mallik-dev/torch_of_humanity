local Config = require("config")
local Input = require("engine.input")
local Keybindings = require("core.keybindings")

local Game = {}

function Game:load()
    -- Window setup (FIXED)
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

    -- TEMP: basic state (so game doesn't crash)
    self.state = {
        update = function(_, dt, input)
            -- placeholder
        end,
        draw = function()
            love.graphics.print("Game Running ✅", 20, 20)
        end
    }
end

function Game:update(dt)
    self.state:update(dt, self.input)
    self.input:update()
end

function Game:draw()
    self.state:draw()
end

return Game