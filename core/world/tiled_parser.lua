local json = require("lib.json")

local TiledParser = {}

-- =========================================
-- PATH NORMALIZER
-- =========================================
local function normalize_path(path, type)
    if not path then return nil end

    path = path:gsub("\\", "/")
    path = path:gsub("^assets/", "")

    path = path:gsub("%.tmx$", ".tmj")
    path = path:gsub("%.tsx$", ".tsj")

    local rules_index = path:find("Tilemap/Rules/")
    if rules_index then
        return "assets/" .. path:sub(rules_index)
    end

    if type == "tileset" then
        return "assets/Tileset/" .. path:match("([^/]+)$")
    end

    if type == "image" then
        local art_index = path:find("Art/")
        if art_index then
            return "assets/" .. path:sub(art_index)
        end
        return "assets/Art/" .. path:match("([^/]+)$")
    end

    if type == "map" then
        return "assets/Tilemap/" .. path:match("([^/]+)$")
    end

    return path
end

-- =========================================
-- TILESET
-- =========================================
function TiledParser.parse_tileset(path)
    path = normalize_path(path, "tileset")

    local raw = love.filesystem.read(path)
    assert(raw, "Failed to load tileset: " .. path)

    local data = json.decode(raw)

    local tiles = {}
    if data.tiles then
        for _, tile in ipairs(data.tiles) do
            tiles[tile.id] = tile
        end
    end

    return {
        image = normalize_path(data.image, "image"),
        columns = data.columns,
        tilewidth = data.tilewidth,
        tileheight = data.tileheight,
        tilecount = data.tilecount,
        tiles = tiles
    }
end

function TiledParser.get_tileset(tile_id, tilesets)
    for i = #tilesets, 1, -1 do
        if tile_id >= tilesets[i].firstgid then
            return tilesets[i]
        end
    end
end

-- =========================================
-- MAP (WITH FULL FLIP SUPPORT)
-- =========================================
function TiledParser.parse_map(path)
    path = normalize_path(path, "map")

    local raw = love.filesystem.read(path)
    assert(raw, "Failed to load map: " .. path)

    local data = json.decode(raw)

    local tilesets = {}
    for _, ts in ipairs(data.tilesets) do
        local parsed = TiledParser.parse_tileset(ts.source)
        parsed.firstgid = ts.firstgid
        table.insert(tilesets, parsed)
    end

    local map = {
        width = data.width,
        height = data.height,
        tilewidth = data.tilewidth,
        tileheight = data.tileheight,
        tilesets = tilesets,
        layers = {}
    }

    -- FLIP FLAGS
    local FLIP_H = 0x80000000
    local FLIP_V = 0x40000000
    local FLIP_D = 0x20000000
    local CLEAR = 0x1FFFFFFF

    for _, layer in ipairs(data.layers) do
        if layer.type == "tilelayer" then
            local tiles = {}

            for i, tile in ipairs(layer.data) do
                if tile ~= 0 then
                    local flip_h = (tile & FLIP_H) ~= 0
                    local flip_v = (tile & FLIP_V) ~= 0
                    local flip_d = (tile & FLIP_D) ~= 0

                    local clean = tile & CLEAR

                    local ts = TiledParser.get_tileset(clean, tilesets)
                    local id = clean - ts.firstgid

                    local x = ((i - 1) % map.width) * map.tilewidth
                    local y = math.floor((i - 1) / map.width) * map.tileheight

                    table.insert(tiles, {
                        id = id,
                        x = x,
                        y = y,
                        tileset = ts,
                        data = ts.tiles[id],

                        flip_h = flip_h,
                        flip_v = flip_v,
                        flip_d = flip_d
                    })
                end
            end

            table.insert(map.layers, { type = "tilelayer", tiles = tiles })
        elseif layer.type == "objectgroup" then
            table.insert(map.layers, {
                type = "objectgroup",
                objects = layer.objects or {}
            })
        end
    end

    return map
end

return TiledParser