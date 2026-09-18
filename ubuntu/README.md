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

5. **Pick a host profile** (laptops only). `scripts/lib/host.sh` defaults every
   Linux machine to `x7c1@ubuntu`; machines that need another profile record it
   once, and every later `setup-home-manager.sh` / `sync.sh` run picks it up:

   ```sh
   mkdir -p ~/.config/dotfiles
   echo "x7c1@ubuntu-laptop" > ~/.config/dotfiles/host
   ```

6. **Set up home-manager** (links `~/.config/home-manager` and runs the first switch):

   ```sh
   /path/to/dotfiles/scripts/setup-home-manager.sh
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

### Japanese input (system-level, not Nix-managed)

Only for the `x7c1@ubuntu-laptop` profile.

```sh
/path/to/dotfiles/ubuntu/scripts/install-fcitx5.sh
```

Fcitx5 and Mozc come from apt because the system GTK/Qt only load IM modules
from their own `/usr/lib` immodules cache, so Nix-built frontends stay invisible
to apt-installed apps. home-manager keeps the fonts, the `*_IM_MODULE` session
variables and the JIS layout (`home-manager/home/linux-japanese.nix`).

### Visual Studio Code (system-level, not Nix-managed)

```sh
/path/to/dotfiles/ubuntu/scripts/install-vscode.sh
```

Updates flow through apt; run `sudo apt upgrade` (or enable unattended
upgrades for `packages.microsoft.com`) to keep `code` current.

