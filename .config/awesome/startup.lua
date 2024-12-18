local awful = require('awful')

--top bar
-- awful.spawn.once("/home/utilizador/.config/polybar/startbar")

awful.spawn.once("~/.config/eww/scripts/getweather")

--key settings
awful.spawn.once("xdotool key Num_Lock ")
awful.spawn.once("xset s off -dpms")
awful.spawn.once("xsetroot -cursor_name left_ptr")
awful.spawn.once("setxkbmap -option compose:rctrl")
awful.spawn.once("setxkbmap pt nodeadkeys")

--set both mic and vol to mute
-- awful.spawn.once("pactl set-sink-mute @DEFAULT_SINK@ 1")
-- awful.spawn.once("pactl set-source-mute @DEFAULT_SOURCE@ 1")

--for password prompts
awful.spawn.once("lxpolkit")

-- screen locker
-- awful.spawn.once("betterlockscreen -u $image --fx")

-- for widgets
awful.spawn.once("eww daemon")

-- compositor
awful.spawn.once("picom")

awful.spawn.once("discord")
