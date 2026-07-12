# CachyOS KDE Layout

KDE Plasma restore + Neovim + Zsh + Tmux config for CachyOS.

## Quick start

```bash
sudo pacman -S --needed git
git clone https://github.com/kara7z/cachyos-kde-layout.git
cd cachyos-kde-layout
./setup.sh
```

Then **log out and back in** to pick up the default shell change.

Open a new terminal after login to get the Zsh/Tmux config.

## What the script does

| Step | Action |
|---|---|
| 1 | Detects CPU (Intel/AMD) and installs matching microcode |
| 2 | Installs all KDE + dev packages from `kde-packages.txt` |
| 3 | Installs Oh My Zsh and sets Zsh as default shell |
| 4 | Restores KDE Plasma config (panels, shortcuts, themes, window rules) |
| 5 | Restores Konsole profiles and splash screen |
| 6 | Clones and installs Neovim config (`nvim-config`) |
| 7 | Clones and installs Zsh/Tmux config (`zsh-config`) |
| 8 | Restarts Plasma to apply changes |

## What's in the repo

- `setup.sh` — the restore script
- `kde-packages.txt` — package list (CachyOS repos)
- `config/` — KDE Plasma dotfiles (`~/.config/*`)
- `local/` — Konsole profiles, splash screen (`~/.local/share/*`)

## Safety notes

- `kwinoutputconfig.json` — **skipped** (monitor layout is hardware-specific)
- `*.qmlc`, `*.jsc`, `*.cache` — **skipped** (compiled cache is Qt-version-specific)
- Existing `~/.config/nvim/` is **replaced** (backup first if needed)
- Existing `~/.zshrc` and `~/.tmux.conf` are **overwritten** with symlinks

## After running

1. **Log out and back in** for the Zsh shell change to take effect
2. Open a terminal — Zsh with plugins is ready
3. Run `tmux` then `prefix + I` (capital I) to install Tmux plugins
4. Run `nvim` — lazy.nvim auto-installs all plugins on first launch
