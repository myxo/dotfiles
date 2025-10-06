local wezterm = require 'wezterm'
local config = {}

-- config.color_scheme = 'Batman'
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- it's kinda sucks, that mac keys don't work by default
local act = wezterm.action
config.keys = {
    { mods = "OPT",       key = "LeftArrow",  action = act.SendKey({ mods = "ALT", key = "b" }) },
    { mods = "OPT",       key = "RightArrow", action = act.SendKey({ mods = "ALT", key = "f" }) },
    { mods = "CMD",       key = "LeftArrow",  action = act.SendKey({ mods = "CTRL", key = "a" }) },
    { mods = "CMD",       key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
    { mods = "CMD",       key = "Backspace",  action = act.SendKey({ mods = "CTRL", key = "u" }) },
    { mods = "CMD|OPT",   key = "LeftArrow",  action = act.ActivateTabRelative(-1) },
    { mods = "CMD|OPT",   key = "RightArrow", action = act.ActivateTabRelative(1) },
    { mods = "CMD|SHIFT", key = "LeftArrow",  action = act.ActivateTabRelative(-1) },
    { mods = "CMD|SHIFT", key = "RightArrow", action = act.ActivateTabRelative(1) },
    { mods = "CMD",       key = "+",          action = act.IncreaseFontSize },
    { mods = "CMD",       key = "-",          action = act.DecreaseFontSize },
}

return config
