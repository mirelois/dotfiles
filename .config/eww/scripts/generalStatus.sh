#!/usr/bin/env bash

if [[ -z $(ls /home/utilizador/snap/firefox/common/.mozilla/firefox/ | grep mpris)  ]]; then
    ~/.config/eww/scripts/spotifystatus.sh
else
    ~/.config/eww/scripts/youtubeStatus.sh
fi

