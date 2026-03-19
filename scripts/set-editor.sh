#!/usr/bin/env bash

# Exit on error
set -e

EDITOR_VALUE="${1:-vim}"   # default to nano if no argument provided
BASHRC="$HOME/.bashrc"

echo "Setting EDITOR to '$EDITOR_VALUE' in $BASHRC"

# If EDITOR already exists, replace it
if grep -q "^export EDITOR=" "$BASHRC"; then
    sed -i "s|^export EDITOR=.*|export EDITOR=$EDITOR_VALUE|" "$BASHRC"
    echo "Updated existing EDITOR value."
else
    echo "export EDITOR=$EDITOR_VALUE" >> "$BASHRC"
    echo "Added EDITOR to bashrc."
fi

echo "Done. Reload your shell or run: source ~/.bashrc"
