
export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export EDITOR='vim'

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

source $HOME/.zshrc.oh-my-zsh
source $ZSH/oh-my-zsh.sh

source $HOME/.zshrc.common
source $HOME/.zshrc.peco

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

## load user .zshrc configuration file
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local

