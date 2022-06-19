local awful = require("awful")

local quake = require("quake")

local quakeconsole = {}
for s = 1, screen.count() do
   quakeconsole[s] = quake({ terminal = terminal,
                             argname = "--name %s --profile=quake",
			     height = 0.3,
			     screen = s })
end

globalkeys = awful.util.table.join(
   globalkeys,
   awful.key({ modkey }, "`",
	     function () quakeconsole[mouse.screen]:toggle() end))
