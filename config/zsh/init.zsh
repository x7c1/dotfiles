# Disable terminal flow control so ^s/^q are usable as keybinds.
stty -ixon

# Prefix-matching history search on ^p/^n
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# ^g^k: fzf history search (replaces unused ^r)
bindkey '^g^k' fzf-history-widget
bindkey -r '^r'

# ^g^j: zoxide interactive cd
fzf-zoxide-cd() {
  local dir
  dir=$(zoxide query -i 2>/dev/null) || return 0
  BUFFER="cd ${(q)dir}"
  zle accept-line
}
zle -N fzf-zoxide-cd
bindkey '^g^j' fzf-zoxide-cd

# ^g^p: pick process and insert PID
fzf-process-pid() {
  local pids
  pids=$(ps -ef | sed 1d | fzf -m --exit-0 | awk '{print $2}' | paste -sd ' ' -)
  [[ -n "$pids" ]] && LBUFFER+="$pids "
  zle reset-prompt
}
zle -N fzf-process-pid
bindkey '^g^p' fzf-process-pid

# ^g^s: pick changed files from git status
fzf-git-status() {
  local files
  files=$(git status -s 2>/dev/null | fzf -m --exit-0 | awk '{print $2}' | paste -sd ' ' -)
  [[ -n "$files" ]] && LBUFFER+="$files "
  zle reset-prompt
}
zle -N fzf-git-status
bindkey '^g^s' fzf-git-status

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
