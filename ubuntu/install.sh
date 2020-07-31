#!/bin/sh

set -x
set -u
set -e

main() {
  sudo apt update
  install_packages

  setup_dirs
  setup_gnome_settings
  setup_git_config
  setup_tmux
  setup_vim
  setup_zsh
  setup_peco
  setup_rust
  setup_cargo_apps
  setup_xkb
  setup_aws_cli
  setup_terraform
  setup_nvm
  setup_docker_compose
  setup_docker
}

dotfiles_root="$(pwd)"
ubuntu_root="$(pwd)"/ubuntu
shared_dir="$(pwd)"/shared
download_dir="$(pwd)"/download.tmp

install_packages() {
  sudo apt install -y \
    build-essential \
    postgresql-client \
    tig \
    jq \
    expect \
    tree
}

setup_dirs() {
  [ -d "$download_dir" ] || \
    mkdir "$download_dir"

  [ -d ~/bin ] || \
    mkdir ~/bin
}

setup_gnome_settings() {

  # change key repeat rate
  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
  gsettings set org.gnome.desktop.peripherals.keyboard delay 175

  # disable window snapping
  # rf. https://askubuntu.com/a/1029186
  gsettings set org.gnome.mutter edge-tiling false
  gsettings set org.gnome.shell.overrides edge-tiling false

}

setup_git_config() {
  git config --global interactive.singlekey true
  sudo apt install -y libterm-readkey-perl
}

setup_tmux() {
  sudo apt install -y tmux

  [ -e ~/.tmux.conf ] || \
    ln -s "$shared_dir"/.tmux.conf ~
}

setup_vim() {
  sudo apt install -y \
    neovim \
    curl

  [ -e ~/.config/nvim ] || \
    ln -s "$ubuntu_root"/nvim ~/.config

  if [ -d ~/.cache/dein ]; then
    echo "dein already installed."
    echo "delete ~/.cache/dein before re-installing."
    return
  fi

  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh \
    > dein-installer.sh

  sh ./dein-installer.sh ~/.cache/dein
  mv ./dein-installer.sh "$download_dir"
}

setup_zsh() {
  sudo apt install -y zsh

  if [ ! -e ~/.local.zshrc ]; then
    cp "$ubuntu_root"/.local.zshrc.template ~/.local.zshrc
    . ~/.local.zshrc
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
    echo "delete ~/bin/peco before re-installing."
  else
    # see latest version at https://github.com/peco/peco/releases
    curl -L -O https://github.com/peco/peco/releases/download/v0.5.7/peco_linux_amd64.tar.gz
    tar -xvf peco_linux_amd64.tar.gz
    mv peco_linux_amd64/peco ~/bin/peco
    mv peco_linux_amd64 "$download_dir"
    mv peco_linux_amd64.tar.gz "$download_dir"
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
    return
  fi
  # https://www.rust-lang.org/tools/install
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  # see .local.zshrc.template about path settings
}

setup_cargo_apps() {
  # https://github.com/sharkdp/bat
  cargo install --locked bat
}

setup_xkb() {
  [ -e ~/.xkb ] || \
    ln -s "$ubuntu_root"/.xkb ~
}

setup_aws_cli() {
  if command -v aws; then
    echo "aws already installed."
    return
  fi
  cd $download_dir

  # https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O
  unzip awscli-exe-linux-x86_64.zip

  cd aws
  sudo ./install

  cd $dotfiles_root
}

setup_terraform() {
  if command -v terraform; then
    echo "terraform already installed."
    return
  fi
  cd $download_dir

  # https://www.terraform.io/downloads.html
  version="0.12.29"
  curl https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip -O
  unzip terraform_${version}_linux_amd64.zip
  mv terraform ~/bin

  cd $dotfiles_root
}

setup_nvm() {
  . $ubuntu_root/export_nvm.sh

  if command -v nvm; then
    echo "nvm already installed."
    return
  fi
  # https://github.com/nvm-sh/nvm/releases
  version="0.35.3"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$version/install.sh | bash

  cat $ubuntu_root/export_nvm.sh >> ~/.local.zshrc
  . $ubuntu_root/export_nvm.sh

  nvm install node
  nvm use node
}

setup_docker_compose() {
  if command -v docker-compose; then
    echo "docker-compose already installed."
    return
  fi
  # https://github.com/docker/compose/releases
  version="1.26.2"
  url="https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)"
  sudo curl -L $url -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

setup_docker() {
  if command -v docker; then
    echo "docker already installed."
    return
  fi
  sudo apt install -y docker.io
  sudo systemctl start docker

  sudo systemctl enable docker
  # above line creates following symlink:
  # /etc/systemd/system/multi-user.target.wants/docker.service
  # → /lib/systemd/system/docker.service.

  sudo addgroup --system docker
  sudo adduser $USER docker

  echo "logout and login again."
  echo "type: gnome-session-quit"
}

main

