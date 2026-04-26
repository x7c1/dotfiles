# Track the last successfully-run command in the pane title so tmux #T
# (used by catppuccin window tabs) shows what was last run instead of
# the hostname. Failed commands do not stick.
autoload -U add-zsh-hook

typeset -g _tmux_title=""
typeset -g _tmux_pending=""

_tmux_title_preexec() {
  _tmux_pending="${1%% *}"
  print -Pn "\e]2;${_tmux_pending}\a"
}
add-zsh-hook preexec _tmux_title_preexec

_tmux_title_precmd() {
  local exit_status=$?
  if [[ -z "$_tmux_title" ]]; then
    _tmux_title="zsh"
    print -Pn "\e]2;${_tmux_title}\a"
  fi
  if [[ -n "$_tmux_pending" ]]; then
    if [[ $exit_status -eq 0 ]]; then
      _tmux_title="$_tmux_pending"
    else
      print -Pn "\e]2;${_tmux_title}\a"
    fi
    _tmux_pending=""
  fi
}
add-zsh-hook precmd _tmux_title_precmd
