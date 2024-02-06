#!/usr/bin/env bash

read newLayout

layout=${newLayout#*:}

notify-send Layout $layout -i flameshot
