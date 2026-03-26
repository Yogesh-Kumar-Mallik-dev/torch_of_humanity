-- =========================================
-- VECTOR2 CLASS
-- =========================================

local Vector2 = {}
Vector2.__index = Vector2

-- =========================================
-- CONSTRUCTOR
-- Creates a new vector
-- =========================================
function Vector2.new(x, y)
    local self = setmetatable({
        x = x or 0,
        y = y or 0,
    }, Vector2)

    return self
end

-- =========================================
-- STRING REPRESENTATION
-- =========================================
function Vector2:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end

-- =========================================
-- LOCK FUNCTION (IMMUTABLE VECTOR)
-- Prevents modification of vector
-- =========================================
local function lock(vector)
    return setmetatable({}, {
        __index = vector,

        __newindex = function()
            error("Attempt to modify locked Vector2")
        end,

        __tostring = function()
            return tostring(vector)
        end,
    })
end


-- =========================================
-- Constants
-- Predefined vectors for common directions
-- =========================================

Vector2.ZERO = lock(Vector2.new(0, 0))

-- Cardinal directions (immutable)
Vector2.NORTH = lock(Vector2.new(0, -1))
Vector2.SOUTH = lock(Vector2.new(0, 1))
Vector2.WEST = lock(Vector2.new(-1, 0))
Vector2.EAST = lock(Vector2.new(1, 0))

-- Diagonal directions (immutable, normalized)
local INVT_SQRT2 = 1 / math.sqrt(2)

Vector2.NORTH_EAST = lock(Vector2.new(INVT_SQRT2, -INVT_SQRT2))
Vector2.NORTH_WEST = lock(Vector2.new(-INVT_SQRT2, -INVT_SQRT2))
Vector2.SOUTH_EAST = lock(Vector2.new(INVT_SQRT2, INVT_SQRT2))
Vector2.SOUTH_WEST = lock(Vector2.new(-INVT_SQRT2, INVT_SQRT2))

-- alias (Godot-style)
Vector2.UP = Vector2.NORTH
Vector2.DOWN = Vector2.SOUTH
Vector2.LEFT = Vector2.WEST
Vector2.RIGHT = Vector2.EAST

Vector2.UP_RIGHT = Vector2.NORTH_EAST
Vector2.UP_LEFT = Vector2.NORTH_WEST
Vector2.DOWN_RIGHT = Vector2.SOUTH_EAST
Vector2.DOWN_LEFT = Vector2.SOUTH_WEST

-- ========================================
-- Core Methods 
-- ========================================

function Vector2:copy()
    return Vector2.new(self.x, self.y)
end

function Vector2:is_zero()
    return self.x == 0 and self.y == 0
end

function Vector2:length()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector2:length_squared()
    return self.x * self.x + self.y * self.y
end

function Vector2:normalize()
    local len = self:length()
    if len > 0 then
        return Vector2.new(self.x / len, self.y / len)
    else
        return Vector2.ZERO
    end
end

function Vector2:distance_to(vector)
    return (self - vector):length()
end

function Vector2:distance_squared_to(vector)
    return (self - vector):length_squared()
end

function Vector2:direction_to(vector)
    return (vector - self):normalize()
end

function Vector2:dot(vector)
    return self.x * vector.x + self.y * vector.y
end

function Vector2:angle()
    return math.atan2(self.y, self.x)
end

function Vector2:rotate(angle)
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    return Vector2.new(
        self.x * cos - self.y * sin,
        self.x * sin + self.y * cos
    )
end

function Vector2:lerp(to, weight)
    return self + (to - self) * weight
end

function Vector2:clamped(max_length)
    local len = self:length()
    if len > max_length then
        return self:normalize() * max_length
    else
        return self
    end
end

-- =========================================
-- Operator Overloading
-- =========================================

function Vector2.__add(a, b)
    return Vector2.new(a.x + b.x, a.y + b.y)
end

function Vector2.__sub(a, b)
    return Vector2.new(a.x - b.x, a.y - b.y)
end

function Vector2.__mul(a, b)
    if type(a) == "number" then
        return Vector2.new(a * b.x, a * b.y)
    elseif type(b) == "number" then
        return Vector2.new(b * a.x, b * a.y)
    else
       return Vector2.new(a.x * b.x, a.y * b.y)
    end
end

function Vector2.__div(a, b)
    if type(b) == "number" then
        return Vector2.new(a.x / b, a.y / b)
    else
        return Vector2.new(a.x / b.x, a.y / b.y)
    end
end

function Vector2.__unm(a)
    return Vector2.new(-a.x, -a.y)
end

function Vector2.__eq(a, b)
    return a.x == b.x and a.y == b.y
end

return Vector2