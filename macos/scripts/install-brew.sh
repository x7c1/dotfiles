#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

macos_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

brew bundle --file="$macos_dir/Brewfile"

if [ -f "$macos_dir/Brewfile.local" ]; then
  brew bundle --file="$macos_dir/Brewfile.local"
fi
