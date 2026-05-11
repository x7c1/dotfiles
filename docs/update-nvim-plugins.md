# Updating Neovim plugins

`config/nvim/lazy-lock.json` is symlinked into `~/.config/nvim/`, so any update to the lock flows straight back to the repository.

```sh
./scripts/update-nvim-plugins.sh
```

When it finishes, verify with `git status` and commit `config/nvim/lazy-lock.json`.
