# CachyOS KDE Layout

My full system config: KDE Plasma layout + Neovim + Zsh + Tmux.

## One-command restore

```bash
git clone https://github.com/kara7z/cachyos-kde-layout.git && cd cachyos-kde-layout && ./setup.sh
```

Then log out and back in (to apply the default shell change), or run `source ~/.zshrc`.

## What it restores

- **KDE Plasma** — panels, widgets, shortcuts, themes, window rules, Konsole profiles, splash screen
- **Neovim** — plugins, keymaps, LSP, Mason packages (clangd, codelldb)
- **Zsh** — Oh My Zsh with autosuggestions & syntax highlighting
- **Tmux** — vim-like navigation, resurrect/continuum
