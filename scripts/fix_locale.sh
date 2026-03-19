#!/usr/bin/env bash
set -e

# -----------------------
# Script: fix_locale_manual.sh
# Purpose: Set UTF-8 locale manually for current user
# -----------------------

TARGET_LOCALE="en_IN.UTF-8"

echo "Setting locale to $TARGET_LOCALE..."

# Generate the locale if not present
if ! locale -a | grep -q "^$TARGET_LOCALE$"; then
    echo "Generating locale $TARGET_LOCALE..."
    sudo locale-gen "$TARGET_LOCALE"
    echo "Locale generation complete."
fi

# Update current shell environment
export LANG="$TARGET_LOCALE"
export LC_ALL="$TARGET_LOCALE"

# Detect shell config file
SHELL_NAME="$(basename "$SHELL")"
case "$SHELL_NAME" in
    bash) RC_FILE="$HOME/.bashrc" ;;
    zsh)  RC_FILE="$HOME/.zshrc" ;;
    fish) RC_FILE="$HOME/.config/fish/config.fish" ;;
    *) echo "Unsupported shell: $SHELL_NAME"; exit 1 ;;
esac

# Persist locale in shell config if not already present
grep -qxF "export LANG=$TARGET_LOCALE" "$RC_FILE" || echo "export LANG=$TARGET_LOCALE" >> "$RC_FILE"
grep -qxF "export LC_ALL=$TARGET_LOCALE" "$RC_FILE" || echo "export LC_ALL=$TARGET_LOCALE" >> "$RC_FILE"

echo "Locale set and persisted in $RC_FILE"
echo "Please restart your terminal or run: source $RC_FILE"
