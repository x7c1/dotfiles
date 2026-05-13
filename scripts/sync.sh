#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir="$(cd "$script_dir/.." && pwd)"

. "$script_dir/lib/host.sh"

cd "$dotfiles_dir"

if command -v gh >/dev/null 2>&1; then
  pr_number=$(gh pr list --head update_flake_lock_action --state open --json number --jq '.[0].number // empty')
  if [ -n "$pr_number" ]; then
    echo "==> Pending flake bump PR #$pr_number found. Verifying..."
    host=$(detect_host) || exit 1
    gh pr checkout "$pr_number"
    (cd home-manager && nix build ".#homeConfigurations.\"$host\".activationPackage" --no-link)
    git checkout main
    gh pr merge "$pr_number" --squash --delete-branch
  fi
fi

git pull --ff-only
"$script_dir/setup-home-manager.sh"
