local Parser = require("core.world.tiled_parser")

local TiledLoader = {}
local Cache = {}

local function load_image(path)
    if not Cache[path] then
        Cache[path] = love.graphics.newImage(path) -- FIXED
    end
    return Cache[path]
end

function TiledLoader.load(path)
    local map = Parser.parse_map(path)

    for _, ts in ipairs(map.tilesets) do
        ts.image = load_image(ts.image)
    end

    return map
end

-- =========================================
-- DRAW TILE WITH FULL FLIP SUPPORT
-- =========================================
local function draw_tile(ts, quad, x, y, tile)
    local w = ts.tilewidth
    local h = ts.tileheight

    local sx, sy = 1, 1
    local r = 0
    local ox, oy = 0, 0

    if tile.flip_d then
        if tile.flip_h and tile.flip_v then
            r = math.pi
        elseif tile.flip_h then
            r = math.pi / 2
        elseif tile.flip_v then
            r = -math.pi / 2
        else
            r = math.pi / 2
            sy = -1
        end

        ox, oy = w / 2, h / 2

        love.graphics.draw(ts.image, quad,
            x + ox, y + oy,
            r, sx, sy,
            w / 2, h / 2
        )
    else
        if tile.flip_h then
            sx = -1
            ox = w
        end

        if tile.flip_v then
            sy = -1
            oy = h
        end

        love.graphics.draw(ts.image, quad,
            x, y,
            0,
            sx, sy,
            ox, oy
        )
    end
end

function TiledLoader.build_render(map)
    map.static_tiles = {}
    map.animated_tiles = {}

    for _, layer in ipairs(map.layers) do
        if layer.type == "tilelayer" then
            for _, tile in ipairs(layer.tiles) do
                local ts = tile.tileset
                local id = tile.id
                local data = tile.data

                local tx = (id % ts.columns) * ts.tilewidth
                local ty = math.floor(id / ts.columns) * ts.tileheight

                local quad = love.graphics.newQuad(
                    tx, ty,
                    ts.tilewidth, ts.tileheight,
                    ts.image:getDimensions()
                )

                if data and data.animation then
                    table.insert(map.animated_tiles, {
                        tile = tile,
                        frames = data.animation,
                        timer = 0,
                        current = 1
                    })
                else
                    table.insert(map.static_tiles, {
                        tile = tile,
                        quad = quad
                    })
                end
            end
        end
    end
end

function TiledLoader.update(map, dt)
    for _, anim in ipairs(map.animated_tiles) do
        anim.timer = anim.timer + dt * 1000
        local frame = anim.frames[anim.current]

        if anim.timer >= frame.duration then
            anim.timer = 0
            anim.current = anim.current % #anim.frames + 1
        end
    end
end

function TiledLoader.draw(map, x, y)
    -- static
    for _, entry in ipairs(map.static_tiles) do
        local t = entry.tile
        draw_tile(t.tileset, entry.quad, x + t.x, y + t.y, t)
    end

    -- animated
    for _, anim in ipairs(map.animated_tiles) do
        local t = anim.tile
        local frame = anim.frames[anim.current]

        local ts = t.tileset
        local id = frame.tileid

        local tx = (id % ts.columns) * ts.tilewidth
        local ty = math.floor(id / ts.columns) * ts.tileheight

        local quad = love.graphics.newQuad(
            tx, ty,
            ts.tilewidth, ts.tileheight,
            ts.image:getDimensions()
        )

        draw_tile(ts, quad, x + t.x, y + t.y, t)
    end
end

return TiledLoader