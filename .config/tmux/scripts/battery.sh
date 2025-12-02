#!/bin/bash

if [ ! -f /sys/class/power_supply/BAT0/capacity ]; then
	exit 0
fi

capacity=$(cat /sys/class/power_supply/BAT0/capacity)

if [ -z "$capacity" ]; then
	exit 0
fi

status=$(cat /sys/class/power_supply/BAT0/status)

color=''
if [ "$status" = "Charging" ]; then
	color='#[fg=#ff0000]' # Red
fi

echo "${color}${capacity}%"
