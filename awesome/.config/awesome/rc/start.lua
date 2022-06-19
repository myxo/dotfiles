local awful = require("awful")

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.spawn.with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("nm-applet")
run_once("dropbox start")
-- run_once("blueman-applet")
run_once("setxkbmap -layout 'us,ru' -option 'grp:caps_toggle' ")
-- run_once("kbdd")
run_once("Telegram &")
run_once("syncthing -no-browser")
run_once("xinput set-prop \"SynPS/2 Synaptics TouchPad\" \"libinput Tapping Enabled\" 1")
-- awful.util.spawn_with_shell("wmname LG3D")
