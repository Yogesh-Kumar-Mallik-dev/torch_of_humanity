local Keybindings = {}

function Keybindings.load(input)
  -- Movement (WASD)
  input:bind("move_up", "w")
  input:bind("move_down", "s")
  input:bind("move_left", "a")
  input:bind("move_right", "d")

  -- Movement (Arrow keys)
  input:bind("move_up", "up")
  input:bind("move_down", "down")
  input:bind("move_left", "left")
  input:bind("move_right", "right")

  -- Actions
  input:bind("attack", "space")
  input:bind("dash", "lshift")

  input:bind("menu", "x")
  input:bind("map", "m")
  input:bind("interact", "f")

  -- Abilities
  input:bind("ability1", "1")
  input:bind("ability2", "2")
  input:bind("ability3", "3")
  input:bind("ability4", "4")
  input:bind("ability5", "5")
  input:bind("ability6", "6")
  input:bind("ability7", "7")
  input:bind("ability8", "8")
  input:bind("ability9", "9")
  input:bind("ability10", "0")
end

return Keybindings