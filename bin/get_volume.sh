#!/bin/bash

amixer -c 0 -D pulse sget Master && pactl list sinks | grep "Active Port"
