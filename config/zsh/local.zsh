[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# Re-pin the canonical PATH order at the end of zsh init. Earlier steps
# (Homebrew via ~/.zprofile, hm-session-vars appending, and any prepends
# in ~/.zshrc.local) leave the PATH in a less ideal order; this sets the
# intended priority: user-local scripts > Nix profile > other package
# managers. `typeset -U path` keeps the array deduped.
typeset -U path
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.nix-profile/bin"
  "/nix/var/nix/profiles/default/bin"
  $path
)
