#!/usr/bin/env bash

set -euo pipefail

echo "Installing Kitty terminal..."

# Install kitty
if [ ! -d "$HOME/.local/kitty.app" ]; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
else
    echo "Kitty already installed. Skipping install."
fi

# Ensure ~/.local/bin exists
mkdir -p "$HOME/.local/bin"

echo "Creating symlinks..."

ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"

# Ensure applications directory exists
mkdir -p "$HOME/.local/share/applications"

echo "Setting up desktop entry..."

cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" \
   "$HOME/.local/share/applications/"

# Resolve absolute home path safely
HOME_PATH="$(realpath "$HOME")"

# Update desktop file paths
sed -i "s|Icon=kitty|Icon=$HOME_PATH/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
    "$HOME/.local/share/applications/kitty.desktop"

sed -i "s|Exec=kitty|Exec=$HOME_PATH/.local/kitty.app/bin/kitty|g" \
    "$HOME/.local/share/applications/kitty.desktop"

# Optional: fix kitty-open.desktop if present
if [ -f "$HOME/.local/share/applications/kitty-open.desktop" ]; then
    sed -i "s|Exec=kitty|Exec=$HOME_PATH/.local/kitty.app/bin/kitty|g" \
        "$HOME/.local/share/applications/kitty-open.desktop"
fi

echo "Setting Kitty as default terminal (xdg)..."

mkdir -p "$HOME/.config"
echo "kitty.desktop" > "$HOME/.config/xdg-terminals.list"

echo "Kitty setup complete!"
