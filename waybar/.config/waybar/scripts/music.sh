#!/bin/bash

escape() {
    echo "$1" | sed -e 's/&/\&amp;/g' \
                    -e 's/</\&lt;/g' \
                    -e 's/>/\&gt;/g'
}

player=$(playerctl -l 2>/dev/null | head -n1)
player=${player%%.*}

artist=$(escape "$(playerctl metadata artist 2>/dev/null)")
title=$(escape "$(playerctl metadata title 2>/dev/null)")

case $player in
    spotify)
        player_icon="   "
        ;;
    firefox)
        player_icon="   "
        ;;
    mpv)
        player_icon=" 󰐹  "
        ;;
    *)
        player_icon="   "
        ;;
esac

echo "$player_icon $title - $artist"
