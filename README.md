#### Prerequisite ####

* Homebrew : http://brew.sh/
* oh-my-zsh : http://ohmyz.sh/

#### Usage ####

* .vimrc.local

 ```
 source $path-to-this-dotfiles/theme/x7c1_Novel_16colors.vim
 ```

* Terminal > Settings > import

 > theme/x7c1_Novel.terminal
 
* create symbolic links as necessary

 ```
 ln -s `pwd`/.zshrc.common $HOME/.zshrc.common
 ```
 (or more simply)
 ```
 ruby init-links.rb .zshrc .zshrc.common .vimrc
 ```
