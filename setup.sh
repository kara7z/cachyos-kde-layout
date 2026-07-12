#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Restoring KDE Plasma layout..."

# Restore config files
echo "Copying config files..."
cp -v "$SCRIPT_DIR/config/"* "$HOME/.config/"

echo ""
echo "Done! Log out and back in (or run 'plasmashell --replace' in terminal) to apply."
echo ""
echo "To install the same packages, run:"
echo "  sudo pacman -S --needed - < $SCRIPT_DIR/kde-packages.txt"
