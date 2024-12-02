#!/usr/bin/env bash

SESSION=$(openvpn3 sessions-list | grep "Client connected")

if [[ -z "$SESSION" ]]; then
    vpn on
else
    vpn off
fi


