#!/bin/sh

#screen layout
# ~/.screenlayout/dual_monitor.sh &
#xrandr --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-1 --mode 1080x2160 --pos 0x1080 --rotate right --output HDMI-1-2 --off

#set random wallpaper from ~/wallpapers/
image=$(find ~/wallpapers/ -type f | shuf -n 1)
feh --bg-scale $image &

#turn on bar
~/.config/polybar/bartoggle &

#get weather
~/.config/eww/scripts/getweather &

#key settings
xdotool key Num_Lock 
xset s off -dpms
setxkbmap pt nodeadkeys
xsetroot -cursor_name left_ptr
# setxkbmap -option caps:ctrl_modifier
setxkbmap -option compose:rctrl
# setxkbmap -option shift:both_capslock

#start tmux server
tmux new-session -d &

#compositor
exec picom &

discord &

#screen blocker
betterlockscreen -u $image --fx & #only renders normal image

#eww start
# eww daemon &

