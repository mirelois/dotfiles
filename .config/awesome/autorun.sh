#!/bin/bash

# sound setting
pactl set-sink-mute @DEFAULT_SINK@ 1
pactl set-source-mute @DEFAULT_SOURCE@ 1

# password print
lxpolkit &

# compositor
picom &

/var/lib/flatpak/exports/bin/com.discordapp.Discord &
# screen locker
# betterlockscreen -u $image --fx

# key settings
xdotool key Num_Lock
xset s off -dpms
xsetroot -cursor_name left_ptr
localectl set-keymap pt-nodeadkeys
setxkbmap -option compose:ins
setxkbmap -option ctrl:nocaps



# eww
/home/mirelois/bin/eww daemon

