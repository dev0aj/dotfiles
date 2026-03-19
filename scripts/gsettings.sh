#!/usr/bin/env bash
# gsettings.sh - Apply custom GNOME settings

# Exit on any error
set -e

# Check if gsettings is available
if ! command -v gsettings &> /dev/null; then
    echo "Error: gsettings command not found. Are you running GNOME?"
    exit 1
fi

echo "Applying GNOME settings..."

# Enable dark mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Swap Caps Lock and Escape
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"

# Switch to workspaces with Alt+Number
for i in {1..9}; do
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Alt>$i']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Alt><Shift>$i']"
done

# Disable dynamic workspaces and set fixed number
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

# Set window button layout
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Make Alt+Tab switch only on current workspace
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Make Alt+` switch only on current workspace
gsettings set org.gnome.shell.window-switcher current-workspace-only true

echo "GNOME settings applied successfully."
