#!/bin/bash

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

run # key settings
run xdotool key Num_Lock
# run xset s off -dpms
# run xsetroot -cursor_name left_ptr
run localectl set-keymap pt-nodeadkeys
run setxkbmap -option compose:ins

# sound setting
run pactl set-sink-mute @DEFAULT_SINK@ 1
run pactl set-source-mute @DEFAULT_SOURCE@ 1

# password print
run lxpolkit

# compositor
run picom

run /var/lib/flatpak/exports/bin/com.discordapp.Discord
# screen locker
# betterlockscreen -u $image --fx

# eww
run /home/mirelois/bin/eww daemon

