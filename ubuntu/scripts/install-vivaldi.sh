#!/bin/sh
#
# Install Vivaldi on Ubuntu from Vivaldi's .deb. The package installs its
# signing key and registers Vivaldi's apt repository itself
# (/etc/apt/sources.list.d/vivaldi.sources), so later updates arrive through
# apt. Adding the repository by hand would duplicate that entry. System-level
# setup that home-manager cannot manage; run once on a fresh machine.

set -eux

if command -v vivaldi-stable >/dev/null 2>&1; then
  echo "vivaldi already installed: $(vivaldi-stable --version)"
  exit 0
fi

tmp_dir="$(mktemp -d)"
deb="$tmp_dir/vivaldi-stable_amd64.deb"
# Redirects to the versioned .deb of the latest stable release.
curl -fsSL https://vivaldi.com/download/vivaldi-stable_amd64.deb -o "$deb"
# Let apt's unprivileged _apt user read the file.
chmod 755 "$tmp_dir"
chmod 644 "$deb"

sudo apt update
sudo apt install -y "$deb"
rm -rf "$tmp_dir"

cat <<'MSG'

Vivaldi installed.

Updates will arrive via `sudo apt upgrade`.
MSG
