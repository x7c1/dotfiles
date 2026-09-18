#!/bin/sh
#
# Install Ghostty on Ubuntu via the community-maintained mkasberg PPA, which
# tracks upstream releases more closely than the universe package. System-
# level setup that home-manager cannot manage cleanly on non-NixOS: a
# Nix-built Ghostty links its own GTK4 (missing the apt Fcitx5 IM module)
# and cannot find the host GPU drivers without nixGL. Run once on a fresh
# machine.

set -eux

if command -v ghostty >/dev/null 2>&1; then
  echo "ghostty already installed: $(ghostty --version | head -n1)"
  exit 0
fi

sudo apt update
sudo apt install -y software-properties-common

sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu
sudo apt update
sudo apt install -y ghostty

cat <<'MSG'

Ghostty installed.

Updates will arrive via `sudo apt upgrade`.
MSG
