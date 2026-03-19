#!/usr/bin/env bash
# packages_pacman.sh - Fully automated Arch Linux setup: update + install packages

set -e  # Exit on any error

# Check if pacman is available
if ! command -v pacman &> /dev/null; then
    echo "Error: pacman is not installed. This script is for Arch Linux or derivatives."
    exit 1
fi

# List of packages to install
PACKAGES=(stow kitty neovim tmux tealdeer pass wl-clipboard)

echo "Installing packages: ${PACKAGES[*]}"
# Install packages without asking for confirmation
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

echo "System updated and packages installed successfully."
