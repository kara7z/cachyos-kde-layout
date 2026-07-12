# CachyOS KDE Layout

One-command restore for my full CachyOS setup: KDE Plasma + Neovim + Zsh + Tmux + Alacritty.

## Quick start

```bash
sudo pacman -S --needed git && git clone https://github.com/kara7z/cachyos-kde-layout.git && cd cachyos-kde-layout && ./setup.sh
```

Type your sudo password once — the script runs fully non-interactive from there.

**Log out and back in** after the script finishes to apply the Zsh shell change.

## What it restores

| Category | Details |
|---|---|
| **KDE Plasma** | panels, widgets, shortcuts, themes, window rules, desktop applets, splash screen |
| **Konsole** | profiles, color schemes (Sweet, Nord variants), FiraCode Nerd Font |
| **Alacritty** | Nord theme, FiraCode Nerd Font Mono, opacity, custom keybinds |
| **Neovim** | LazyVim + plugins, LSP (clangd, codelldb), custom keymaps |
| **Zsh** | Oh My Zsh, autosuggestions, syntax highlighting, aliases (yy, tt, oc) |
| **Tmux** | vim navigation, resurrect/continuum, Catppuccin-style colors |
| **Packages** | full KDE suite + dev tools (git, neovim, tmux, alacritty, yazi, etc.) |

## Repo structure

```
setup.sh              # restore script (fully non-interactive, --noconfirm)
kde-packages.txt      # package list (CachyOS repos)
.gitignore            # ignores *.qmlc, *.jsc, *.cache
config/               # ~/.config/* — KDE Plasma, Alacritty, GTK
local/                # ~/.local/share/* — Konsole profiles, splash screen
```

## The script does

| Step | Action |
|---|---|
| 1 | Detects CPU (Intel/AMD) and installs matching microcode |
| 2 | Installs all packages from `kde-packages.txt` |
| 3 | Installs Oh My Zsh and sets Zsh as default shell |
| 4 | Restores KDE config (panels, shortcuts, themes, window rules) |
| 5 | Restores Konsole profiles, color schemes, splash screen |
| 6 | Clones and installs `nvim-config` |
| 7 | Clones and installs `zsh-config` (symlinks, OMZ plugins, TPM) |
| 8 | Restarts Plasma to apply changes |

## Safety

- `kwinoutputconfig.json` — **skipped** (monitor layout is hardware-specific)
- `*.qmlc`, `*.jsc`, `*.cache` — **skipped** (compiled cache, Qt-version-specific)
- Existing `~/.config/nvim/` — **replaced** if present (back up first)
- Existing `~/.zshrc` / `~/.tmux.conf` — **overwritten** with symlinks
- Running the script twice is safe (idempotent)

## Post-install

1. **Log out and back in** — Zsh becomes the default shell
2. Open a terminal — Zsh with plugins is ready
3. Run `nvim` — lazy.nvim auto-installs all plugins on first launch
4. Run `tmux` then press `prefix + I` (capital I) to install TPM plugins

## Dotfiles repos

- [nvim-config](https://github.com/kara7z/nvim-config) — Neovim config
- [zsh-config](https://github.com/kara7z/zsh-config) — Zsh + Tmux config
