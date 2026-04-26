# Updates

Two layers manage versions independently. Both are safe to bump regularly; doing so keeps each upgrade small enough to debug if something breaks.

## Neovim plugins (lazy.nvim)

`config/nvim/lazy-lock.json` is symlinked into `~/.config/nvim/`, so running `:Lazy update` (or `:Lazy sync`) inside Neovim writes the new plugin versions straight back to the repository file. Verify with `git status`, then commit `config/nvim/lazy-lock.json`.

## Nix-managed packages (flake inputs)

The exact commit of `nixpkgs`, `home-manager`, and any other flake input is pinned in `home-manager/flake.lock`. Refreshing the lock to the latest commit of each input's tracked branch is what bumps every Nix-managed package (zsh, neovim, tmux, bat, awscli2, ...).

```sh
cd /path/to/dotfiles/home-manager
nix flake update
home-manager switch --flake ~/.config/home-manager#x7c1@ubuntu
# verify everything still works
git add flake.lock
git commit -m "chore: bump flake inputs"
```

To bump just one input:

```sh
cd /path/to/dotfiles/home-manager
nix flake update nixpkgs
```

If something breaks, roll back:

```sh
git checkout home-manager/flake.lock
home-manager switch --flake ~/.config/home-manager#x7c1@ubuntu
```

## Out of scope

These have their own update mechanisms and are not touched by the above:

- Rust toolchain — `rustup update`
- Node.js versions — managed by `fnm`
- Docker engine — system package manager (`sudo apt upgrade`)
