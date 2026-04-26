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
