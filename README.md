# x7c1's dotfiles

## Layout

- `home-manager/` — flake and home-manager modules
- `config/` — tool-agnostic config files referenced from the modules
- `ubuntu/` — Ubuntu-specific scripts and setup notes
- `macos/` / `macos.legacy/` — macOS-specific (work in progress)

## Setup

See the per-host guide:

- [Ubuntu](./ubuntu/README.md)
- macOS — TODO

## Updating Neovim plugins

`config/nvim/lazy-lock.json` is symlinked into `~/.config/nvim/`, so running `:Lazy update` (or `:Lazy sync`) inside Neovim writes the new plugin versions straight back to the repository file. Verify with `git status`, then commit `config/nvim/lazy-lock.json`.
