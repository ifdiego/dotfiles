#!/bin/bash

installation() {
  sudo apt update
  sudo apt install build-essential git curl wget vim neofetch htop nmap tmux neovim
  sudo apt upgrade
  echo "Installation completed"
}

symlinks() {
  cp .gitconfig $HOME/.gitconfig
  cp .bashrc $HOME/.bashrc
  cp .bash_aliases $HOME/.bash_aliases
  echo "Symlinks files copied"
}

installation
symlinks

source ~/.bashrc
