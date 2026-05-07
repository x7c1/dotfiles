# macOS setup

Tested on macOS 26 (aarch64-darwin).

## Bootstrap

1. **Install Nix** ([Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer)):

   ```sh
   curl -fsSL https://install.determinate.systems/nix | sh -s -- install
   ```

   Re-open the shell to pick up Nix paths.

2. **Set up an SSH key** for GitHub:

   ```sh
   ssh-keygen -t ed25519
   pbcopy < ~/.ssh/id_ed25519.pub
   # Paste into https://github.com/settings/keys
   ```

3. **Clone the dotfiles** (anywhere you like):

   ```sh
   nix run nixpkgs#git -- clone git@github.com:x7c1/dotfiles.git /path/to/dotfiles
   ```

4. **Set up home-manager** (links `~/.config/home-manager` and runs the first switch):

   ```sh
   /path/to/dotfiles/macos/scripts/setup-home-manager.sh
   ```

## Optional steps

### Homebrew & GUI apps (system-level, not Nix-managed)

```sh
/path/to/dotfiles/macos/scripts/install-brew.sh
```

Installs Homebrew itself (if missing) and applies `macos/Brewfile`
(`codex`, `docker-desktop`, `ghostty`, `karabiner-elements`). Karabiner
needs a one-time DriverKit System Extension approval in System Settings →
Privacy & Security after the first install.

For host-local casks/formulae that are not shared across machines,
create `macos/Brewfile.local` (gitignored). It is applied after the
shared `Brewfile`. Example:

```ruby
tap "alexstrnik/browserino"

cask "alt-tab"
cask "alexstrnik/browserino/browserino"
```

### First-time toolchain setup

Some Nix packages provide a manager binary that needs an explicit toolchain install on first use:

```sh
fnm install --lts          # Node.js
rustup default stable      # Rust
```
