#!/bin/sh
#
# Run every install script in this directory. Each one skips
# or re-applies harmlessly on a machine that already has the tool, so this
# is safe to rerun. Stops at the first failure.

set -eu

dir="$(cd "$(dirname "$0")" && pwd)"

for script in \
  install-chrome.sh \
  install-codex.sh \
  install-docker.sh \
  install-fcitx5.sh \
  install-ghostty.sh \
  install-vscode.sh
do
  echo "==> $script"
  "$dir/$script"
done

cat <<'MSG'

All system-level installs finished. Log out and back in so the docker
group and the Fcitx5 input method take effect.
MSG
