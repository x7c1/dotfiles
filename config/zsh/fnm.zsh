# Initialise fnm so that .nvmrc / .node-version files in a directory
# are picked up automatically when cd'ing into it.
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --log-level quiet)"
fi
