#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=============================="
echo " Restoring KDE Plasma Layout"
echo "=============================="

# 1. Install packages
echo ""
echo "[1/3] Installing packages..."
sudo pacman -S --needed - < "$SCRIPT_DIR/kde-packages.txt"

# 2. Restore config files
echo ""
echo "[2/3] Restoring config files..."
cp -rv "$SCRIPT_DIR/config/"* "$HOME/.config/"
cp -rv "$SCRIPT_DIR/local/"* "$HOME/.local/share/"

# 3. Reload Plasma
echo ""
echo "[3/3] Applying changes..."
kquitapp6 plasmashell 2>/dev/null || true
kstart6 plasmashell 2>/dev/null || true

echo ""
echo "=============================="
echo " Done! Your KDE layout should"
echo " now look like the original."
echo "=============================="
