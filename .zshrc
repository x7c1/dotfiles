
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

export ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
# Optionally, if "random" is set,
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="random"
ZSH_THEME="robbyrussell"

# plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

export PATH=$HOME/bin:/usr/local/bin:$PATH

source $ZSH/oh-my-zsh.sh

source $HOME/.zshrc.common

export LANG=en_US.UTF-8

export EDITOR='vim'

# no duplicate
setopt HIST_IGNORE_ALL_DUPS

# http://blog.zoncoen.net/blog/2014/01/14/percol-autojump-with-zsh/
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }
    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

# http://stillpedant.hatenablog.com/entry/percol-cd-history
# {{{
# cd 履歴を記録
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history_file # cd 履歴の記録先ファイル
function chpwd_record_history() {
    echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

# percol を使って cd 履歴の中からディレクトリを選択
# 過去の訪問回数が多いほど選択候補の上に来る
function percol_get_destination_from_history() {
    sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
        sed -e 's/^[ ]*[0-9]*[ ]*//' | \
        sed -e s"/^${HOME//\//\\/}/~/" | \
        percol | xargs echo
}

# percol を使って cd 履歴の中からディレクトリを選択し cd するウィジェット
function percol_cd_history() {
    local destination=$(percol_get_destination_from_history)
    [ -n $destination ] && cd ${destination/#\~/${HOME}}
    zle reset-prompt
}
zle -N percol_cd_history

# percol を使って cd 履歴の中からディレクトリを選択し，現在のカーソル位置に挿入するウィジェット
function percol_insert_history() {
    local destination=$(percol_get_destination_from_history)
    if [ $? -eq 0 ]; then
        local new_left="${LBUFFER} ${destination} "
        BUFFER=${new_left}${RBUFFER}
        CURSOR=${#new_left}
    fi
    zle reset-prompt
}
zle -N percol_insert_history
# }}}

bindkey '^gj' percol_cd_history
bindkey '^gi' percol_insert_history

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

## load user .zshrc configuration file
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local

