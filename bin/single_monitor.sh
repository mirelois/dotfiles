#!/bin/sh

bspc config -m eDP-1 top_monocle_padding 8
bspc config -m HDMI-1 top_monocle_padding 0

xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1080x2160 --pos 0x1080 --rotate right --output HDMI-2 --off

bspc monitor eDP-1 -d   󰈙      
bspc monitor HDMI-1 -d 󱧐

# bspc wm -O eDP-1 HDMI-1

~/.config/bspwm/set_wallpaper.sh


