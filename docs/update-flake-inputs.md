# Updating Nix flake inputs

The exact commit of `nixpkgs`, `home-manager`, and other inputs is pinned in `home-manager/flake.lock`. Refreshing the lock is what bumps every Nix-managed package (zsh, neovim, tmux, bat, awscli2, ...).

Routine bumps land automatically: the [`update-flake-lock` workflow](../.github/workflows/update-flake-lock.yml) opens a PR roughly every two weeks, and `./scripts/sync.sh` accepts the pending PR and applies it on the local machine. This document covers the manual procedures for cases that fall outside that flow — bumping ahead of schedule, bumping a single input, or rolling back a bad lock.

## Bump everything

```sh
cd /path/to/dotfiles/home-manager
nix flake update
home-manager switch --flake ~/.config/home-manager#x7c1@ubuntu
# verify everything still works
git add flake.lock
git commit -m "chore: bump flake inputs"
```

## Bump a single input

```sh
cd /path/to/dotfiles/home-manager
nix flake update nixpkgs
```

## Rollback

```sh
git checkout home-manager/flake.lock
home-manager switch --flake ~/.config/home-manager#x7c1@ubuntu
```
