#!/usr/bin/env bash

is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"
case $2 in
    "west")
        tmux if-shell "$is_vim" 'send-keys C-S-h' "if -F '#{pane_at_left}' 'run-shell \"~/.config/bspwm/move.sh -f west || true \"' 'select-pane -L'"
    ;;
    "north")
        tmux if-shell "$is_vim" 'send-keys C-S-k' "if -F '#{pane_at_top}' 'run-shell \"~/.config/bspwm/move.sh -f north || true \"' 'select-pane -U'"
    ;;
    "south")
        tmux if-shell "$is_vim" 'send-keys C-S-j' "if -F '#{pane_at_bottom}' 'run-shell \"~/.config/bspwm/move.sh -f south || true \"' 'select-pane -D'"
    ;;
    "east")
        tmux if-shell "$is_vim" 'send-keys C-S-l' "if -F '#{pane_at_right}' 'run-shell \"~/.config/bspwm/move.sh -f east || true\"' 'select-pane -R'"
    ;;
esac

