#!/bin/sh
#
# Install the Codex CLI on Ubuntu with OpenAI's standalone installer. It
# lands in ~/.local/bin (already on home.sessionPath) and keeps itself up
# to date, which nixpkgs cannot: a Nix-built codex lags by up to the
# bi-weekly flake.lock bump. No sudo needed; run once on a fresh machine.

set -eux

if [ -x "$HOME/.local/bin/codex" ]; then
  echo "codex already installed: $("$HOME/.local/bin/codex" --version)"
  exit 0
fi

tmp_installer="$(mktemp)"
curl -fsSL https://chatgpt.com/codex/install.sh -o "$tmp_installer"
# Skip the "Start Codex now?" prompt so install-all.sh runs unattended.
CODEX_NON_INTERACTIVE=1 sh "$tmp_installer"
rm "$tmp_installer"
