if [ "$(whoami)" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg_bold[red]%}:( %?%{$reset_color%})"

PROMPT='
%{${fg[blue]}%}%# %2d $(git_prompt_info)
%{${fg[$CARETCOLOR]}%}%# %{${reset_color}%}'

RPS1='%{${fg[blue]}%}%~%{$reset_color%}${return_code}%{${fg[cyan]}%} %D %{${fg_bold[red]}%}%*%{${reset_color}%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}^%{$reset_color%}%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} !"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[red]%} :)"
