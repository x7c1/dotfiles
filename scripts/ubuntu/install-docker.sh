#!/bin/sh
#
# Install Docker Engine and the Compose plugin on Ubuntu, then add the
# current user to the docker group. System-level setup that home-manager
# cannot manage; run once on a fresh machine.

set -eux

if command -v docker >/dev/null 2>&1; then
  echo "docker already installed: $(docker --version)"
  exit 0
fi

sudo apt update
sudo apt install -y docker.io docker-compose-v2

sudo systemctl enable --now docker

if ! getent group docker >/dev/null; then
  sudo addgroup --system docker
fi
sudo adduser "$USER" docker

cat <<'EOF'

Docker installed.

Log out and back in (or run `newgrp docker`) to pick up the docker group
membership before using `docker` commands without sudo.
EOF
