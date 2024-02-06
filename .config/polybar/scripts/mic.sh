#!/bin/sh

if [ ! -z "$(pactl get-source-mute @DEFAULT_SOURCE@ | grep yes)" ];
then
     echo ""
else
     echo ""
fi
exit 0

