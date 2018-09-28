
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    -- awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    -- awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "w", function () awful.screen.focus(1) end),
    awful.key({ modkey,           }, "e", function () awful.screen.focus(2) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    -- awful.key { modkey = {"Mod4"} key = "p" command = "spawn" arg = "exec `dmenu_path | dmenu -b`" },

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    -- awful.key({}, "#122", function () awful.util.spawn("amixer set Speaker 5%-") end),
    -- awful.key({}, "#123", function () awful.util.spawn("amixer set Speaker 5%+") end),
    awful.key({ modkey }, "p",          function() awful.util.spawn( "dmenu_run" ) end),
    awful.key({ }, "Pause",     function() awful.util.spawn( "xset dpms force off" ) end),
    -- awful.key({ modkey }, "z",  function() awful.util.spawn_with_shell( "subl ~/.config/awesome" ) end),
    awful.key({ }, "Print",     function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'") end),

    awful.key({ modkey }, "b", function ()
            mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        end),
    
    awful.key({ modkey, 'Shift' }, "f", function () awful.layout.set(awful.layout.suit.floating) end),

    awful.key({ modkey, 'Shift' }, "t", function () awful.layout.set(awful.layout.suit.tile) end),

    awful.key({ }, "XF86AudioRaiseVolume", function ()
            awful.util.spawn("amixer set Master 5%+", false) end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
            awful.util.spawn("amixer set Master 5%-", false) end),
    awful.key({ }, "XF86AudioMute", function ()
            awful.util.spawn("amixer -D pulse set Master toggle", false) end),

    -- awful.key({ modkey }, "F12", function () scratch.drop("x-terminal-emulator", "top", 1.0, 1.0, 0.4) end),
    -- awful.key({  }, "#78", function () scratch.drop("x-terminal-emulator", "top", "left", 1.0, 0.4) end),
    -- awful.key({  }, "#135", function () scratch.drop("x-terminal-emulator", "top", "left", 1.0, 0.4) end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)


)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    -- awful.key({ modkey,           }, "n",
    --     function (c)
    --         -- The client currently has the input focus, so it cannot be
    --         -- minimized, since minimized clients can't have the focus.
    --         c.minimized = true
    --     end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))
