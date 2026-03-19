#!/usr/bin/env bash

set -e

echo "Installing Starship prompt..."

# Install Starship
if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Starship is already installed. Skipping install."
fi

# Detect shell config file
SHELL_NAME="$(basename "$SHELL")"

case "$SHELL_NAME" in
    bash)
        RC_FILE="$HOME/.bashrc"
        ;;
    zsh)
        RC_FILE="$HOME/.zshrc"
        ;;
    fish)
        RC_FILE="$HOME/.config/fish/config.fish"
        ;;
    *)
        echo "Unsupported shell: $SHELL_NAME"
        exit 1
        ;;
esac

echo "Configuring Starship for $SHELL_NAME..."

# Add init line if not already present
INIT_CMD="eval \"\$(starship init $SHELL_NAME)\""

if ! grep -Fxq "$INIT_CMD" "$RC_FILE" 2>/dev/null; then
    echo "" >> "$RC_FILE"
    echo "# Starship prompt" >> "$RC_FILE"
    echo "$INIT_CMD" >> "$RC_FILE"
    echo "Added Starship init to $RC_FILE"
else
    echo "Starship init already exists in $RC_FILE"
fi

# Create config directory
CONFIG_DIR="$HOME/.config"
CONFIG_FILE="$CONFIG_DIR/starship.toml"

mkdir -p "$CONFIG_DIR"

echo "Setting Starship preset..."

# Apply preset
starship preset bracketed-segments -o "$CONFIG_FILE"

echo "Starship setup complete!"
echo "Restart your terminal or run: source $RC_FILE"
