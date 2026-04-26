# Track the last command in the pane title so tmux #T (used by catppuccin
# window tabs) shows what was last run instead of the hostname.
autoload -U add-zsh-hook

_tmux_title_init() {
  print -Pn '\e]2;zsh\a'
  add-zsh-hook -d precmd _tmux_title_init
}
add-zsh-hook precmd _tmux_title_init

_tmux_title_preexec() {
  print -Pn "\e]2;${1%% *}\a"
}
add-zsh-hook preexec _tmux_title_preexec
