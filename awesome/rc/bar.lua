local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local vicious = require("vicious")
local gears = require("gears")
local lain  = require("lain")
local calendar = require("awful.widget.calendar_popup")

local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")

local hotkeys_popup = require("awful.hotkeys_popup").widget


local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

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

function max(t)
    if #t == 0 then return nil, nil end
    local key, value = 1, t[1]
    for i = 2, #t do
        if value < t[i] then
            key, value = i, t[i]
        end
    end
    return value
end


-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end},
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end}
 }
 
 mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                     { "Debian", debian.menu.Debian_menu.Debian },
                                     { "open terminal", terminal }
                                   }
                         })
 
 mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                      menu = mymainmenu })
 
 -- Menubar configuration
 menubar.utils.terminal = terminal -- Set the terminal for applications that require it
 -- }}}
 
 -- Keyboard map indicator and switcher
 mykeyboardlayout = awful.widget.keyboardlayout()
 
 -- {{{ Wibar
 -- Create a textclock widget
mytextclock = wibox.widget.textclock("<span color=\"#dda637\">%a %d %b, %H:%M:%S</span>", 1)
-- lain.widget.calendar({
--    attach_to = { mytextclock },
--    notification_preset = {
        -- font = "Misc Tamsyn 11",
--        font = "Monospace 10",
--        fg   = theme.fg_normal,
--        bg   = theme.bg_normal
--    }
--})

local cpu_graph_widget = wibox.widget {
    max_value = 100,
    color = '#74aeab',
    background_color = "#00000000",
    forced_width = 50,
    step_width = 2,
    step_spacing = 1,
    widget = wibox.widget.graph
}

local cpu_max_graph_widget = wibox.widget {
    max_value = 100,
    color = '#74aeab',
    background_color = "#00000000",
    forced_width = 50,
    step_width = 2,
    step_spacing = 1,
    widget = wibox.widget.graph
}

-- mirros and pushs up a bit
local cpu_widget = wibox.container.margin(wibox.container.mirror(cpu_graph_widget, { horizontal = true }), 0, 0, 0, 2)
local cpu_max_widget = wibox.container.margin(wibox.container.mirror(cpu_max_graph_widget, { horizontal = true }), 0, 0, 0, 2)

cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, 
        function (widget, args)
            
            local total_usage = args[1]
            if total_usage > 80 then
                cpu_graph_widget:set_color('#ff4136')
            else
                cpu_graph_widget:set_color('#74aeab')
            end    
            cpu_graph_widget:add_value(total_usage)
            

            local single_max_usage = max(args)
            if single_max_usage > 80 then
                cpu_max_graph_widget:set_color('#ff4136')
            else
                cpu_max_graph_widget:set_color('#74aeab')
            end    
            cpu_max_graph_widget:add_value(single_max_usage)
            
            local text_widget_string = 
                "cpu: " .. colorize(args[2]) .. " " .. colorize(args[3]) .. " " .. colorize(args[4]) .. " " .. colorize(args[5]) .. " " .. colorize(args[6]) .. " " .. colorize(args[7]) .. " " .. colorize(args[8]) .. " " .. colorize(args[9])
            return text_widget_string
        end, 
        1)
 
 
 memwidget = wibox.widget.textbox()
 vicious.register(memwidget, vicious.widgets.mem, 
         function (widget, args)
             return "Mem: " .. colorize(args[1], 80, 90) .. "%"-- .. colorize(args[5], 70, 90) .. "%"
         end, 13)
 
 tempwidget = wibox.widget.textbox()
 vicious.register(tempwidget, vicious.widgets.thermal, " $1C", 7, "thermal_zone0")
 
 batwidget = wibox.widget.textbox()
 -- vicious.register(batwidget, vicious.widgets.bat, "bat: $2% $3", 11, "BAT0")
 vicious.register(batwidget, vicious.widgets.bat, 
         function (widget, args)
             return "bat: " .. colorize(args[2], 10, 20, 'red', 'green', '#ddddff') .. "% " .. args[3]
         end, 11, "BAT0")

 sprtr = wibox.widget{
    markup = ' <span color="#0C0CC5"><b>|</b></span> ',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}
 

 -- Create a wibox for each screen and add it
 local taglist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function(t) t:view_only() end),
                     awful.button({ modkey }, 1, function(t)
                                               if client.focus then
                                                   client.focus:move_to_tag(t)
                                               end
                                           end),
                     awful.button({ }, 3, awful.tag.viewtoggle),
                     awful.button({ modkey }, 3, function(t)
                                               if client.focus then
                                                   client.focus:toggle_tag(t)
                                               end
                                           end),
                     awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                     awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                 )
 
 local tasklist_buttons = awful.util.table.join(
                      awful.button({ }, 1, function (c)
                                               if c == client.focus then
                                                   c.minimized = true
                                               else
                                                   -- Without this, the following
                                                   -- :isvisible() makes no sense
                                                   c.minimized = false
                                                   if not c:isvisible() and c.first_tag then
                                                       c.first_tag:view_only()
                                                   end
                                                   -- This will also un-minimize
                                                   -- the client, if needed
                                                   client.focus = c
                                                   c:raise()
                                               end
                                           end),
                      awful.button({ }, 3, client_menu_toggle_fn()),
                      awful.button({ }, 4, function ()
                                               awful.client.focus.byidx(1)
                                           end),
                      awful.button({ }, 5, function ()
                                               awful.client.focus.byidx(-1)
                                           end))
 
 local function set_wallpaper(s)
     -- Wallpaper
     if beautiful.wallpaper then
         local wallpaper = beautiful.wallpaper
         -- If wallpaper is a function, call it with the screen
         if type(wallpaper) == "function" then
             wallpaper = wallpaper(s)
         end
         gears.wallpaper.maximized(wallpaper, s, true)
     end
 end
 
 -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
 screen.connect_signal("property::geometry", set_wallpaper)
 
 awful.screen.connect_for_each_screen(function(s)
     -- Wallpaper
     set_wallpaper(s)

     s.quake = lain.util.quake({ app = awful.util.terminal })
 
     -- Each screen has its own tag table.
     awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
 
     -- Create a promptbox for each screen
     s.mypromptbox = awful.widget.prompt()
     -- Create an imagebox widget which will contains an icon indicating which layout we're using.
     -- We need one layoutbox per screen.
     s.mylayoutbox = awful.widget.layoutbox(s)
     -- s.mylayoutbox:buttons(awful.util.table.join(
     --                        awful.button({ }, 1, function () awful.layout.inc( 1) end),
     --                        awful.button({ }, 3, function () awful.layout.inc(-1) end),
     --                        awful.button({ }, 4, function () awful.layout.inc( 1) end),
     --                        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
     -- Create a taglist widget
     s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
 
     -- Create a tasklist widget
     s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
 
     -- Create the wibox
     s.mywibox = awful.wibar({ position = "top", screen = s })
     -- Add widgets to the wibox
     s.mywibox:setup {
         layout = wibox.layout.align.horizontal,
         { -- Left widgets
             layout = wibox.layout.fixed.horizontal,
             mylauncher,
             s.mytaglist,
             s.mypromptbox,
         },
         s.mytasklist, -- Middle widget
         { -- Right widgets
             layout = wibox.layout.fixed.horizontal,
             mykeyboardlayout,
             sprtr,
             cpu_widget,sprtr,
             cpu_max_widget,sprtr,
            --  cpuwidget,
             tempwidget, sprtr,
             memwidget, sprtr,
             batwidget, sprtr,
             battery_widget,
            --  sprtr,
             volume_widget(), sprtr,
             brightness_widget(), sprtr,
             datewidget,
             mytextclock,
             sprtr,
             wibox.widget.systray(),
             s.mylayoutbox,
         },
     }

    s.mywibox2 = awful.wibar({ position = "bottom", screen = s })
    s.mywibox2:setup{
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --  mylauncher,
            --  s.mytaglist,
            --  s.mypromptbox,
        },
        --  s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            cpuwidget,
            sprtr,
        },
    }
    s.mywibox2.visible = false
 end)
 -- }}}
 
