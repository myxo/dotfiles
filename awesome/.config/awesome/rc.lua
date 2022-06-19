-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
local hotkeys_popup = require("awful.hotkeys_popup").widget
--local dbg = require("debugger")



-- Load Debian menu entries
require("debian.menu")

local config_path = awful.util.getdir("config") .. "/"

dofile(config_path .. "rc/errors.lua")

beautiful.init("/home/myxo/.config/awesome/themes/default/theme.lua")

terminal = os.getenv("TERMINAL") or "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
}


dofile(config_path .. "rc/bar.lua")
dofile(config_path .. "rc/keys.lua")
dofile(config_path .. "rc/rules.lua")
dofile(config_path .. "rc/signals.lua")
dofile(config_path .. "rc/start.lua")
-- dofile(config_path .. "rc/quake.lua")
