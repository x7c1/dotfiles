#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir="$(cd "$script_dir/../.." && pwd)"

target="$HOME/.config/home-manager"
source_dir="$dotfiles_dir/home-manager"

if [ -L "$target" ]; then
  echo "Already linked: $target -> $(readlink "$target")"
elif [ -e "$target" ]; then
  echo "Error: $target exists and is not a symlink. Aborting." >&2
  exit 1
else
  mkdir -p "$(dirname "$target")"
  ln -s "$source_dir" "$target"
  echo "Linked: $target -> $source_dir"
fi

nix run home-manager/master -- switch --flake "$target#x7c1@macos"
