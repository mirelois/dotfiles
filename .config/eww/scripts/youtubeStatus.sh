#!/usr/bin/env bash

STATUS=$(playerctl status - p firefox)

if [[ $STATUS = "Paused" ]] ; then
    printf 
fi
if [[ $STATUS = "Playing" ]] ; then
    printf 
fi
  
