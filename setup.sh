#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=============================="
echo "  Full System Restore"
echo "=============================="

# 1. Install packages
echo ""
echo "[1/5] Installing packages..."

# Install CPU-specific microcode if applicable
if command -v lscpu &>/dev/null; then
  cpu_vendor=$(lscpu | awk '/Vendor ID:/ {print $3}')
  if echo "$cpu_vendor" | grep -qi "intel"; then
    sudo pacman -S --needed --noconfirm intel-ucode
  elif echo "$cpu_vendor" | grep -qi "amd"; then
    sudo pacman -S --needed --noconfirm amd-ucode
  fi
fi

sudo pacman -S --needed --noconfirm - < <(grep -v "amd-ucode\|intel-ucode" "$SCRIPT_DIR/kde-packages.txt")

# Ensure zsh is installed
if ! command -v zsh &>/dev/null; then
  echo "Installing zsh..."
  sudo pacman -S --needed --noconfirm zsh
fi

# Ensure Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell if not already
if [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "Setting zsh as default shell..."
  sudo chsh -s "$(command -v zsh)" "$USER" 2>/dev/null || echo "  Could not set shell automatically. Run: chsh -s /usr/bin/zsh"
fi

# 2. Restore KDE config files
echo ""
echo "[2/5] Restoring KDE config files..."
mkdir -p "$HOME/.config" "$HOME/.local/share"

# Copy all configs except hardware-specific monitor config
for item in "$SCRIPT_DIR/config/"*; do
  name="$(basename "$item")"
  if [ "$name" = "kwinoutputconfig.json" ]; then
    echo "  Skipping $name (hardware-specific monitor config)"
    continue
  fi
  cp -rvT "$item" "$HOME/.config/$name"
done

# Copy local files, skip cache/compiled files
rsync -av --exclude="*.qmlc" --exclude="*.jsc" --exclude="*.cache" "$SCRIPT_DIR/local/" "$HOME/.local/share/" 2>/dev/null || for item in "$SCRIPT_DIR/local/"*; do case "$item" in *.qmlc|*.jsc|*.cache) continue;; esac; cp -rvT "$item" "$HOME/.local/share/$(basename "$item")"; done

# Copy home dotfiles (preserves subdirectory structure)
if [ -d "$SCRIPT_DIR/home" ]; then
  rsync -av "$SCRIPT_DIR/home/" "$HOME/" 2>/dev/null || cp -rv "$SCRIPT_DIR/home/." "$HOME/"
fi

# 3. Install Neovim config
echo ""
echo "[3/5] Installing Neovim config..."
if [ ! -d "$HOME/.config/nvim" ] || [ -z "$(ls -A "$HOME/.config/nvim" 2>/dev/null)" ]; then
  rm -rf "$HOME/.config/nvim" 2>/dev/null || true
  git clone https://github.com/kara7z/nvim-config.git "$HOME/.config/nvim"
  echo "  Neovim config installed"
else
  echo "  Neovim config already present, skipping..."
fi

# 4. Install Zsh & Tmux config
echo ""
echo "[4/5] Installing Zsh & Tmux config..."
if [ ! -d "$HOME/zsh-config" ] || [ -z "$(ls -A "$HOME/zsh-config" 2>/dev/null)" ]; then
  rm -rf "$HOME/zsh-config" 2>/dev/null || true
  git clone https://github.com/kara7z/zsh-config.git "$HOME/zsh-config"
else
  echo "  Zsh config already present, skipping clone..."
fi
bash "$HOME/zsh-config/setup.sh"

# 5. Reload Plasma
echo ""
echo "[5/5] Applying Plasma changes..."
if systemctl --user is-active plasma-plasmashell &>/dev/null; then
  systemctl --user restart plasma-plasmashell 2>/dev/null || true
else
  echo "  Plasma not running (headless/SSH). Configs will apply on next login."
fi

echo ""
echo "=============================="
echo "  All done!"
echo "  - KDE layout restored"
echo "  - Neovim config installed"
echo "  - Zsh/Tmux config installed"
echo "  Open a new terminal (or run 'zsh' then 'source ~/.zshrc')"
echo "=============================="
