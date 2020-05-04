# no beep sound when complete list displayed
setopt nolistbeep

# vim like keybind
bindkey -v

bindkey '^r' history-incremental-search-backward

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# ignore duplication command history list
setopt hist_ignore_dups

# share command history data
setopt share_history

# no duplicate
setopt HIST_IGNORE_ALL_DUPS

# http://d.hatena.ne.jp/voidy21/20090902/1251918174
function cd(){
  builtin cd $@ && \
    ls -Alt --reverse --color --time-style="+%Y-%m-%d %H:%M:%S" |\
      awk '{c="";for(i=6;i<=NF;i++) c=c $i " "; print c}' |\
      sed '/^ *$/d' |\
      cat -n |\
      tail -10
}

# git_prompt_status
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}:a"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}:m"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}:deleted"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}:renamed"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}:unmerged"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}:+"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}⎇  %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

function git_message() {
  info=$(git_prompt_info)
  if [[ ${info} = "" ]]; then
    echo ""
  else
    echo "${info}$(git_prompt_status)%{$reset_color%} "
  fi
}

EXIT="exit(%{$fg[red]%}%?%{$reset_color%}%)"
NEWLINE=$'\n'
return_code="%(?.. ${EXIT}${NEWLINE}>)"

PROMPT='${NEWLINE}>${return_code} %* $(git_message)%~${NEWLINE}$ '
unset RPROMPT

