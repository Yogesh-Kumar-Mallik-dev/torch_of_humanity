-- =========================================
-- CONFIG MODULE
-- =========================================

local Config = {}

-- =========================================
-- GRAPHICS PRESETS
-- =========================================
Config.presets = {
    low = { width = 854, height = 480, scale = 1 },
    medium = { width = 1280, height = 720, scale = 2 },
    high = { width = 1920, height = 1080, scale = 3 },
    ultra = { width = 2560, height = 1440, scale = 4 },
}

-- =========================================
-- WINDOW SETTINGS
-- =========================================
Config.window = {
    title = "Torch of Humanity",
    width = 0,
    height = 0,
    fullscreen = false,
    vsync = true,
}

-- =========================================
-- TILE SETTINGS
-- =========================================
Config.tile = {
    original_size = 16,
    scale = 1,
    render_size = 16,
}

-- =========================================
-- TITLE TEXT
-- =========================================
Config.title = {
    size = 16,
    render_size = 16,
    color = {1, 1, 1},
}

-- =========================================
-- CHARACTER SETTINGS
-- =========================================
Config.character = {
    tiles_per_second = 6,

    accel_time = 0.2,
    stop_time = 0.1,

    dash_distance_tiles = 3,
    dash_time = 0.15,

    original_size = 16,
    render_size = 16,
    scale = 1,

    -- computed
    max_speed = 0,
    acceleration = 0,
    friction = 0,
    dash_distance = 0,
    dash_speed = 0,
}

-- =========================================
-- WORLD SETTINGS
-- =========================================
Config.world = {
    tile_width = 0,
    tile_height = 0,
}

-- =========================================
-- VIRTUAL RESOLUTION
-- =========================================
Config.virtual = {
    width = 320,
    height = 180,
}

-- =========================================
-- APPLY GRAPHICS PRESET
-- =========================================
function Config:applyPresets(preset)
    self.current = preset

    -- Window
    self.window.width = preset.width
    self.window.height = preset.height

    -- Tile
    self.tile.scale = preset.scale
    self.tile.render_size = self.tile.original_size * self.tile.scale

    -- Title
    self.title.render_size = self.title.size * self.tile.scale

    -- Character scale
    self.character.scale = preset.scale
    self.character.render_size =
        self.character.original_size * self.character.scale

    -- =====================================
    -- MOVEMENT (tile-based)
    -- =====================================
    self.character.max_speed =
        self.character.tiles_per_second * self.tile.render_size

    self.character.acceleration =
        self.character.max_speed / self.character.accel_time

    self.character.friction =
        self.character.max_speed / self.character.stop_time

    -- =====================================
    -- DASH (distance-based)
    -- =====================================
    self.character.dash_distance =
        self.character.dash_distance_tiles * self.tile.render_size

    self.character.dash_speed =
        self.character.dash_distance / self.character.dash_time

    -- =====================================
    -- WORLD
    -- =====================================
    self.world.tile_width =
        math.floor(self.virtual.width / self.tile.render_size)

    self.world.tile_height =
        math.floor(self.virtual.height / self.tile.render_size)
end

-- Default preset
Config:applyPresets(Config.presets.medium)

return Config