require("calendar2")
vicious = require("vicious")

function isnan(n) return tostring(n) == '-1.#IND' end

function colorize(val, low, high, col1, col2, col3)
    val = val or 0
    if isnan(val) then val = 0 end
    low = low or 5
    high = high or 80
    col1 = col1 or '#ddddff'
    col2 = col2 or '#0CEB1B'
    col3 = col3 or 'red'

    int_val = tonumber(val)
    color_ = col2
    if int_val < low then
        color_ = col1
    end

    if int_val > high then 
        color_ = col3
    end
    return '<span color="' .. color_ .. '">' .. val .. '</span>'
end


separator = widget({ type = "textbox" })
separator.text  = ' <span color="#FF00FF">|</span> '

memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, 
        function (widget, args)
            return "Mem: " .. colorize(args[1], 80, 90) .. "%"-- .. colorize(args[5], 70, 90) .. "%"
        end, 13)

wifiwidget = widget({ type = "textbox" })
vicious.register(wifiwidget, vicious.widgets.wifi, "wlan: ${ssid} ${linp}%", 10, "wlan0")

weatherwidget = widget({ type = "textbox" })
vicious.register(weatherwidget, vicious.widgets.weather, "SPb: ${tempc}C", 123, "ULLI")

-- weather2widget = widget({ type = "textbox" })
-- weather.addWeather(weather2widget, "moscow", 3600)

cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, 
        function (widget, args)
            return "cpu: " .. colorize(args[2]) .. " " .. colorize(args[3]) .. " " .. colorize(args[4]) .. " " .. colorize(args[5])
        end, 4)

tempwidget = widget({ type = "textbox" })
vicious.register(tempwidget, vicious.widgets.thermal, " $1C", 7, "thermal_zone0")

batwidget = widget({ type = "textbox" })
-- vicious.register(batwidget, vicious.widgets.bat, "bat: $2% $3", 11, "BAT0")
vicious.register(batwidget, vicious.widgets.bat, 
        function (widget, args)
            return "bat: " .. colorize(args[2], 10, 20, 'red', 'green', '#ddddff') .. "% " .. args[3]
        end, 11, "BAT0")

mytextclock = awful.widget.textclock({ align = "right" }, "<span color='orange'>%a %d %b, %H:%M:%S </span>", 1)
calendar2.addCalendarToWidget(mytextclock, "<span color='red'>%s</span>")

mysystray = widget({ type = "systray" })


kbdwidget = widget({type = "textbox", name = "kbdwidget"})
kbdwidget.border_color = beautiful.fg_normal
kbdwidget.text = "Eng"

dbus.request_name("session", "ru.gentoo.kbdd") 
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'") 
dbus.add_signal("ru.gentoo.kbdd", function(...) 
    local data = {...} 
    local layout = data[2] 
    lts = {[0] = "Eng", [1] = "Рус"} 
    kbdwidget.text = ""..lts[layout].."" 
    end 
) 

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
        awful.button({ }, 1, awful.tag.viewonly),
        awful.button({ modkey }, 1, awful.client.movetotag),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, awful.client.toggletag),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
        )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
         awful.button({ }, 1, function (c)
                      if c == client.focus then
                            -- c.minimized = true
                      else
                          if not c:isvisible() then
                              awful.tag.viewonly(c:tags()[1])
                          end
                          -- This will also un-minimize
                          -- the client, if needed
                          client.focus = c
                          c:raise()
                      end
                end),
                awful.button({ }, 3, function ()
                    if instance then
                        instance:hide()
                        instance = nil
                    else
                        instance = awful.menu.clients({ width=250 })
                    end
                end)
                 -- awful.button({ }, 4, function ()
                 --              awful.client.focus.byidx(1)
                 --              if client.focus then client.focus:raise() end
                 --  end),
                 -- awful.button({ }, 5, function ()
                 --              awful.client.focus.byidx(-1)
                 --              if client.focus then client.focus:raise() end
                 --  end)
    )

for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
               awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
               awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
               awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
               awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(
        function(c)
                local task = { awful.widget.tasklist.label.currenttags(c, s) }
                if c == client.focus then
                    return task[1], task[2], task[3], task[4]
                else
                    return '', task[2], task[3], task[4]
                end
        end, mytasklist.buttons)

    mywibox[s] = awful.wibox({ position = "top", screen = s })
    mywibox[s].widgets = {
        {
            mylauncher,
            mylayoutbox[s],
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        s == 1 and mysystray or nil,
        mytextclock, separator,
        weatherwidget, separator,
        wifiwidget, separator,
        batwidget, separator,
        memwidget, separator,
        tempwidget, 
        cpuwidget, separator, 
        kbdwidget, separator,
        -- separator, netwidget, separator,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}
