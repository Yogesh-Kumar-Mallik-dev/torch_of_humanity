local Vector2 = require("engine.vector2")
local Direction = require("engine.direction")
local Signal = require("engine.signal")

local Movement = {}
Movement.__index = Movement

-- ========================
-- EASING FUNCTION
-- ========================
local function ease_out_cubic_inverse(t)
  return (1 - t) ^ 3
end

-- ========================
-- Constructor
-- ========================
function Movement.new(config)
  local self = setmetatable({}, Movement)

  self.max_speed   = config.max_speed
  self.acceleration = config.acceleration
  self.friction     = config.friction

  -- Dash
  self.dash_speed    = config.dash_speed
  self.dash_distance = config.dash_distance
  self.dash_cooldown = 0.5

  self.dashing = false
  self.cooldown = 0
  self.dash_dir = Vector2.new(0, 0)
  self.dash_traveled = 0

  -- Control states
  self.control = {
    stunned = false,
    frozen = false,
    knockback = {
      active = false,
      velocity = Vector2.new(0, 0),
      timer = 0
    }
  }

  self.facing_signal = Signal.new()

  return self
end

-- ========================
-- Controls
-- ========================
function Movement:apply_stun(state)
  self.control.stunned = state
end

function Movement:apply_freeze(state)
  self.control.frozen = state
end

function Movement:apply_knockback(dir, force, duration)
  self.control.knockback.active = true
  self.control.knockback.velocity = Vector2.new(dir.x, dir.y) * force
  self.control.knockback.timer = duration
end

-- ========================
-- Input Direction
-- ========================
function Movement:get_input_direction(input)
  local up    = input:is_action_pressed("move_up")
  local down  = input:is_action_pressed("move_down")
  local left  = input:is_action_pressed("move_left")
  local right = input:is_action_pressed("move_right")

  if up and down then up, down = false, false end
  if left and right then left, right = false, false end

  if up and right then return Vector2.UP_RIGHT
  elseif up and left then return Vector2.UP_LEFT
  elseif down and right then return Vector2.DOWN_RIGHT
  elseif down and left then return Vector2.DOWN_LEFT
  elseif up then return Vector2.UP
  elseif down then return Vector2.DOWN
  elseif right then return Vector2.RIGHT
  elseif left then return Vector2.LEFT end

  return Vector2.ZERO
end

-- ========================
-- Update
-- ========================
function Movement:update(entity, input, dt)
  local raw_dir = self:get_input_direction(input)
  local dir = Vector2.new(raw_dir.x, raw_dir.y)

  -- ========================
  -- CONTROL PRIORITY
  -- ========================
  if self.control.frozen or self.control.stunned then
    entity.velocity = Vector2.new(0, 0)
    self.facing_signal:emit(self,
      self.control.frozen and "frozen" or "stunned",
      entity.facing
    )
    return
  end

  -- Knockback
  local kb = self.control.knockback
  if kb.active then
    kb.timer = kb.timer - dt

    entity.velocity = kb.velocity
    entity.position = entity.position + entity.velocity * dt

    if kb.timer <= 0 then
      kb.active = false
    end

    local facing = Direction.from_vector(entity.velocity)
    entity.facing = facing

    self.facing_signal:emit(self, "knockback", facing)
    return
  end

  -- Cooldown
  if self.cooldown > 0 then
    self.cooldown = self.cooldown - dt
  end

  -- Dash trigger
  if input:is_action_just_pressed("dash") and self.cooldown <= 0 then
    self.dashing = true
    self.cooldown = self.dash_cooldown
    self.dash_traveled = 0

    if not dir:is_zero() then
      self.dash_dir = dir
    else
      local f = Direction.vector(entity.facing)
      self.dash_dir = Vector2.new(f.x, f.y)
    end
  end

  local state = "idle"

  -- ========================
  -- DASH (distance + easing)
  -- ========================
  if self.dashing then
    state = "dashing"

    local t = self.dash_traveled / self.dash_distance
    t = math.min(t, 1)

    local speed_factor = ease_out_cubic_inverse(t)
    local current_speed = self.dash_speed * speed_factor

    -- optional minimum speed (prevents sticky end)
    local min_speed = self.dash_speed * 0.2
    current_speed = math.max(current_speed, min_speed)

    local movement = self.dash_dir * current_speed * dt
    local distance_step = movement:length()

    entity.velocity = self.dash_dir * current_speed
    entity.position = entity.position + movement

    self.dash_traveled = self.dash_traveled + distance_step

    if self.dash_traveled >= self.dash_distance then
      self.dashing = false
      self.dash_traveled = 0
    end

    local facing = Direction.from_vector(entity.velocity)
    entity.facing = facing

    self.facing_signal:emit(self, state, facing)
    return
  end

  -- ========================
  -- NORMAL MOVEMENT
  -- ========================
  if not dir:is_zero() then
    state = "moving"

    local target_velocity = dir * self.max_speed
    local delta = target_velocity - entity.velocity
    local accel_step = self.acceleration * dt

    if delta:length() > accel_step then
      delta = delta:normalized() * accel_step
    end

    entity.velocity = entity.velocity + delta

  else
    local speed = entity.velocity:length()

    if speed > 0 then
      local drop = self.friction * dt
      speed = math.max(speed - drop, 0)

      if speed == 0 then
        entity.velocity = Vector2.new(0, 0)
      else
        entity.velocity = entity.velocity:normalized() * speed
      end
    end
  end

  -- Clamp
  entity.velocity = entity.velocity:clamped(self.max_speed)

  -- Apply movement
  entity.position = entity.position + entity.velocity * dt

  -- Facing
  if not entity.velocity:is_zero() then
    entity.facing = Direction.from_vector(entity.velocity)
  end

  self.facing_signal:emit(self, state, entity.facing)
end

return Movement