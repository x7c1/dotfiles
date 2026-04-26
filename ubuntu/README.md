# Ubuntu setup

Tested on Ubuntu 26.04 (Wayland session).

## Bootstrap

1. **Install curl** (needed by the Nix installer):

   ```sh
   sudo apt update && sudo apt install -y curl
   ```

2. **Install Nix** ([Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer)):

   ```sh
   curl -fsSL https://install.determinate.systems/nix | sh -s -- install
   ```

   Re-open the shell to pick up Nix paths.

3. **Set up an SSH key** for GitHub:

   ```sh
   ssh-keygen -t ed25519
   nix run nixpkgs#wl-clipboard -- wl-copy < ~/.ssh/id_ed25519.pub
   # Paste into https://github.com/settings/keys
   ```

4. **Clone the dotfiles** (anywhere you like):

   ```sh
   nix run nixpkgs#git -- clone git@github.com:x7c1/dotfiles.git /path/to/dotfiles
   ```

5. **Link the home-manager directory**:

   ```sh
   ln -s /path/to/dotfiles/home-manager ~/.config/home-manager
   ```

6. **Apply the configuration**:

   ```sh
   nix run home-manager/master -- switch --flake ~/.config/home-manager#x7c1@ubuntu
   ```

7. **Switch login shell to zsh**:

   ```sh
   echo "$HOME/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
   chsh -s "$HOME/.nix-profile/bin/zsh"
   ```

   Log out and back in for `$SHELL` to update.

## Optional steps

### Docker (system-level, not Nix-managed)

```sh
/path/to/dotfiles/ubuntu/scripts/install-docker.sh
```

Log out and back in (or `newgrp docker`) for the docker group to take effect.

### First-time toolchain setup

Some Nix packages provide a manager binary that needs an explicit toolchain install on first use:

```sh
fnm install --lts && fnm default lts/iron   # Node.js
rustup default stable                       # Rust
```
