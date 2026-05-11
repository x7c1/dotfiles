#!/usr/bin/env bash
set -euo pipefail

# Lazy! sync = install missing + update existing + prune removed
nvim --headless "+Lazy! sync" +qa
