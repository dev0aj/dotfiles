#!/usr/bin/env bash
set -euo pipefail

FONT_SRC="$HOME/dotfiles/CodeNewRoman"
FONT_DEST="$HOME/.local/share/fonts"

# Create fonts directory if it doesn't exist
mkdir -p "$FONT_DEST"

# Copy font files
cp -v "$FONT_SRC"/*.{ttf,otf} "$FONT_DEST"/ 2>/dev/null || true

# Refresh font cache
fc-cache -fv "$FONT_DEST"

echo "Fonts installed successfully."
