local Camera = {}
Camera.__index = Camera

function Camera.new()
    return setmetatable({x=0,y=0}, Camera)
end

function Camera:follow(target)
    self.x = target.position.x
    self.y = target.position.y
end

function Camera:apply()
    love.graphics.push()
    love.graphics.translate(
        -self.x + love.graphics.getWidth()/2,
        -self.y + love.graphics.getHeight()/2
    )
end

function Camera:clear()
    love.graphics.pop()
end

return Camera