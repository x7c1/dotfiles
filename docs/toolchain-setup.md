# First-time toolchain setup

`fnm` and `rustup` install the version managers themselves but not the runtimes.
Run these once on a fresh machine:

```sh
fnm install --lts          # Node.js
rustup default stable      # Rust
```
