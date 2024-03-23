#!/usr/bin/env bash

SESSION=$(openvpn3 sessions-list | grep "Client connected")

if [[ -z "$SESSION" ]]; then
    echo %{F#717C7C}󰖂 
else
    echo %{F#7E9CD8}󰖂 
fi


