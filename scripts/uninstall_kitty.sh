#!/usr/bin/env bash

set -euo pipefail

echo "Uninstalling Kitty..."

# Remove symlinks
echo "Removing symlinks..."
rm -f "$HOME/.local/bin/kitty"
rm -f "$HOME/.local/bin/kitten"

# Remove desktop entries
echo "Removing desktop entries..."
rm -f "$HOME/.local/share/applications/kitty.desktop"
rm -f "$HOME/.local/share/applications/kitty-open.desktop"

# Remove xdg terminal setting
echo "Removing default terminal config..."
rm -f "$HOME/.config/xdg-terminals.list"

# Remove kitty installation directory
echo "Removing installation files..."
rm -rf "$HOME/.local/kitty.app"

# Optional: remove kitty config
if [ -d "$HOME/.config/kitty" ]; then
    read -rp "Remove Kitty config (~/.config/kitty)? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        rm -rf "$HOME/.config/kitty"
        echo "Removed Kitty config."
    fi
fi

echo "Kitty has been completely removed."
