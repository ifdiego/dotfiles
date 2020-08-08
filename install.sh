#!/bin/bash

installation() {
  sudo apt update
  sudo apt install curl
  sudo apt install build-essential
  sudo apt install wget
  sudo add-apt-repository ppa:git-core/ppa
  sudo apt update
  sudo apt install git
  sudo apt install vim
  sudo apt install neofetch
  sudo apt install htop
  sudo apt install nmap
  sudo apt ubuntu-restricted-extras
  sudo apt install tmux
  sudo apt install binwalk
  sudo apt install qemu
  sudo apt install gnupg
  sudo apt install cowsay
  sudo apt install tree
  sudo apt install net-tools
  #sudo apt install neovim
  #sudo apt install openssh-server
  sudo apt update
  sudo apt upgrade
  echo "Installation completed"
}

symlinks() {
  cp .gitconfig $HOME/.gitconfig
  cp .bashrc $HOME/.bashrc
  cp .bash_aliases $HOME/.bash_aliases
  cp .vim $HOME -r
  cp .vimrc $HOME/.vimrc
  echo "Symlinks files copied"
}

languages() {
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt install nodejs
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  sudo apt update
  sudo apt install yarn

  wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
  sudo apt update
  sudo apt install esl-erlang
  sudo apt install elixir

  sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
  sudo apt install clang

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

installation
languages
symlinks

source ~/.bashrc
