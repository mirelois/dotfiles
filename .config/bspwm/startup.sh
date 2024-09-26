#!/bin/sh

#screen layout
# ~/.screenlayout/dual_monitor.sh &
#xrandr --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-1 --mode 1080x2160 --pos 0x1080 --rotate right --output HDMI-1-2 --off

#set random wallpaper from ~/wallpapers/
image=$(find ~/wallpapers/ -type f | shuf -n 1)
feh --bg-scale $image &

#turn on bar
~/.config/polybar/bartoggle 2> /dev/null

#get weather
~/.config/eww/scripts/getweather

#key settings
xdotool key Num_Lock 
xset s off -dpms
xsetroot -cursor_name left_ptr
setxkbmap -option compose:rctrl
setxkbmap pt nodeadkeys

#set both mic and vol to mute
pactl set-sink-mute @DEFAULT_SINK@ 1
pactl set-source-mute @DEFAULT_SOURCE@ 1

#start tmux server
# tmux new-session -d

#compositor
picom 2> /dev/null &

discord > /dev/null &

#for password promts
lxpolkit &

#screen blocker
betterlockscreen -u $image --fx #only renders normal image

#eww start
eww daemon

