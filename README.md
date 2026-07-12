# CachyOS KDE Layout

KDE Plasma restore + Neovim + Zsh + Tmux + Alacritty for CachyOS.

## Quick start

```bash
sudo pacman -S --needed git && git clone https://github.com/kara7z/cachyos-kde-layout.git && cd cachyos-kde-layout && ./setup.sh
```

Type your sudo password once — the script runs fully non-interactive from there.

Then **log out and back in** to apply the Zsh shell change.

## What gets restored

| What | Details |
|---|---|
| **KDE Plasma** | panels, widgets, shortcuts, themes, window rules, desktop applets |
| **Konsole** | profiles, color schemes (Sweet, Nord variants) |
| **Alacritty** | Nord theme, font, opacity, keybinds |
| **Neovim** | LazyVim + plugins, LSP (clangd, codelldb), custom keymaps |
| **Zsh** | Oh My Zsh, autosuggestions, syntax highlighting |
| **Tmux** | vim navigation, resurrect/continuum, Catppuccin-style colors |
| **Packages** | full KDE suite + dev tools (git, neovim, tmux, alacritty, yazi, etc.) |

## What's in the repo

```
setup.sh              # restore script (fully non-interactive)
kde-packages.txt      # package list (CachyOS repos)
config/               # ~/.config/* — KDE Plasma, Alacritty, GTK
local/                # ~/.local/share/* — Konsole profiles, splash
```

## Safety

- `kwinoutputconfig.json` — **skipped** (monitor layout is hardware-specific)
- `*.qmlc`, `*.jsc`, `*.cache` — **skipped** (compiled cache per Qt version)
- `~/.config/nvim/` — **replaced** if present (back up first)
- `~/.zshrc` / `~/.tmux.conf` — **overwritten** with symlinks

## Post-install

1. **Log out and back in** — Zsh becomes the default shell
2. Open a terminal — Zsh with plugins is ready
3. Run `nvim` — lazy.nvim auto-installs plugins on first launch
4. Run `tmux` then press `prefix + I` (capital I) to install TPM plugins
