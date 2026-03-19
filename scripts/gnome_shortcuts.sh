#!/usr/bin/env bash
# gnome_shortcuts.sh
# Sets up GNOME custom shortcuts reproducibly

# Make sure gsettings is available
if ! command -v gsettings &> /dev/null; then
    echo "gsettings not found. Are you running GNOME?"
    exit 1
fi

# Define unique custom shortcut paths
CUSTOM0="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
CUSTOM1="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
CUSTOM2="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
CUSTOM3="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"

# Register all paths
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$CUSTOM0', '$CUSTOM1', '$CUSTOM2', '$CUSTOM3', '$CUSTOM4', '$CUSTOM5']"

# --- Shortcut 0: Super+Return → Kitty ---
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM0 name 'Open Kitty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM0 command 'kitty --start-as maximized'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM0 binding '<Super>Return'

# --- Shortcut 1: Super+K → Kitty ---
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM1 name 'Open Kitty Maximized'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM1 command 'kitty --start-as maximized'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM1 binding '<Super>k'

# --- Shortcut 2: Super+F → Firefox ---
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM2 name 'Open Firefox'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM2 command 'firefox'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM2 binding '<Super>f'

# --- Shortcut 3: Super+E → Nautilus ---
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM3 name 'Open Nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM3 command 'nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$CUSTOM3 binding '<Super>e'

echo "GNOME shortcuts configured!"
