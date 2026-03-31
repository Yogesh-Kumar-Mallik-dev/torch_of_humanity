local Vector2 = require("engine.vector2")

local Direction = {}

-- =============================
-- Facing enum (clockwise)
-- =============================

Direction.facing = {
    none = 0,

    north = 1,
    northeast = 2,
    east = 3,
    southeast = 4,
    south = 5,
    southwest = 6,
    west = 7,
    northwest = 8,
}

local facing = Direction.facing

-- =============================
-- Facing --> Vector
-- =============================

local facing_to_vector = {
    [facing.none] = Vector2.ZERO,

    [facing.north] = Vector2.NORTH,
    [facing.northeast] = Vector2.NORTH_EAST,
    [facing.east] = Vector2.EAST,
    [facing.southeast] = Vector2.SOUTH_EAST,
    [facing.south] = Vector2.SOUTH,
    [facing.southwest] = Vector2.SOUTH_WEST,
    [facing.west] = Vector2.WEST,
    [facing.northwest] = Vector2.NORTH_WEST,
}

-- =============================
-- Vector --> Facing (FIXED Y)
-- =============================

local vector_to_facing = {
    [0] = {
        [0] = facing.none,
        [1] = facing.south,   -- FIXED
        [-1] = facing.north,  -- FIXED
    },
    [1] = {
        [0] = facing.east,
        [1] = facing.southeast,
        [-1] = facing.northeast,
    },
    [-1] = {
        [0] = facing.west,
        [1] = facing.southwest,
        [-1] = facing.northwest,
    }
}

-- =============================
-- Name Cache
-- =============================

local names = {
    [facing.none] = "none",

    [facing.north] = "north",
    [facing.northeast] = "north_east",
    [facing.east] = "east",
    [facing.southeast] = "south_east",
    [facing.south] = "south",
    [facing.southwest] = "south_west",
    [facing.west] = "west",
    [facing.northwest] = "north_west",
}

-- =============================
-- API
-- ============================

function Direction.vector(dir)
    return facing_to_vector[dir]
end
    
function Direction.name(dir)
    return names[dir]
end

function Direction.from_vector(vector)
    local sx = (vector.x > 0 and 1) or (vector.x < 0 and -1) or 0
    local sy = (vector.y > 0 and 1) or (vector.y < 0 and -1) or 0
    return vector_to_facing[sx][sy]
end

-- =============================
-- Rotation (clockwise system)
-- =============================

function Direction.rotate_cw(dir)
    if dir == facing.none then return facing.none end
    return (dir % 8) + 1
end

function Direction.rotate_acw(dir)
    if dir == facing.none then return facing.none end
    return (dir - 2) % 8 + 1
end

function Direction.opposite(dir)
    if dir == facing.none then return facing.none end
    return (dir + 3) % 8 + 1
end

return Direction