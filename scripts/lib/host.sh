# Prints the home-manager configuration name for the current OS to stdout,
# or returns non-zero on an unsupported OS. Source this file and capture with:
#   host=$(detect_host) || exit 1
detect_host() {
  case "$(uname -s)" in
    Darwin) echo "x7c1@macos" ;;
    Linux)  echo "x7c1@ubuntu" ;;
    *) echo "Error: unsupported OS: $(uname -s)" >&2; return 1 ;;
  esac
}
