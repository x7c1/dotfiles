#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir="$(cd "$script_dir/.." && pwd)"

git -C "$dotfiles_dir" pull --ff-only
"$script_dir/setup-home-manager.sh"
