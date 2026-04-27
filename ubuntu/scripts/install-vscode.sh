#!/bin/sh
#
# Install Visual Studio Code on Ubuntu via Microsoft's apt repository.
# System-level setup that home-manager cannot manage cleanly (GUI app
# with frequent upstream releases); run once on a fresh machine.

set -eux

if command -v code >/dev/null 2>&1; then
  echo "code already installed: $(code --version | head -n1)"
  exit 0
fi

sudo apt update
sudo apt install -y wget gpg apt-transport-https

tmp_key="$(mktemp)"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor > "$tmp_key"
sudo install -D -o root -g root -m 644 "$tmp_key" \
  /etc/apt/keyrings/packages.microsoft.gpg
rm "$tmp_key"

echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo apt update
sudo apt install -y code

cat <<'EOF'

VS Code installed.

Updates will arrive via `sudo apt upgrade`. To pull them in automatically,
add `packages.microsoft.com` to Unattended-Upgrade::Allowed-Origins.
EOF
