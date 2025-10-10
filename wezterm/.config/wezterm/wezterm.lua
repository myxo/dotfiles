local wezterm = require 'wezterm'
local config = {}

-- Get the current appearance from macOS
local function get_appearance_theme()
    local appearance = wezterm.gui.get_appearance()
    if appearance == 'Dark' then
        return 'TokyoNight' -- Replace with your preferred dark theme
    elseif appearance == 'Light' then
        return 'default'    -- Replace with your preferred light theme
        -- return 'seoulbones_light' -- Replace with your preferred light theme
    else
        return 'default' -- Fallback theme
    end
end

config.color_scheme = get_appearance_theme()

-- config.color_scheme = 'Batman'
config.window_decorations = "RESIZE"
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 10

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
