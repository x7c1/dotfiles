
# https://github.com/nvm-sh/nvm
export NVM_DIR="$(\
  [ -z "${XDG_CONFIG_HOME-}" ] && \
  printf %s "${HOME}/.nvm" || \
  printf %s "${XDG_CONFIG_HOME}/nvm"\
)"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  # This loads nvm
  . "$NVM_DIR/nvm.sh"
fi

