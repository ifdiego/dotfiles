#!/bin/bash

echo "Setting up Linux"
sudo apt update
sudo apt install \
  curl build-essential \
  wget git vim neofetch \
  htop nmap tmux openssh-client

sudo apt update
sudo apt upgrade

echo "Moving scripts to user directory"
cp .gitconfig $HOME/.gitconfig
cp .bashrc $HOME/.bashrc
cp .bash_aliases $HOME/.bash_aliases
cp .vim $HOME -r
cp .vimrc $HOME/.vimrc

echo "Installing VIM plugins"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
clear
vim -c "PlugInstall" -c "q" -c "q"

sudo apt update
sudo apt upgrade

source ~/.bashrc
