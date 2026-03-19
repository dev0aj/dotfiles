#!/usr/bin/env bash

set -e

BASH_PATH="$(command -v bash)"

if [[ -z "$BASH_PATH" ]]; then
  echo "Error: bash not found"
  exit 1
fi

if ! grep -qx "$BASH_PATH" /etc/shells; then
  echo "Error: $BASH_PATH is not listed in /etc/shells"
  exit 1
fi

echo "Changing shell to $BASH_PATH..."
chsh -s "$BASH_PATH"

echo "Done. Log out and log back in for changes to take effect."
