# Track the last successfully-run command in the tmux window name so the
# tab shows what was last run instead of the auto-renamed process name.
# Failed commands do not stick. Requires `automatic-rename off` in tmux.conf.
[[ -z "$TMUX" ]] && return

autoload -U add-zsh-hook

typeset -g _tmux_title=""
typeset -g _tmux_pending=""

_tmux_title_preexec() {
  _tmux_pending="${1%% *}"
  tmux rename-window "$_tmux_pending"
}
add-zsh-hook preexec _tmux_title_preexec

_tmux_title_precmd() {
  local exit_status=$?
  if [[ -z "$_tmux_title" ]]; then
    _tmux_title="zsh"
    tmux rename-window "$_tmux_title"
  fi
  if [[ -n "$_tmux_pending" ]]; then
    if [[ $exit_status -eq 0 ]]; then
      _tmux_title="$_tmux_pending"
    else
      tmux rename-window "$_tmux_title"
    fi
    _tmux_pending=""
  fi
}
add-zsh-hook precmd _tmux_title_precmd
