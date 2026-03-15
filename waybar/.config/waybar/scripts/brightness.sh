#!/bin/bash

current=$(brightnessctl g)
max=$(brightnessctl m)

min=$((max * 5 / 100))

if [ "$1" = "up" ]; then
    brightnessctl set +5%
else
    new=$((current - max*5/100))
    if [ "$new" -lt "$min" ]; then
        brightnessctl set 5%
    else
        brightnessctl set 5%-
    fi
fi
