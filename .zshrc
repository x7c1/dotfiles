
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

## load user .zshrc configuration file
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local

