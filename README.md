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

## Sync

For routine use, just run:

```sh
./scripts/sync.sh
```

This pulls the latest commits and applies them via `home-manager switch`. Idempotent — safe to run anytime.

## Updates

See [UPDATES.md](./UPDATES.md).
