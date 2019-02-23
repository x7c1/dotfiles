
# http://blog.zoncoen.net/blog/2014/01/14/percol-autojump-with-zsh/
function exists { which $1 &> /dev/null }

function peco_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER # move cursor
    zle reset-prompt
}
zle -N peco_select_history

# http://stillpedant.hatenablog.com/entry/percol-cd-history
# cd 履歴を記録
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history_file # cd 履歴の記録先ファイル
function chpwd_record_history() {
    echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

# peco を使って cd 履歴の中からディレクトリを選択
# 過去の訪問回数が多いほど選択候補の上に来る
function peco_get_destination_from_history() {
    sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
        sed -e 's/^[ ]*[0-9]*[ ]*//' | \
        sed -e s"/^${HOME//\//\\/}/~/" | \
        peco | xargs echo
}

# peco を使って cd 履歴の中からディレクトリを選択して
# cd するウィジェット
function peco_cd_history() {
    local destination="$(peco_get_destination_from_history | sed 's/ /\\ /g')"
    if [[ $destination != "" ]]; then
        BUFFER="cd ${destination}"
        zle accept-line
        zle reset-prompt
    fi
}
zle -N peco_cd_history

# peco を使って cd 履歴の中からディレクトリを選択して
# 現在のカーソル位置に挿入するウィジェット
function peco_insert_history() {
    local destination="$(peco_get_destination_from_history | sed 's/ /\\ /g')"
    if [[ $destination != "" ]]; then
        local new_left="${LBUFFER}${destination} "
        BUFFER=${new_left}${RBUFFER}
        CURSOR=${#new_left}
        zle reset-prompt
    fi
}
zle -N peco_insert_history

function peco_select_from_git_status(){
    git status --porcelain | \
    peco | \
    awk -F ' ' '{for(i=2;i<NF;i++){printf("%s%s",$i,OFS="\\ ")}print $NF}' | \
    tr '\n' ' '
}

# git status の結果からファイルを選択して
# 現在のカーソル位置に挿入するウィジェット
function peco_insert_selected_git_files(){
    LBUFFER+=$(peco_select_from_git_status)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N peco_insert_selected_git_files

function peco_select_from_ps(){
    ps aux | \
    peco | \
    awk -F ' ' '{print $2}' | \
    tr '\n' ' '
}

# ps の結果からプロセスを選択してその ID を
# 現在のカーソル位置に挿入するウィジェット
function peco_insert_selected_ps_items(){
    LBUFFER+=$(peco_select_from_ps)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N peco_insert_selected_ps_items

function peco_select_from_git_log(){
    if ! exists gsed; then
        echo 'brew install gnu-sed'
        return
    fi

    git log --oneline --graph --all --decorate | \
    peco | \
    gsed -e "s/^\W\+\([0-9A-Fa-f]\+\).*$/\1/" | \
    tail -r | \
    tr '\n' ' '
}
# git log の結果からコミットを選択してそのハッシュを
# 現在のカーソル位置に挿入するウィジェット
function peco_insert_selected_git_hash() {
    LBUFFER+=$(peco_select_from_git_log)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N peco_insert_selected_git_hash

function peco_select_from_docker_ps(){
    if ! exists docker; then
        echo 'brew install docker'
        return
    fi
    docker ps | \
    peco | \
    awk -F ' ' '{print $1}' | \
    tr '\n' ' '
}

# docker ps の結果からコンテナを選択してその ID を
# 現在のカーソル位置に挿入するウィジェット
function peco_insert_selected_docker_ps_items(){
    LBUFFER+=$(peco_select_from_docker_ps)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N peco_insert_selected_docker_ps_items

function peco_select_from_docker_image(){
    if ! exists docker; then
        echo 'brew install docker'
        return
    fi
    docker images | \
    peco | \
    awk -F ' ' '{print $3}' | \
    tr '\n' ' '
}
# docker images の結果からイメージを選択してその ID を
# 現在のカーソル位置に挿入するウィジェット
function peco_insert_selected_docker_images(){
    LBUFFER+=$(peco_select_from_docker_image)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N peco_insert_selected_docker_images

bindkey '^g^j' peco_cd_history
bindkey '^g^h' peco_insert_history
bindkey "^g^s" peco_insert_selected_git_files
bindkey "^g^p" peco_insert_selected_ps_items
bindkey '^g^l' peco_insert_selected_git_hash
bindkey '^g^k' peco_select_history

bindkey '^gdp' peco_insert_selected_docker_ps_items
bindkey '^gdi' peco_insert_selected_docker_images

