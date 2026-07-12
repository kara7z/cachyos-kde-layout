#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=============================="
echo "  Full System Restore"
echo "=============================="

# 1. Install packages
echo ""
echo "[1/5] Installing packages..."
sudo pacman -S --needed - < "$SCRIPT_DIR/kde-packages.txt"

# Ensure zsh is installed
if ! command -v zsh &>/dev/null; then
  echo "Installing zsh..."
  sudo pacman -S --needed zsh
fi

# Ensure Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting zsh as default shell..."
  chsh -s "$(which zsh)"
fi

# 2. Restore KDE config files
echo ""
echo "[2/5] Restoring KDE config files..."
cp -rv "$SCRIPT_DIR/config/"* "$HOME/.config/"
cp -rv "$SCRIPT_DIR/local/"* "$HOME/.local/share/"

# 3. Install Neovim config
echo ""
echo "[3/5] Installing Neovim config..."
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/kara7z/nvim-config.git "$HOME/.config/nvim"
else
  echo "~/.config/nvim already exists, skipping..."
fi

# 4. Install Zsh & Tmux config
echo ""
echo "[4/5] Installing Zsh & Tmux config..."
if [ ! -d "$HOME/zsh-config" ]; then
  git clone https://github.com/kara7z/zsh-config.git "$HOME/zsh-config"
  bash "$HOME/zsh-config/setup.sh"
else
  echo "zsh-config already cloned, running setup..."
  bash "$HOME/zsh-config/setup.sh"
fi

# 5. Reload Plasma
echo ""
echo "[5/5] Applying Plasma changes..."
kquitapp6 plasmashell 2>/dev/null || true
kstart6 plasmashell 2>/dev/null || true

echo ""
echo "=============================="
echo "  All done!"
echo "  - KDE layout restored"
echo "  - Neovim config installed"
echo "  - Zsh/Tmux config installed"
echo "  Restart your shell or run:"
echo "    source ~/.zshrc"
echo "=============================="
