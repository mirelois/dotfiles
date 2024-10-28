#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1080x2160 --pos 0x2160 --rotate right --output HDMI-2 --mode 1920x1080 --pos 0x1080 --rotate normal

bspc monitor eDP-1 -d   󰈙      
                                                                                                      
bspc monitor HDMI-2 -d 
  
bspc monitor HDMI-1 -d 󱧐 

~/.config/bspwm/set_wallpaper.sh
