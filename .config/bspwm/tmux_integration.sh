#!/usr/bin/env bash

if [[ $(xprop -id "$(bspc query -N focused -n focused)" | grep tmux) ]]; then
    ~/.config/bspwm/move_tmux.sh $1 $2
else
    ~/.config/bspwm/move.sh $1 $2
fi

