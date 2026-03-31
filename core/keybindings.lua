local Keybindings = {}

function Keybindings.load(input)
  input:bind("w", "move_up")
  input:bind("s", "move_down")
  input:bind("a", "move_left")
  input:bind("d", "move_right")

  input:bind("up", "move_up")
  input:bind("down", "move_down")
  input:bind("left", "move_left")
  input:bind("right", "move_right")

  input:bind("space", "attack")
  input:bind("lshift", "dash")

  input:bind("x", "menu")
  input:bind("m", "map")

  input:bind("f", "interact")

  input:bind("1", "ability1")
  input:bind("2", "ability2")
  input:bind("3", "ability3")
  input:bind("4", "ability4")
  input:bind("5", "ability5")
  input:bind("6", "ability6")
  input:bind("7", "ability7")
  input:bind("8", "ability8")
  input:bind("9", "ability9")
  input:bind("0", "ability10")
end

return Keybindings