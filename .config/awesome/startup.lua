local awful = require('awful')

--top bar
-- awful.spawn.once("/home/utilizador/.config/polybar/startbar")

-- awful.spawn.once("~/.config/eww/scripts/getweather")

--key settings
awful.spawn("xdotool key Num_Lock ")
awful.spawn("xset s off -dpms")
awful.spawn("xsetroot -cursor_name left_ptr")
awful.spawn("setxkbmap pt nodeadkeys")
-- awful.spawn("setxkbmap -option compose:ralt")
awful.spawn("setxkbmap -option ctrl:nocaps")

--set both mic and vol to mute
awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ 1")
awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@ 1")

--for password prompts
awful.spawn.once("lxpolkit")

-- screen locker
-- awful.spawn.once("betterlockscreen -u $image --fx")

-- for widgets
awful.spawn.once("~/bin/eww daemon")

-- compositor
awful.spawn.once("picom")

awful.spawn.once("/var/lib/flatpak/exports/bin/com.discordapp.Discord")
