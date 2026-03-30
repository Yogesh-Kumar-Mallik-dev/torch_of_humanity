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
    [facing.none] = Vector2.zero,

    [facing.north] = Vector2.NORTH,
    [facing.northeast] = Vector2.NORTHEAST,
    [facing.east] = Vector2.EAST,
    [facing.southeast] = Vector2.SOUTHEAST,
    [facing.south] = Vector2.SOUTH,
    [facing.southwest] = Vector2.SOUTHWEST,
    [facing.west] = Vector2.WEST,
    [facing.northwest] = Vector2.NORTHWEST,
}

-- =============================
-- Vector --> Facing
-- =============================

local vector_to_facing = {
    [0] = {
        [0] = facing.none,
        [1] = facing.north,
        [-1] = facing.south,
    },
    [1] = {
        [0] = facing.east,
        [1] = facing.northeast,
        [-1] = facing.southeast,
    },
    [-1] = {
        [0] = facing.west,
        [1] = facing.northwest,
        [-1] = facing.southwest,
    }
}

-- =============================
-- Name Cache
-- =============================

local names = {
    [facing.none] = "none",

    [facing.north] = "north",
    [facing.northeast] = "northeast",
    [facing.east] = "east",
    [facing.southeast] = "southeast",
    [facing.south] = "south",
    [facing.southwest] = "southwest",
    [facing.west] = "west",
    [facing.northwest] = "northwest",
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