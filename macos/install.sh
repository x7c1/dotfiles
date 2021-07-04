#!/bin/sh

set -xue

main() {
  setup_dirs
  setup_brew
  setup_zsh
  setup_peco
  setup_rust
}

macos_root="$(pwd)"/macos
shared_dir="$(pwd)"/shared
download_dir="$(pwd)"/download.tmp

setup_dirs() {
  [ -d "$download_dir" ] || \
    mkdir "$download_dir"

  [ -d ~/bin ] || \
    mkdir ~/bin
}

setup_brew() {
  if command -v brew; then
    echo "brew already installed"
    brew --version
    return
  fi

  # https://brew.sh/
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

setup_zsh() {
  if [ ! -e ~/.local.zshrc ]; then
    touch ~/.local.zshrc
    echo 'export PATH=${HOME}/bin:$PATH' >> ~/.local.zshrc
  fi

  if [ -d ~/.oh-my-zsh ]; then
    echo "oh-my-zsh already installed."
    echo "delete ~/.oh-my-zsh before re-installing."
  else
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    mv ~/.zshrc ~/.oh-my-zsh.zshrc.backup
  fi

  [ -e ~/.zshrc ] || \
    ln -s "$shared_dir"/.zshrc ~

  [ -e ~/.common.zshrc ] || \
    ln -s "$shared_dir"/.common.zshrc ~

  [ -e ~/.oh-my-zsh.zshrc ] || \
    ln -s "$shared_dir"/.oh-my-zsh.zshrc ~
}

setup_peco() {
  if [ -e ~/bin/peco ]; then
    echo "peco already installed."
    peco --version
    echo "delete ~/bin/peco before re-installing."
  else
    # see latest version at https://github.com/peco/peco/releases
    curl -L -O https://github.com/peco/peco/releases/download/v0.5.10/peco_darwin_arm64.zip
    unzip peco_darwin_arm64.zip
    mv peco_darwin_arm64/peco ~/bin/peco
    mv peco_darwin_arm64 "$download_dir"
    mv peco_darwin_arm64.zip "$download_dir"
  fi
  # see shared/.peco.zshrc
  touch ~/.cd_history_file

  [ -e ~/.peco ] || \
    ln -s "$shared_dir"/.peco ~

  [ -e ~/.peco.zshrc ] || \
    ln -s "$shared_dir"/.peco.zshrc ~
}

setup_rust() {
  if command -v rustc; then
    echo "rust already installed."
    rustc --version
    return
  fi
  # https://www.rust-lang.org/tools/install
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  source $HOME/.cargo/env
  cargo --version
}

main

