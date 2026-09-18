# Prints the home-manager configuration name for the current machine to stdout,
# or returns non-zero on an unsupported OS. Source this file and capture with:
#   host=$(detect_host) || exit 1
#
# Machines that need a profile other than the per-OS default record it in
# ~/.config/dotfiles/host (a single line, e.g. "x7c1@ubuntu-laptop"). Keeping
# it on disk rather than in an env var means sync.sh picks it up even when it
# runs non-interactively.
detect_host() {
  local override_file="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/host"
  local override

  if [ -r "$override_file" ]; then
    override=$(head -n1 "$override_file" | tr -d '[:space:]')
    if [ -n "$override" ]; then
      echo "$override"
      return 0
    fi
  fi

  case "$(uname -s)" in
    Darwin) echo "x7c1@macos" ;;
    Linux)  echo "x7c1@ubuntu" ;;
    *) echo "Error: unsupported OS: $(uname -s)" >&2; return 1 ;;
  esac
}
