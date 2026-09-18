#!/bin/sh
#
# Install Google Chrome on Ubuntu from Google's .deb. The package registers
# Google's apt repository itself (/etc/apt/sources.list.d/google-chrome.sources),
# so later updates arrive through apt. System-level setup that home-manager
# cannot manage; run once on a fresh machine.

set -eux

if command -v google-chrome >/dev/null 2>&1; then
  echo "google-chrome already installed: $(google-chrome --version)"
  exit 0
fi

tmp_dir="$(mktemp -d)"
deb="$tmp_dir/google-chrome-stable_current_amd64.deb"
curl -fsSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  -o "$deb"
# Let apt's unprivileged _apt user read the file.
chmod 755 "$tmp_dir"
chmod 644 "$deb"

sudo apt update
sudo apt install -y "$deb"
rm -rf "$tmp_dir"

cat <<'MSG'

Google Chrome installed.

Updates will arrive via `sudo apt upgrade`.
MSG
