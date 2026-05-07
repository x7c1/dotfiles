# x7c1's dotfiles

## Layout

- `home-manager/` — flake and home-manager modules
- `config/` — tool-agnostic config files referenced from the modules
- `ubuntu/` — Ubuntu-specific scripts and setup notes
- `macos/` — macOS-specific scripts and setup notes

## Setup

See the per-host guide:

- [Ubuntu](./ubuntu/README.md)
- [macOS](./macos/README.md)

After bootstrap, run the [first-time toolchain setup](./docs/toolchain-setup.md).

## Routine sync

For routine use, just run:

```sh
./scripts/sync.sh
```

Pulls the latest commits and applies them via `home-manager switch`. If a pending flake bump PR (auto-opened by the [`update-flake-lock` workflow](./.github/workflows/update-flake-lock.yml)) is found, it is verified, merged, and applied as part of the same run. Idempotent — safe to run anytime.

For cases that fall outside that flow (bumping ahead of schedule, bumping a single input, rolling back), see [Updating Nix flake inputs](./docs/update-flake-inputs.md).

## Manual updates

- [Neovim plugins](./docs/update-nvim-plugins.md) — `./scripts/update-nvim-plugins.sh`
- Rust toolchain — `rustup update`
- Node.js — `fnm install --lts`
- System packages — `sudo apt upgrade` (Ubuntu) / `softwareupdate -ia && brew upgrade` (macOS)
